-- ============================================================
-- 清理旧数据（按外键依赖倒序删除，子表先删父表后删）
-- ============================================================
DELETE FROM order_status_log;
DELETE FROM daily_settlement;
DELETE FROM stock_check_detail;
DELETE FROM stock_check_order;
DELETE FROM transfer_order_detail;
DELETE FROM transfer_order;
DELETE FROM member_coupon;
DELETE FROM coupon_template;
DELETE FROM purchase_return_order_detail;
DELETE FROM purchase_return_order;
DELETE FROM return_order_detail;
DELETE FROM return_order;
DELETE FROM sale_order_detail;
DELETE FROM sale_order;
DELETE FROM purchase_order_detail;
DELETE FROM purchase_order;
DELETE FROM inventory_record;
DELETE FROM inventory;
DELETE FROM supplier_settlement;
DELETE FROM point_record;
DELETE FROM point_config;
DELETE FROM product;
DELETE FROM member;
DELETE FROM product_category;
DELETE FROM supplier;
DELETE FROM warehouse;
DELETE FROM sys_role_menu;
DELETE FROM sys_user;
DELETE FROM sys_menu;
DELETE FROM sys_role;
COMMIT;

INSERT INTO sys_role (role_id, role_name, role_desc) VALUES (1, '系统管理员', '拥有系统全部权限');
INSERT INTO sys_role (role_id, role_name, role_desc) VALUES (2, '采购员', '负责采购业务');
INSERT INTO sys_role (role_id, role_name, role_desc) VALUES (3, '收银员', '负责销售收银业务');
INSERT INTO sys_role (role_id, role_name, role_desc) VALUES (4, '仓库管理员', '负责库存管理');

INSERT INTO sys_menu (menu_id, menu_name, menu_url, parent_id, menu_order) VALUES (1, '系统管理', '/system', NULL, 1);
INSERT INTO sys_menu (menu_id, menu_name, menu_url, parent_id, menu_order) VALUES (2, '用户管理', '/system/users', 1, 1);
INSERT INTO sys_menu (menu_id, menu_name, menu_url, parent_id, menu_order) VALUES (3, '角色管理', '/system/roles', 1, 2);
INSERT INTO sys_menu (menu_id, menu_name, menu_url, parent_id, menu_order) VALUES (4, '商品管理', '/products', NULL, 2);
INSERT INTO sys_menu (menu_id, menu_name, menu_url, parent_id, menu_order) VALUES (5, '采购管理', '/purchase', NULL, 3);
INSERT INTO sys_menu (menu_id, menu_name, menu_url, parent_id, menu_order) VALUES (6, '销售管理', '/sales', NULL, 4);
INSERT INTO sys_menu (menu_id, menu_name, menu_url, parent_id, menu_order) VALUES (7, '库存管理', '/inventory', NULL, 5);
INSERT INTO sys_menu (menu_id, menu_name, menu_url, parent_id, menu_order) VALUES (8, '会员管理', '/members', NULL, 6);

INSERT INTO sys_user (user_id, role_id, username, password, real_name, gender, phone, status, create_time) VALUES (1, 1, 'admin', '123456', '系统管理员', '男', '13800000001', '启用', SYSDATE);
INSERT INTO sys_user (user_id, role_id, username, password, real_name, gender, phone, status, create_time) VALUES (2, 2, 'buyer01', '123456', '张采购', '女', '13800000002', '启用', SYSDATE);
INSERT INTO sys_user (user_id, role_id, username, password, real_name, gender, phone, status, create_time) VALUES (3, 3, 'cashier01', '123456', '李收银', '女', '13800000003', '启用', SYSDATE);
INSERT INTO sys_user (user_id, role_id, username, password, real_name, gender, phone, status, create_time) VALUES (4, 4, 'stock01', '123456', '王仓管', '男', '13800000004', '启用', SYSDATE);

INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (1, 1, 1);
INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (2, 1, 2);
INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (3, 1, 3);
INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (4, 1, 4);
INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (5, 1, 5);
INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (6, 1, 6);
INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (7, 1, 7);
INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (8, 1, 8);
INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (9, 2, 5);
INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (10, 3, 6);
INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (11, 3, 8);
INSERT INTO sys_role_menu (role_menu_id, role_id, menu_id) VALUES (12, 4, 7);

INSERT INTO supplier (supplier_id, supplier_name, contact_name, phone, email, address, credit_level, payment_cycle, min_order_qty, bank_name, bank_account) VALUES (1, '华东食品供应商', '陈经理', '021-88880001', 'food@example.com', '上海市浦东新区', 'A', 30, 10, '中国工商银行', '6222021001000001');
INSERT INTO supplier (supplier_id, supplier_name, contact_name, phone, email, address, credit_level, payment_cycle, min_order_qty, bank_name, bank_account) VALUES (2, '南方日化批发部', '刘经理', '020-88880002', 'daily@example.com', '广州市天河区', 'A', 45, 5, '中国建设银行', '6227002002000002');
INSERT INTO supplier (supplier_id, supplier_name, contact_name, phone, email, address, credit_level, payment_cycle, min_order_qty, bank_name, bank_account) VALUES (3, '北方饮品有限公司', '赵经理', '010-88880003', 'drink@example.com', '北京市朝阳区', 'B', 30, 20, '中国农业银行', '6228483003000003');

INSERT INTO product_category (category_id, category_name, category_desc, status) VALUES (1, '食品', '休闲食品和粮油食品', '启用');
INSERT INTO product_category (category_id, category_name, category_desc, status) VALUES (2, '日用品', '家庭日常用品', '启用');
INSERT INTO product_category (category_id, category_name, category_desc, status) VALUES (3, '饮料', '瓶装饮料和冲调饮品', '启用');

INSERT INTO member (member_id, member_name, gender, phone, birthday, points, member_tag, total_amount, level_name, discount_rate, create_time) VALUES (1, '赵一一', '女', '13900000001', TO_DATE('1992-05-18', 'YYYY-MM-DD'), 120, '高消费', 568.50, '黄金会员', 0.95, SYSDATE - 90);
INSERT INTO member (member_id, member_name, gender, phone, birthday, points, member_tag, total_amount, level_name, discount_rate, create_time) VALUES (2, '钱二二', '男', '13900000002', TO_DATE('1988-09-20', 'YYYY-MM-DD'), 360, 'VIP', 1832.00, '钻石会员', 0.90, SYSDATE - 180);
INSERT INTO member (member_id, member_name, gender, phone, birthday, points, member_tag, total_amount, level_name, discount_rate, create_time) VALUES (3, '孙三三', '未知', '13900000003', NULL, 20, NULL, 98.00, '普通会员', 1.00, SYSDATE - 15);

INSERT INTO product (product_id, category_id, supplier_id, product_name, barcode, specification, purchase_price, sale_price, is_promotion, promotion_price, stock_warning, unit, status) VALUES (1, 1, 1, '原味薯片', '690000000001', '80g/袋', 4.20, 6.50, '否', NULL, 20, '袋', '在售');
INSERT INTO product (product_id, category_id, supplier_id, product_name, barcode, specification, purchase_price, sale_price, is_promotion, promotion_price, stock_warning, unit, status) VALUES (2, 1, 1, '精装大米', '690000000002', '5kg/袋', 38.00, 49.90, '否', NULL, 10, '袋', '在售');
INSERT INTO product (product_id, category_id, supplier_id, product_name, barcode, specification, purchase_price, sale_price, is_promotion, promotion_price, stock_warning, unit, status) VALUES (3, 2, 2, '洗衣液', '690000000003', '2kg/瓶', 18.50, 29.90, '否', NULL, 15, '瓶', '在售');
INSERT INTO product (product_id, category_id, supplier_id, product_name, barcode, specification, purchase_price, sale_price, is_promotion, promotion_price, stock_warning, unit, status) VALUES (4, 3, 3, '矿泉水', '690000000004', '550ml/瓶', 0.80, 2.00, '是', 1.50, 50, '瓶', '在售');
INSERT INTO product (product_id, category_id, supplier_id, product_name, barcode, specification, purchase_price, sale_price, is_promotion, promotion_price, stock_warning, unit, status) VALUES (5, 3, 3, '橙汁饮料', '690000000005', '1L/瓶', 5.50, 8.90, '否', NULL, 30, '瓶', '在售');

