-- ============================================================
-- 零售业务示例数据库 Schema (SQLite 兼容)
-- 场景：中小型连锁零售 / 电商
-- 适合练习：销售分析、客户分析、产品表现、门店对比
-- ============================================================

-- 客户表
CREATE TABLE IF NOT EXISTS customers (
    customer_id     INTEGER PRIMARY KEY,
    first_name      TEXT NOT NULL,
    last_name       TEXT NOT NULL,
    email           TEXT UNIQUE,
    phone           TEXT,
    city            TEXT,
    province        TEXT,
    registration_date DATE NOT NULL,
    gender          TEXT CHECK(gender IN ('M', 'F', 'Other')),
    age_group       TEXT  -- e.g. '18-24', '25-34', '35-44', '45-54', '55+'
);

-- 产品表
CREATE TABLE IF NOT EXISTS products (
    product_id      INTEGER PRIMARY KEY,
    product_name    TEXT NOT NULL,
    category        TEXT NOT NULL,  -- 电子、服装、家居、美妆、食品...
    subcategory     TEXT,
    brand           TEXT,
    unit_price      REAL NOT NULL CHECK(unit_price > 0),
    cost            REAL NOT NULL CHECK(cost >= 0),
    stock_quantity  INTEGER DEFAULT 0
);

-- 门店表
CREATE TABLE IF NOT EXISTS stores (
    store_id        INTEGER PRIMARY KEY,
    store_name      TEXT NOT NULL,
    city            TEXT NOT NULL,
    province        TEXT NOT NULL,
    store_type      TEXT CHECK(store_type IN ('旗舰店', '标准店', '社区店', '线上')),
    open_date       DATE
);

-- 订单表
CREATE TABLE IF NOT EXISTS orders (
    order_id        INTEGER PRIMARY KEY,
    customer_id     INTEGER NOT NULL,
    store_id        INTEGER NOT NULL,
    order_date      DATE NOT NULL,
    order_status    TEXT DEFAULT '已完成' CHECK(order_status IN ('已完成', '已取消', '退货')),
    payment_method  TEXT,  -- 微信、支付宝、信用卡、现金
    total_amount    REAL,  -- 可冗余存储，也可通过明细计算
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

-- 订单明细表
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id   INTEGER PRIMARY KEY,
    order_id        INTEGER NOT NULL,
    product_id      INTEGER NOT NULL,
    quantity        INTEGER NOT NULL CHECK(quantity > 0),
    unit_price      REAL NOT NULL,  -- 下单时的单价（可能有折扣）
    discount        REAL DEFAULT 0, -- 折扣金额
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 创建索引（提升查询性能）
CREATE INDEX IF NOT EXISTS idx_orders_customer ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_orders_date ON orders(order_date);
CREATE INDEX IF NOT EXISTS idx_orders_store ON orders(store_id);
CREATE INDEX IF NOT EXISTS idx_order_items_order ON order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_order_items_product ON order_items(product_id);
CREATE INDEX IF NOT EXISTS idx_customers_city ON customers(city);
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);

-- 完成提示
SELECT 'Schema created successfully. Tables: customers, products, stores, orders, order_items' AS message;
