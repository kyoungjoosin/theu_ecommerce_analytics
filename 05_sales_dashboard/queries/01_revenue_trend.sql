-- 월별 매출 및 주문 추이
-- 예치금 상품 제외, 취소/반품 제외한 순매출 기준

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m')  AS order_month,
    COUNT(DISTINCT o.orderid)           AS order_cnt,
    SUM(oi.price * oi.amount)           AS gross_revenue,
    SUM(CASE WHEN c.coupon_id IS NOT NULL
             THEN c.discount_amount ELSE 0 END) AS coupon_discount,
    SUM(oi.price * oi.amount)
        - SUM(CASE WHEN c.coupon_id IS NOT NULL
                   THEN c.discount_amount ELSE 0 END) AS net_revenue
FROM orders o
JOIN order_items oi  ON o.orderid    = oi.orderid
LEFT JOIN coupons c  ON o.orderid    = c.orderid
WHERE o.order_status NOT IN ('cancel', 'return')   -- 취소/반품 제외
  AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY order_month;
