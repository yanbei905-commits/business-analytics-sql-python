# Business Analytics SQL & Python Learning Repository

**工商管理 → 商业分析 学习仓库**  
面向：科研 + 就业 + 商业分析硕士申请

欢迎来到你的商业分析学习与作品集仓库！这里系统覆盖 **SQL** 与 **Python**，从零基础到能做业务分析、支持科研与求职/申研。

---

## 🎯 学习目标

- 掌握 SQL 查询、数据建模、业务指标计算
- 掌握 Python（Pandas / Matplotlib / Seaborn / SQLAlchemy）做数据清洗、分析、可视化
- 建立可展示的商业分析项目作品集
- 为商业分析硕士申请积累项目经验与技术证据
- 同时服务就业（分析师、BA、数据相关岗位）与科研

---

## 📁 仓库结构

```
business-analytics-sql-python/
├── README.md                          # 本文件
├── 00-learning-roadmap/               # 完整学习路线图
│   └── roadmap.md
├── 01-sql/
│   ├── 01-basics/
│   ├── 02-intermediate/
│   ├── 03-advanced/
│   └── sample-database/               # 示例业务数据库（零售/电商场景）
│       ├── schema.sql
│       ├── sample_data.sql
│       └── queries.md
├── 02-python/
│   ├── 01-basics/
│   ├── 02-pandas-for-business/
│   ├── 03-visualization/
│   └── 04-sql-python-integration/
├── 03-projects/                       # 可放进作品集 / 简历 / 申研材料的项目
│   ├── project-01-sales-dashboard/
│   ├── project-02-customer-segmentation/
│   └── project-03-research-style-analysis/
├── 04-resources/
│   ├── books-courses.md
│   └── tools-setup.md
└── data/                              # 原始数据文件（CSV等）
```

---

## 🚀 快速开始

1. **克隆仓库**
   ```bash
   git clone https://github.com/yanbei905-commits/business-analytics-sql-python.git
   cd business-analytics-sql-python
   ```

2. **环境建议**
   - Python 3.10+
   - VS Code / Cursor / Jupyter
   - SQLite（最简单）或 PostgreSQL / MySQL
   - 推荐安装：`pandas`, `numpy`, `matplotlib`, `seaborn`, `sqlalchemy`, `jupyter`

3. **从这里开始**
   - 先看 `00-learning-roadmap/roadmap.md`
   - 然后进入 `01-sql/sample-database` 跑示例数据库
   - 同步练习 `02-python`

---

## 📊 示例业务数据库（零售场景）

已为你准备一套完整的零售业务数据库（SQLite 兼容），包含：

- 客户（Customers）
- 产品（Products）
- 订单（Orders）
- 订单明细（OrderItems）
- 门店（Stores）

可用于练习：
- 销售趋势分析
- 客户价值分析（RFM）
- 产品表现
- 门店对比
- 各种业务 KPI

详见 `01-sql/sample-database/`

---

## 🧭 学习路径建议（工商管理背景友好）

### 阶段 1：SQL 基础（2-4 周）
- SELECT / WHERE / ORDER BY / GROUP BY / JOIN
- 业务指标：销售额、客单价、复购率等

### 阶段 2：Python 基础 + Pandas（3-5 周）
- 数据读取、清洗、聚合
- 用 Pandas 复现 SQL 逻辑

### 阶段 3：SQL + Python 结合（2-3 周）
- 用 Python 连接数据库、自动化分析

### 阶段 4：完整项目（持续）
- 做 2-3 个可展示项目，写 README + 结论 + 可视化
- 一个偏业务落地，一个偏科研/严谨分析风格

---

## 🎓 对硕士申请与就业的价值

- **就业**：展示你能用 SQL + Python 解决真实业务问题
- **科研**：培养提出问题 → 取数 → 分析 → 得出洞察的能力
- **申研**：项目可作为 Statement of Purpose / Portfolio 的有力支撑

建议每个项目都写清楚：
1. 业务/研究问题
2. 数据说明
3. 分析方法
4. 关键结论与建议

---

## 📌 下一步行动

1. 阅读 `00-learning-roadmap/roadmap.md`
2. 运行 `01-sql/sample-database/schema.sql` 建立数据库
3. 完成基础 SQL 练习
4. 开始第一个小项目

有问题随时回来问我（Grok），我可以帮你写练习题、检查代码、设计项目、改简历项目描述。

祝你学习顺利，顺利转型商业分析！🚀
