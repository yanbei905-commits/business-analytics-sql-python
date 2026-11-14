"""
SQL + Python 整合示例
功能：连接 SQLite 示例数据库 → 查询 → 用 Pandas 分析 → 简单可视化

使用前：
1. 先在 01-sql/sample-database/ 下执行 schema.sql 和 sample_data.sql 生成数据库文件
2. 或者把下面的 DB_PATH 改成你本地的 .db 文件路径
3. 安装依赖：pip install pandas matplotlib seaborn
"""

import sqlite3
from pathlib import Path

import pandas as pd
import matplotlib.pyplot as plt

# 设置中文字体（Windows / macOS 可按需调整）
plt.rcParams['font.sans-serif'] = ['SimHei', 'Arial Unicode MS', 'DejaVu Sans']
plt.rcParams['axes.unicode_minus'] = False

# ==================== 配置 ====================
# 假设你把数据库文件放在仓库根目录下的 data/ 或当前目录
DB_PATH = Path(__file__).resolve().parents[2] / "data" / "retail.db"
# 如果还没有 .db 文件，可以先用下面方式创建（需要先有 schema + data 的 sql 文件）

def create_database_if_needed():
    """如果数据库不存在，从 SQL 文件创建（可选）"""
    if DB_PATH.exists():
        print(f"数据库已存在: {DB_PATH}")
        return

    DB_PATH.parent.mkdir(parents=True, exist_ok=True)
    schema_path = Path(__file__).resolve().parents[2] / "01-sql" / "sample-database" / "schema.sql"
    data_path = Path(__file__).resolve().parents[2] / "01-sql" / "sample-database" / "sample_data.sql"

    if not schema_path.exists() or not data_path.exists():
        print("找不到 schema.sql 或 sample_data.sql，请先手动创建数据库。")
        return

    conn = sqlite3.connect(DB_PATH)
    with open(schema_path, encoding="utf-8") as f:
        conn.executescript(f.read())
    with open(data_path, encoding="utf-8") as f:
        conn.executescript(f.read())
    conn.close()
    print(f"数据库创建成功: {DB_PATH}")


def main():
    create_database_if_needed()

    if not DB_PATH.exists():
        print("数据库文件不存在，请先创建。")
        return

    # 连接数据库
    conn = sqlite3.connect(DB_PATH)

    # ---------- 1. 读取整张表到 DataFrame ----------
    orders = pd.read_sql("SELECT * FROM orders WHERE order_status = '已完成'", conn)
    print("订单数据预览：")
    print(orders.head())
    print()

    # ---------- 2. 用 SQL 做聚合，结果直接进 Pandas ----------
    monthly_sql = """
    SELECT 
        strftime('%Y-%m', order_date) AS month,
        COUNT(*) AS order_count,
        ROUND(SUM(total_amount), 2) AS revenue
    FROM orders
    WHERE order_status = '已完成'
    GROUP BY strftime('%Y-%m', order_date)
    ORDER BY month
    """
    monthly = pd.read_sql(monthly_sql, conn)
    print("月度销售：")
    print(monthly)
    print()

    # ---------- 3. 品类销售 ----------
    category_sql = """
    SELECT 
        p.category,
        SUM(oi.quantity) AS total_qty,
        ROUND(SUM(oi.quantity * oi.unit_price - oi.discount), 2) AS revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status = '已完成'
    GROUP BY p.category
    ORDER BY revenue DESC
    """
    category_sales = pd.read_sql(category_sql, conn)
    print("品类销售：")
    print(category_sales)
    print()

    # ---------- 4. 简单可视化 ----------
    fig, axes = plt.subplots(1, 2, figsize=(12, 5))

    # 月度趋势
    axes[0].plot(monthly["month"], monthly["revenue"], marker="o")
    axes[0].set_title("月度销售额趋势")
    axes[0].set_xlabel("月份")
    axes[0].set_ylabel("销售额")
    axes[0].tick_params(axis="x", rotation=45)

    # 品类对比
    axes[1].bar(category_sales["category"], category_sales["revenue"])
    axes[1].set_title("各品类销售额")
    axes[1].set_xlabel("品类")
    axes[1].set_ylabel("销售额")
    axes[1].tick_params(axis="x", rotation=30)

    plt.tight_layout()
    output_path = Path(__file__).parent / "sales_overview.png"
    plt.savefig(output_path, dpi=120)
    print(f"图表已保存: {output_path}")
    # plt.show()  # 本地运行时可取消注释

    conn.close()
    print("分析完成。")


if __name__ == "__main__":
    main()
