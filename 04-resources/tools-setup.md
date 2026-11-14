# 工具与环境搭建指南

## 1. 必备工具

| 工具 | 用途 | 推荐 |
|------|------|------|
| Python 3.10+ | 数据分析 | 官网或 Anaconda |
| VS Code / Cursor | 写代码 + SQL | 必装 |
| DB Browser for SQLite | 可视化查看/编辑 SQLite | 新手强烈推荐 |
| Git | 版本控制 | 已有本仓库 |
| Jupyter | 交互式分析 | 可选但推荐 |

## 2. Python 环境

```bash
# 创建虚拟环境（推荐）
python -m venv ba-env

# 激活
# Windows:
ba-env\Scripts\activate
# macOS / Linux:
source ba-env/bin/activate

# 安装常用包
pip install pandas numpy matplotlib seaborn sqlalchemy jupyter openpyxl
```

## 3. 如何创建并使用示例数据库

### 方法 A：用 DB Browser for SQLite（最简单）

1. 下载安装 [DB Browser for SQLite](https://sqlitebrowser.org/)
2. 新建数据库，保存为 `data/retail.db`
3. 执行 SQL：打开 `01-sql/sample-database/schema.sql` → 执行
4. 再执行 `sample_data.sql`
5. 就可以在里面跑 `queries.md` 里的查询了

### 方法 B：用命令行 + sqlite3

```bash
mkdir -p data
sqlite3 data/retail.db < 01-sql/sample-database/schema.sql
sqlite3 data/retail.db < 01-sql/sample-database/sample_data.sql
```

### 方法 C：用本仓库的 Python 脚本

直接运行 `02-python/04-sql-python-integration/connect_and_analyze.py`，它会尝试自动创建数据库。

## 4. VS Code 推荐扩展

- Python
- Jupyter
- SQLite Viewer 或 SQLite
- GitLens

## 5. 学习顺序提醒

先把 SQL 基础跑通（用 DB Browser），再学 Python + Pandas，最后把两者连起来。

有问题随时问。
