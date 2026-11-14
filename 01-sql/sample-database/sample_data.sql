-- ============================================================
-- 示例数据（精简版，足够练习各种业务查询）
-- 使用方法：先执行 schema.sql，再执行本文件
-- ============================================================

-- 清空旧数据（按依赖顺序）
DELETE FROM order_items;
DELETE FROM orders;
DELETE FROM products;
DELETE FROM customers;
DELETE FROM stores;

-- ==================== 门店 ====================
INSERT INTO stores (store_id, store_name, city, province, store_type, open_date) VALUES
(1, '上海静安旗舰店', '上海', '上海', '旗舰店', '2020-03-15'),
(2, '北京朝阳标准店', '北京', '北京', '标准店', '2019-08-20'),
(3, '广州天河社区店', '广州', '广东', '社区店', '2021-01-10'),
(4, '深圳南山标准店', '深圳', '广东', '标准店', '2020-11-05'),
(5, '官方线上商城', '全国', '全国', '线上', '2018-06-01');

-- ==================== 客户 ====================
INSERT INTO customers (customer_id, first_name, last_name, email, phone, city, province, registration_date, gender, age_group) VALUES
(1, '张', '伟', 'zhangwei@email.com', '13800001001', '上海', '上海', '2021-02-15', 'M', '25-34'),
(2, '李', '娜', 'lina@email.com', '13800001002', '北京', '北京', '2020-11-20', 'F', '25-34'),
(3, '王', '强', 'wangqiang@email.com', '13800001003', '广州', '广东', '2022-01-08', 'M', '35-44'),
(4, '刘', '芳', 'liufang@email.com', '13800001004', '深圳', '广东', '2021-07-12', 'F', '18-24'),
(5, '陈', '明', 'chenming@email.com', '13800001005', '上海', '上海', '2019-09-30', 'M', '45-54'),
(6, '杨', '雪', 'yangxue@email.com', '13800001006', '北京', '北京', '2022-03-22', 'F', '25-34'),
(7, '赵', '磊', 'zhaolei@email.com', '13800001007', '广州', '广东', '2020-05-18', 'M', '35-44'),
(8, '黄', '丽', 'huangli@email.com', '13800001008', '深圳', '广东', '2021-12-01', 'F', '25-34'),
(9, '周', '杰', 'zhoujie@email.com', '13800001009', '上海', '上海', '2023-01-15', 'M', '18-24'),
(10, '吴', '婷', 'wuting@email.com', '13800001010', '北京', '北京', '2020-08-09', 'F', '35-44');

-- ==================== 产品 ====================
INSERT INTO products (product_id, product_name, category, subcategory, brand, unit_price, cost, stock_quantity) VALUES
(1, '无线蓝牙耳机 Pro', '电子', '耳机', 'SoundMax', 399.00, 180.00, 150),
(2, '智能手表 S3', '电子', '可穿戴', 'TechLife', 1299.00, 650.00, 80),
(3, '纯棉基础T恤', '服装', '上装', 'BasicWear', 89.00, 25.00, 500),
(4, '休闲牛仔裤', '服装', '下装', 'DenimCo', 259.00, 90.00, 300),
(5, '护肤精华液 50ml', '美妆', '护肤', 'GlowSkin', 298.00, 80.00, 200),
(6, '口红套装', '美妆', '彩妆', 'ColorPop', 199.00, 45.00, 250),
(7, '北欧风台灯', '家居', '灯具', 'HomeArt', 159.00, 55.00, 120),
(8, '记忆棉枕头', '家居', '床品', 'SleepWell', 189.00, 60.00, 180),
(9, '有机坚果礼盒', '食品', '零食', 'NatureBite', 128.00, 48.00, 400),
(10, '进口咖啡豆 500g', '食品', '饮料', 'BrewMaster', 98.00, 35.00, 350),
(11, '运动跑鞋', '服装', '鞋类', 'RunFast', 499.00, 180.00, 220),
(12, '便携蓝牙音箱', '电子', '音箱', 'SoundMax', 249.00, 95.00, 160);

