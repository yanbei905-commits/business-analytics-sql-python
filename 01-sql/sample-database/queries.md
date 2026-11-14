# 示例数据库练习查询（商业分析视角）

先运行 `schema.sql` 再运行 `sample_data.sql`，然后用下面的查询练习。

建议工具：
- DB Browser for SQLite（可视化，推荐新手）
- VS Code SQLite 扩展
- Python + sqlite3 / SQLAlchemy

---

## 1. 基础查询

### 1.1 查看所有客户
```sql
SELECT * FROM customers;
```

### 1.2 查看销售额最高的订单
```sql
SELECT order_id, customer_id, order_date, total_amount
FROM orders
WHERE order_status = '已完成'
ORDER BY total_amount DESC
LIMIT 5;
```

### 1.3 统计每个品类的产品数量
```sql
SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY category
ORDER BY product_count DESC;
```

---

## 2. 业务核心指标

### 2.1 总销售额、总订单数、客单价
```sql
SELECT 
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM orders
WHERE order_status = '已完成';
```

### 2.2 每月销售额趋势
```sql
SELECT 
    strftime('%Y-%m', order_date) AS month,
    COUNT(*) AS order_count,
    ROUND(SUM(total_amount), 2) AS revenue
FROM orders
WHERE order_status = '已完成'
GROUP BY strftime('%Y-%m', order_date)
ORDER BY month;
```

### 2.3 各门店销售表现
```sql
SELECT 
    s.store_name,
    s.city,
    s.store_type,
    COUNT(o.order_id) AS order_count,
    ROUND(SUM(o.total_amount), 2) AS revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM stores s
LEFT JOIN orders o ON s.store_id = o.store_id AND o.order_status = '已完成'
GROUP BY s.store_id
ORDER BY revenue DESC;
```

---

## 3. JOIN 练习

### 3.1 订单明细 + 产品信息
```sql
SELECT 
    o.order_id,
    o.order_date,
    p.product_name,
    p.category,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price - oi.discount AS line_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status = '已完成'
ORDER BY o.order_date, o.order_id;
```

### 3.2 各品类销售额与销量
```sql
SELECT 
    p.category,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.quantity * oi.unit_price - oi.discount), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = '已完成'
GROUP BY p.category
ORDER BY revenue DESC;
```

---

## 4. 客户分析

### 4.1 每个客户的订单数与消费金额
```sql
SELECT 
    c.customer_id,
    c.first_name || c.last_name AS customer_name,
    c.city,
    COUNT(o.order_id) AS order_count,
    ROUND(SUM(o.total_amount), 2) AS total_spent,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.order_status = '已完成'
GROUP BY c.customer_id
ORDER BY total_spent DESC;
```

### 4.2 复购客户（下单 ≥ 2 次）
```sql
SELECT 
    c.customer_id,
    c.first_name || c.last_name AS customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = '已完成'
GROUP BY c.customer_id
HAVING COUNT(o.order_id) >= 2
ORDER BY order_count DESC;
```

---

## 5. 进阶（窗口函数 / CTE）

### 5.1 每个品类销售额排名
```sql
WITH category_sales AS (
    SELECT 
        p.category,
        ROUND(SUM(oi.quantity * oi.unit_price - oi.discount), 2) AS revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status = '已完成'
    GROUP BY p.category
)
SELECT 
    category,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank,
    ROUND(revenue * 100.0 / SUM(revenue) OVER (), 2) AS pct_of_total
FROM category_sales;
```

### 5.2 客户累计消费（按时间）
```sql
SELECT 
    c.first_name || c.last_name AS customer_name,
    o.order_date,
    o.total_amount,
    SUM(o.total_amount) OVER (
        PARTITION BY c.customer_id 
        ORDER BY o.order_date
    ) AS cumulative_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = '已完成'
ORDER BY c.customer_id, o.order_date;
```

---

## 练习建议

1. 先把上面查询全部跑通，理解结果。
2. 自己改条件：比如只看 2024 年、只看线上、只看某个城市。
3. 尝试回答这些问题：
   - 哪个品类毛利最高？（需要 cost 字段）
   - 哪个城市的客户平均消费最高？
   - 2024 年比 2023 年销售额增长了多少？
4. 把你觉得有价值的查询保存下来，写进自己的笔记。

需要我根据你的进度再出更难的练习题，随时说！
