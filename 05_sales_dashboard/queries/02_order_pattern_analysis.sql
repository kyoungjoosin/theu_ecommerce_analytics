/*
프로젝트: 쇼핑몰 주문 패턴 분석

- 고객 유형별 주문 패턴 분석
- 쿠폰 사용 현황 분석
- 주문 금액 구간 분포 분석
- 실제 운영 환경의 테이블명, 컬럼명, 코드값은 보안상 일반화하여 작성
*/

SELECT
    o.order_date,
    o.orderid,
    CASE
        WHEN m.customer_type = 'A' THEN '약국'
        WHEN m.customer_type = 'B' THEN '병원'
    	  WHEN m.customer_type = 'C' THEN '임직원'
    	  ELSE m.customer_type
    END AS customer_type,
    o.total_price AS order_amount, 
    o.coupon_discount,
    -- 주문 원금액 
    SUM(oi.unit_price * oi.quantity) AS original_amount, 
    -- 할인 금액 
    SUM(oi.discount_price * oi.quantity) AS discount_amount, 
    -- 쿠폰 사용 여부 
    CASE 
      WHEN o.coupon_discount > 0 THEN '쿠폰사용' 
      ELSE '쿠폰미사용' 
    END AS coupon_usage,
    -- 주문금액 구간 
    CASE WHEN o.total_price < 10000 THEN '1만원 미만' 
      WHEN o.total_price BETWEEN 10000 AND 49999 THEN '1만~5만원' 
      WHEN o.total_price BETWEEN 50000 AND 299999 THEN '5만~30만원' 
      WHEN o.total_price BETWEEN 300000 AND 999999 THEN '30만~100만원' 
      ELSE '100만원 이상' 
    END AS order_amount_range
JOIN members m ON o.member_id = m.member_id
JOIN order_items oi ON o.orderid = oi.orderid
JOIN products p ON oi.product_code = p.product_code
WHERE o.order_status NOT IN ('cancelled')
  AND o.order_status != ''
  AND o.order_date >= DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 3 YEAR),'%Y-01-01')
GROUP BY
o.orderid,
o.order_date,
m.customer_type,
o.total_price,
o.coupon_discount
ORDER BY o.order_date;
;