-- ==================== 订单 + 明细（2023-2024 数据） ====================
-- 订单 1
INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(1, 1, 1, '2023-03-15', '已完成', '微信', 688.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(1, 1, 1, 1, 399.00, 0),
(2, 1, 3, 2, 89.00, 0),
(3, 1, 9, 1, 128.00, 17.00);

-- 订单 2
INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(2, 2, 2, '2023-04-02', '已完成', '支付宝', 1597.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(4, 2, 2, 1, 1299.00, 0),
(5, 2, 5, 1, 298.00, 0);

-- 订单 3
INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(3, 3, 3, '2023-05-20', '已完成', '信用卡', 348.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(6, 3, 4, 1, 259.00, 0),
(7, 3, 3, 1, 89.00, 0);

-- 订单 4
INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(4, 4, 4, '2023-06-11', '已完成', '微信', 497.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(8, 4, 6, 1, 199.00, 0),
(9, 4, 5, 1, 298.00, 0);

-- 订单 5
INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(5, 5, 1, '2023-07-08', '已完成', '支付宝', 1548.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(10, 5, 2, 1, 1299.00, 50.00),
(11, 5, 7, 1, 159.00, 0),
(12, 5, 8, 1, 189.00, 49.00);

-- 订单 6
INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(6, 1, 5, '2023-08-22', '已完成', '微信', 399.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(13, 6, 1, 1, 399.00, 0);

-- 订单 7
INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(7, 6, 2, '2023-09-14', '已完成', '支付宝', 587.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(14, 7, 11, 1, 499.00, 0),
(15, 7, 3, 1, 89.00, 0);

-- 订单 8
INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(8, 7, 3, '2023-10-05', '已完成', '现金', 226.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(16, 8, 9, 1, 128.00, 0),
(17, 8, 10, 1, 98.00, 0);

-- 订单 9
INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(9, 8, 4, '2023-11-18', '已完成', '微信', 648.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(18, 9, 12, 1, 249.00, 0),
(19, 9, 1, 1, 399.00, 0);

-- 订单 10
INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(10, 2, 5, '2023-12-25', '已完成', '支付宝', 1788.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(20, 10, 2, 1, 1299.00, 100.00),
(21, 10, 6, 1, 199.00, 0),
(22, 10, 5, 1, 298.00, 0),
(23, 10, 9, 1, 128.00, 36.00);

-- 2024 订单
INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(11, 9, 1, '2024-01-20', '已完成', '微信', 588.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(24, 11, 11, 1, 499.00, 0),
(25, 11, 3, 1, 89.00, 0);

INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(12, 10, 2, '2024-02-14', '已完成', '支付宝', 447.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(26, 12, 5, 1, 298.00, 0),
(27, 12, 7, 1, 159.00, 10.00);

INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(13, 1, 5, '2024-03-08', '已完成', '微信', 827.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(28, 13, 4, 2, 259.00, 50.00),
(29, 13, 8, 1, 189.00, 0),
(30, 13, 10, 1, 98.00, 0);

INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(14, 3, 3, '2024-04-12', '已完成', '信用卡', 1299.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(31, 14, 2, 1, 1299.00, 0);

INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(15, 4, 4, '2024-05-01', '已完成', '微信', 348.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(32, 15, 1, 1, 399.00, 51.00);

INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(16, 6, 2, '2024-06-18', '已完成', '支付宝', 696.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(33, 16, 6, 2, 199.00, 0),
(34, 16, 9, 1, 128.00, 0),
(35, 16, 3, 2, 89.00, 0);

INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(17, 5, 1, '2024-07-22', '已完成', '支付宝', 987.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(36, 17, 12, 1, 249.00, 0),
(37, 17, 11, 1, 499.00, 0),
(38, 17, 8, 1, 189.00, 0),
(39, 17, 10, 1, 98.00, 48.00);

INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(18, 8, 5, '2024-08-30', '已完成', '微信', 457.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(40, 18, 5, 1, 298.00, 0),
(41, 18, 7, 1, 159.00, 0);

INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(19, 7, 3, '2024-09-15', '已完成', '现金', 259.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(42, 19, 4, 1, 259.00, 0);

INSERT INTO orders (order_id, customer_id, store_id, order_date, order_status, payment_method, total_amount) VALUES
(20, 2, 2, '2024-10-10', '已完成', '支付宝', 1697.00);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(43, 20, 2, 1, 1299.00, 0),
(44, 20, 1, 1, 399.00, 0);

SELECT 'Sample data inserted successfully. 20 orders, 10 customers, 12 products, 5 stores.' AS message;
