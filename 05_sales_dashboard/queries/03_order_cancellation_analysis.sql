/*
프로젝트: 취소·반품 주문 분석

- 취소 및 반품 주문 현황 분석
- 고객 유형별 취소/반품 패턴 분석
- 상품 카테고리별 취소/반품 현황 분석
- 실제 운영 환경의 테이블명, 컬럼명, 코드값은 보안상 일반화하여 작성
*/

SELECT
    o.orderid,
    o.order_date,
    CASE
        WHEN m.customer_type = 'A' THEN '약국'
        WHEN m.customer_type = 'B' THEN '병원'
        WHEN m.customer_type = 'C' THEN '임직원'
        ELSE m.customer_type
    END AS customer_type,
    oi.product_code,
    p.product_name,
    CASE
        WHEN p.product_category = 'A' THEN '일반상품'
        WHEN p.product_category = 'B' THEN '전문상품'
        WHEN p.product_category = 'C' THEN '기타상품'
        ELSE '기타'
    END AS product_category,
    oi.quantity,
    oi.unit_price,
    oi.discount_price,
    o.total_price,
    o.coupon_discount,
    o.order_status,
    -- 운영 정책 기준 취소/반품 분류
    CASE
        WHEN oi.cancel_date IS NOT NULL
             AND oi.process_type = 'cancel'
        THEN '취소'
        WHEN oi.cancel_date IS NOT NULL
             AND oi.process_type = 'return'
        THEN '반품'
        ELSE '기타'
    END AS cancel_type
FROM order_returns oi
JOIN orders o ON o.orderid = oi.orderid
JOIN members m ON o.member_id = m.member_id
JOIN products p ON oi.product_code = p.product_code
WHERE o.order_status IS NOT NULL
  AND oi.cancel_date >= DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 3 YEAR), '%Y-01-01')
ORDER BY oi.cancel_date
;