INSERT INTO purchase_order (order_id, order_code, supplier_id, purchase_date, total_amount, applicant_id, approver_id, status, create_time, update_time) VALUES (1, 'PO20260501001', 1, TO_DATE('2026-05-01', 'YYYY-MM-DD'), 4220.00, 2, 1, '已入库', TO_DATE('2026-05-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-05-03 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO purchase_order (order_id, order_code, supplier_id, purchase_date, total_amount, applicant_id, approver_id, status, create_time, update_time) VALUES (2, 'PO20260502001', 3, TO_DATE('2026-05-02', 'YYYY-MM-DD'), 1260.00, 2, 1, '已审批', TO_DATE('2026-05-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-05-02 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO purchase_order_detail (purchase_detail_id, purchase_id, product_id, purchase_quantity, purchase_price) VALUES (1, 1, 1, 200, 4.20);
INSERT INTO purchase_order_detail (purchase_detail_id, purchase_id, product_id, purchase_quantity, purchase_price) VALUES (2, 1, 2, 80, 38.00);
INSERT INTO purchase_order_detail (purchase_detail_id, purchase_id, product_id, purchase_quantity, purchase_price) VALUES (3, 2, 4, 600, 0.80);
INSERT INTO purchase_order_detail (purchase_detail_id, purchase_id, product_id, purchase_quantity, purchase_price) VALUES (4, 2, 5, 120, 5.50);

INSERT INTO sale_order (sale_id, sale_no, member_id, user_id, sale_date, total_amount, discount_amount, paid_amount, pay_type, status, create_time, update_time) VALUES (1, 'SO20260503001', 1, 3, TO_DATE('2026-05-03 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 80.80, 5.00, 75.80, '微信', '已完成', TO_DATE('2026-05-03 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-05-03 10:15:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO sale_order (sale_id, sale_no, member_id, user_id, sale_date, total_amount, discount_amount, paid_amount, pay_type, status, create_time, update_time) VALUES (2, 'SO20260503002', 2, 3, TO_DATE('2026-05-03 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 69.70, 0.00, 69.70, '支付宝', '已完成', TO_DATE('2026-05-03 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-05-03 15:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO sale_order (sale_id, sale_no, member_id, user_id, sale_date, total_amount, discount_amount, paid_amount, pay_type, status, create_time, update_time) VALUES (3, 'SO20260504001', NULL, 3, TO_DATE('2026-05-04 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), 19.50, 0.00, 19.50, '现金', '已完成', TO_DATE('2026-05-04 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-05-04 09:20:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO sale_order_detail (sale_detail_id, sale_id, product_id, sale_quantity, sale_price) VALUES (1, 1, 1, 2, 6.50);
INSERT INTO sale_order_detail (sale_detail_id, sale_id, product_id, sale_quantity, sale_price) VALUES (2, 1, 2, 1, 49.90);
INSERT INTO sale_order_detail (sale_detail_id, sale_id, product_id, sale_quantity, sale_price) VALUES (3, 1, 4, 9, 2.00);
INSERT INTO sale_order_detail (sale_detail_id, sale_id, product_id, sale_quantity, sale_price) VALUES (4, 2, 3, 2, 29.90);
INSERT INTO sale_order_detail (sale_detail_id, sale_id, product_id, sale_quantity, sale_price) VALUES (5, 2, 5, 1, 8.90);
INSERT INTO sale_order_detail (sale_detail_id, sale_id, product_id, sale_quantity, sale_price) VALUES (6, 3, 1, 3, 6.50);

INSERT INTO inventory (inventory_id, product_id, warehouse_id, current_stock, last_update_time) VALUES (1, 1, 1, 195, SYSDATE);
INSERT INTO inventory (inventory_id, product_id, warehouse_id, current_stock, last_update_time) VALUES (2, 2, 1, 79, SYSDATE);
INSERT INTO inventory (inventory_id, product_id, warehouse_id, current_stock, last_update_time) VALUES (3, 3, 1, 48, SYSDATE);
INSERT INTO inventory (inventory_id, product_id, warehouse_id, current_stock, last_update_time) VALUES (4, 4, 1, 591, SYSDATE);
INSERT INTO inventory (inventory_id, product_id, warehouse_id, current_stock, last_update_time) VALUES (5, 5, 1, 119, SYSDATE);

INSERT INTO inventory_record (record_id, product_id, record_type, source_no, change_qty, remain_qty, operator_id, record_time, remark) VALUES (1, 1, '入库', 'PO20260501001', 200, 200, 4, TO_DATE('2026-05-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), '采购入库');
INSERT INTO inventory_record (record_id, product_id, record_type, source_no, change_qty, remain_qty, operator_id, record_time, remark) VALUES (2, 2, '入库', 'PO20260501001', 80, 80, 4, TO_DATE('2026-05-01 14:05:00', 'YYYY-MM-DD HH24:MI:SS'), '采购入库');
INSERT INTO inventory_record (record_id, product_id, record_type, source_no, change_qty, remain_qty, operator_id, record_time, remark) VALUES (3, 1, '销售', 'SO20260503001', -2, 198, 3, TO_DATE('2026-05-03 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), '销售出库');
INSERT INTO inventory_record (record_id, product_id, record_type, source_no, change_qty, remain_qty, operator_id, record_time, remark) VALUES (4, 3, '销售', 'SO20260503002', -2, 48, 3, TO_DATE('2026-05-03 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), '销售出库');
INSERT INTO inventory_record (record_id, product_id, record_type, source_no, change_qty, remain_qty, operator_id, record_time, remark) VALUES (5, 1, '销售', 'SO20260504001', -3, 195, 3, TO_DATE('2026-05-04 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), '销售出库');

INSERT INTO return_order (return_id, return_no, sale_id, member_id, operator_id, return_date, refund_amount, status, create_time, update_time, remark) VALUES (1, 'RO20260505001', 1, 1, 3, TO_DATE('2026-05-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.50, '已完成', TO_DATE('2026-05-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-05-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), '顾客退回一袋薯片');

INSERT INTO return_order_detail (return_detail_id, return_id, product_id, quantity, refund_price, subtotal) VALUES (1, 1, 1, 1, 6.50, 6.50);

INSERT INTO point_record (point_record_id, member_id, sale_id, change_type, change_points, remain_points, record_time, remark) VALUES (1, 1, 1, '增加', 7, 127, TO_DATE('2026-05-03 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), '销售获得积分');
INSERT INTO point_record (point_record_id, member_id, sale_id, change_type, change_points, remain_points, record_time, remark) VALUES (2, 2, 2, '增加', 6, 366, TO_DATE('2026-05-03 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), '销售获得积分');
INSERT INTO point_record (point_record_id, member_id, sale_id, change_type, change_points, remain_points, record_time, remark) VALUES (3, 1, 1, '扣减', -1, 126, TO_DATE('2026-05-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), '退货扣减积分');

INSERT INTO supplier_settlement (settlement_id, supplier_id, purchase_id, settlement_date, settlement_amount, paid_amount, unpaid_amount, status, remark) VALUES (1, 1, 1, TO_DATE('2026-05-06', 'YYYY-MM-DD'), 4220.00, 4220.00, 0.00, '已结算', '采购单PO20260501001已结清');
INSERT INTO supplier_settlement (settlement_id, supplier_id, purchase_id, settlement_date, settlement_amount, paid_amount, unpaid_amount, status, remark) VALUES (2, 3, 2, TO_DATE('2026-05-06', 'YYYY-MM-DD'), 1260.00, 500.00, 760.00, '部分结算', '采购单PO20260502001部分付款');

-- ============================================================
-- 以下为新增表的种子数据
-- ============================================================

-- 19. warehouse（单仓库模式）
INSERT INTO warehouse (warehouse_id, warehouse_name, address, status, create_time) VALUES (1, '总仓', '默认仓库', '启用', SYSDATE - 180);

-- 20. order_status_log（现有订单的状态流转日志）
-- 采购单 PO20260501001：待审批 → 已审批 → 已入库
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (1, '采购单', 1, NULL, '待审批', 2, TO_DATE('2026-05-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), '创建采购单');
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (2, '采购单', 1, '待审批', '已审批', 1, TO_DATE('2026-05-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), '审核通过');
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (3, '采购单', 1, '已审批', '已入库', 4, TO_DATE('2026-05-03 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), '采购入库完成');

-- 采购单 PO20260502001：待审批 → 已审批
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (4, '采购单', 2, NULL, '待审批', 2, TO_DATE('2026-05-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), '创建采购单');
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (5, '采购单', 2, '待审批', '已审批', 1, TO_DATE('2026-05-02 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), '审核通过');

-- 销售单 SO20260503001：待支付 → 已完成
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (6, '销售单', 1, NULL, '待支付', 3, TO_DATE('2026-05-03 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'POS创建销售单');
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (7, '销售单', 1, '待支付', '已完成', 3, TO_DATE('2026-05-03 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), '收银完成');

-- 销售单 SO20260503002：待支付 → 已完成
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (8, '销售单', 2, NULL, '待支付', 3, TO_DATE('2026-05-03 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'POS创建销售单');
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (9, '销售单', 2, '待支付', '已完成', 3, TO_DATE('2026-05-03 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), '收银完成');

-- 销售单 SO20260504001：待支付 → 已完成
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (10, '销售单', 3, NULL, '待支付', 3, TO_DATE('2026-05-04 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'POS创建销售单');
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (11, '销售单', 3, '待支付', '已完成', 3, TO_DATE('2026-05-04 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), '收银完成');

-- 退货单 RO20260505001：待处理 → 已完成
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (12, '退货单', 1, NULL, '待处理', 3, TO_DATE('2026-05-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), '客户申请退货');
INSERT INTO order_status_log (log_id, order_type, order_id, old_status, new_status, operator_id, change_time, remark) VALUES (13, '退货单', 1, '待处理', '已完成', 3, TO_DATE('2026-05-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), '退货完成，已退款');

-- 24. point_config（积分规则配置）
INSERT INTO point_config (config_id, earn_rate, redeem_rate, redeem_min, redeem_max_rate, status, update_time) VALUES (1, 0.01, 0.01, 100, 0.5, '启用', SYSDATE);

-- 29. daily_settlement（每日营业结转）
INSERT INTO daily_settlement (settlement_id, settlement_date, total_sales, cash_amount, wechat_amount, alipay_amount, promotion_discount, member_discount, coupon_deduct, point_deduct, point_consumed, order_count, status, create_time) VALUES (1, TO_DATE('2026-05-03', 'YYYY-MM-DD'), 145.50, 0.00, 75.80, 69.70, 0.00, 0.00, 0.00, 0.00, 0, 2, '已生成', TO_DATE('2026-05-03 23:59:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO daily_settlement (settlement_id, settlement_date, total_sales, cash_amount, wechat_amount, alipay_amount, promotion_discount, member_discount, coupon_deduct, point_deduct, point_consumed, order_count, status, create_time) VALUES (2, TO_DATE('2026-05-04', 'YYYY-MM-DD'), 19.50, 19.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 1, '已生成', TO_DATE('2026-05-04 23:59:00', 'YYYY-MM-DD HH24:MI:SS'));

COMMIT;
