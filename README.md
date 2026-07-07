# 零售管理系统数据库 (Retail Management System Database)

一个基于 **Oracle** 的零售管理系统数据库，涵盖用户权限、商品采购、销售收银、库存管理、会员积分、退货退款、供应商结算、优惠券、积分抵扣、多仓库调拨、库存盘点、每日营业结转等全业务模块。

## 技术栈

| 项目 | 说明 |
|------|------|
| **数据库** | Oracle (gvenzl/oracle-free) |
| **字符集** | AL32UTF8（完整支持中文） |
| **容器化** | Docker |
| **应用用户** | `retail_admin` / `123456` |

## 快速启动

```bash
# 构建镜像
docker build -t retail-db .

# 启动容器
docker run -d --name retail-db -p 1521:1521 retail-db
```

容器首次启动时会自动按序执行 SQL 初始化脚本。

> **注意**：Dockerfile 中的 `COPY ./init-scripts/` 路径在当前仓库已合并为根目录的两个 SQL 文件。如需使用 Docker 自动初始化，请将 `01_schema.sql` 和 `02_data.sql` 放入 `init-scripts/` 目录后再构建镜像，或直接连接数据库手动执行。

连接信息：
- **Host**: `localhost:1521`
- **SID/Service**: `FREEPDB1`
- **App User**: `retail_admin` / `123456`
- **SYS Password**: `123456`

## 文件结构

```
.
├── Dockerfile          # Oracle 容器镜像定义
├── 01_schema.sql       # DDL：30 张表，含约束、注释、索引
├── 02_data.sql         # DML：种子/测试数据（含清理旧数据逻辑）
├── .gitattributes      # 强制 LF 换行，标记 SQL 为代码语言
└── .gitignore
```

## 数据库模型

共 **30 张业务表**，按模块分为 8 层：

### 系统权限 (RBAC)

| 表名 | 说明 | 关键字段 |
|------|------|----------|
| `sys_role` | 角色表 | role_id, role_name |
| `sys_menu` | 菜单功能表 | menu_id, menu_name, parent_id, menu_order |
| `sys_user` | 用户表 | user_id, username, password, role_id → sys_role |
| `sys_role_menu` | 角色-菜单权限中间表 | role_id → sys_role, menu_id → sys_menu, ON DELETE CASCADE |

### 基础资料

| 表名 | 说明 | 关键字段 |
|------|------|----------|
| `supplier` | 供应商信息表 | supplier_id, credit_level, payment_cycle, min_order_qty, bank_name, bank_account |
| `product_category` | 商品类别表 | category_id, category_name, status |
| `product` | 商品基础资料表 | product_id, barcode, purchase_price, sale_price, is_promotion, promotion_price, stock_warning, category_id → product_category, supplier_id → supplier |

### 会员与积分

| 表名 | 说明 | 关键字段 |
|------|------|----------|
| `member` | 会员信息表 | member_id, phone, points, member_tag, total_amount, level_name (普通/黄金/钻石), discount_rate |
| `point_record` | 积分流水表 | point_record_id, change_type (增加/扣减/抵现), member_id → member, sale_id → sale_order |
| `point_config` | 积分规则配置表 | config_id, earn_rate (获取率), redeem_rate (抵扣率), redeem_max_rate (抵扣上限) |

### 采购进货

| 表名 | 说明 | 关键字段 |
|------|------|----------|
| `purchase_order` | 采购订单主表 | order_id, order_code, status (待审批/已审批/已入库/已作废), supplier_id → supplier, applicant_id/approver_id → sys_user, create_time, update_time |
| `purchase_order_detail` | 采购订单明细 | purchase_detail_id, purchase_id → purchase_order, product_id → product |
| `purchase_return_order` | 采购退货单主表 | return_id, return_no, status (待审核/已审核/已完成/已作废), purchase_id → purchase_order, supplier_id → supplier |
| `purchase_return_order_detail` | 采购退货单明细 | detail_id, return_id → purchase_return_order, product_id → product |
| `supplier_settlement` | 供应商结算表 | settlement_id, status (未结算/已结算/部分结算), supplier_id → supplier, purchase_id → purchase_order |

### 销售零售

| 表名 | 说明 | 关键字段 |
|------|------|----------|
| `sale_order` | 销售订单表 | sale_id, sale_no, total_amount, discount_amount, paid_amount, pay_type, member_id → member, user_id → sys_user, create_time, update_time |
| `sale_order_detail` | 销售单明细 | sale_detail_id, sale_id → sale_order, product_id → product |
| `return_order` | 销售退货单主表 | return_id, return_no, refund_amount, sale_id → sale_order, member_id → member, create_time, update_time |
| `return_order_detail` | 销售退货单明细 | return_detail_id, return_id → return_order (CASCADE), product_id → product |

### 优惠促销

| 表名 | 说明 | 关键字段 |
|------|------|----------|
| `coupon_template` | 优惠券模板表 | template_id, coupon_type (满减券/折扣券/现金券), min_amount, face_value, valid_days |
| `member_coupon` | 会员持有优惠券 | coupon_id, status (未使用/已使用/已过期), template_id → coupon_template, member_id → member, sale_id → sale_order |

### 库存仓储

