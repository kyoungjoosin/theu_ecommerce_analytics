/*
프로젝트: 쇼핑몰 매출 분석 대시보드

- 월별 매출 및 주문 추이 분석
- 고객 유형별 매출 분석
- 활성/휴면 고객 분류
- 실제 운영 DB의 테이블명, 컬럼명, 코드값은 보안상 샘플 데이터 구조로 변경하여 작성
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
    CASE
        WHEN MAX(o.order_date) >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
        THEN '활성'
        ELSE '휴면'
    END AS member_status
    oi.product_name,
    -- 총 주문금액
    ((oi.unit_price - oi.discount_price) * oi.quantity) AS gross_revenue,
    -- 쿠폰 할인액
    o.coupon_use AS coupon_discount
FROM orders o
JOIN order_items oi  ON o.orderid   = oi.orderid
JOIN members m       ON o.member_id = m.member_id
JOIN products p      ON oi.product_code  = p.product_code
WHERE o.order_status NOT IN ('cancelled')
  AND o.order_status != ''
  -- 특정 상품 유형 필터링은 실제 운영 환경 기준에 따라 적용
  AND o.order_date >= DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 3 YEAR),'%Y-01-01')
;