| 表名 | 说明 | 关键字段 |
|------|------|----------|
| `warehouse` | 仓库/门店表 | warehouse_id, warehouse_name, address |
| `inventory` | 库存表 | inventory_id, product_id → product, warehouse_id → warehouse, current_stock, UNIQUE(product_id, warehouse_id) |
| `inventory_record` | 库存流水表 | record_id, record_type (入库/销售/退货/盘点/调拨), source_no, change_qty, remain_qty, operator_id → sys_user |
| `transfer_order` | 调拨单主表 | transfer_id, from_warehouse/to_warehouse → warehouse, status, applicant_id/approver_id → sys_user |
| `transfer_order_detail` | 调拨单明细 | detail_id, transfer_id → transfer_order, product_id → product |
| `stock_check_order` | 盘点单主表 | check_id, warehouse_id → warehouse, check_type (定期/动态), status |
| `stock_check_detail` | 盘点单明细 | detail_id, check_id → stock_check_order, system_qty, actual_qty, difference_qty |

### 财务分析

| 表名 | 说明 | 关键字段 |
|------|------|----------|
| `daily_settlement` | 每日营业结转表 | settlement_date (UNIQUE), total_sales, 按支付方式/优惠类型拆分统计, 独立展示限时特价让利/会员折扣/优惠券核销/积分抵扣 |
| `order_status_log` | 订单状态流转日志 | log_id, order_type (采购单/销售单/退货单), order_id, old_status→new_status, change_time |

## 种子数据概览

`02_data.sql` 包含完整的测试数据集，覆盖所有业务场景：

- **4 个角色 / 4 个用户**：系统管理员(admin)、采购员(buyer01)、收银员(cashier01)、仓管员(stock01)，密码均为 `123456`
- **3 家供应商**：华东食品(A级)、南方日化(A级)、北方饮品(B级)
- **3 个商品类别 / 5 个商品**：薯片、大米、洗衣液、矿泉水、橙汁
- **3 个会员**：黄金会员(95折)、钻石会员(9折)、普通会员(原价)各一个
- **2 笔采购单 + 3 笔销售单 + 1 笔退货单**，含完整状态流转日志
- **1 个仓库**（总仓），单仓库模式
- **库存流水**：覆盖入库、销售出库完整链路
- **积分流水**：销售获积分、退货扣积分；积分配置(1%=1积分，100分起抵)
- **2 笔供应商结算**：已结清 + 部分结算
- **2 笔日结记录**：按支付渠道和优惠类型拆分统计
- **优惠券/调拨/盘点**：表结构已建，种子数据暂未填充

所有数据日期以 2026-05 为基准，互相关联形成完整的业务闭环。

## 命名规范

- **表名**：小写 + 下划线分隔（`purchase_order`, `sale_order_detail`）
- **列名**：小写 + 下划线分隔（`member_id`, `create_time`）
- **主键**：`<表名>_id` 或直接使用 `xxx_id`
- **外键**：`fk_<缩写>_<目标表>`（如 `fk_sale_member` 指向 `member` 表）
- **唯一约束**：`uk_<表名>_<列名>`（如 `uk_sale_no`）
- **检查约束**：`ck_<表名>_<列名>`（如 `ck_po_status`）
- **注释**：所有表和列均有中文 `COMMENT ON` 注释

## 开发约定

- 所有 SQL 文件以 **LF** 换行符提交（由 `.gitattributes` 强制）
- SQL 文件被标记为代码语言（非文档），便于 GitHub 统计语言比例
- 主键 ID 采用 `NUMBER(10)`，**全部**使用 `GENERATED BY DEFAULT AS IDENTITY` 自增
- 金额字段统一使用 `NUMBER(12, 2)` 或 `NUMBER(10, 2)`
- 日期字段使用 `DATE` 类型，种子数据用 `TO_DATE()` 或 `SYSDATE`
- 外键关系完整定义，支持级联删除（如 `return_order_detail` 和 `sys_role_menu`）
- 所有外键列均已建立索引（26 个 `CREATE INDEX`），确保关联查询和级联操作性能
- 所有 `status` 列均有 `CHECK` 约束（如 `ck_po_status`），统一保证数据合法性
- 两个 SQL 脚本均内置清理逻辑，可反复执行初始化：`01_schema.sql` 开头 DROP 全部旧表，`02_data.sql` 开头 DELETE 全部旧数据

## AI Agent 使用提示

如果你是一个 AI Agent 需要理解此仓库：

1. **入口文件**：`01_schema.sql`（建表）和 `02_data.sql`（测试数据）
2. **执行顺序**：先 schema 后 data，不可颠倒
3. **数据库方言**：Oracle PL/SQL，注意 `NUMBER`、`VARCHAR2`、`DATE`、`TO_DATE()`、`SYSDATE` 等 Oracle 特有语法
4. **自增主键**：使用 `GENERATED BY DEFAULT AS IDENTITY`（Oracle 12c+）
5. **业务语言**：所有注释为中文，表名/列名英文，适合中文零售场景
6. **测试账号**：admin/123456 为系统管理员
7. **事务**：`02_data.sql` 末尾有 `COMMIT`，所有 DML 在一个事务中

## Git 历史概要

```
86882d6  init repository + Dockerfile
...
03e8916  合并所有 SQL 为 01_schema.sql
de096ee  清理冗余目录
5721524  生成测试数据脚本 02_data.sql
[latest] 扩展至30张表，补充种子数据，内置清理逻辑
```
