CREATE TABLE purchase_order (
    order_id        NUMBER(10) GENERATED AS IDENTITY,
    order_code      VARCHAR2(20) NOT NULL,
    supplier_id     NUMBER(10),
    purchase_date   DATE DEFAULT TRUNC(SYSDATE),
    total_amount    NUMBER(12, 2),
    applicant_id    NUMBER(10),
    approver_id     NUMBER(10),
    status          VARCHAR2(20) DEFAULT '待审批',

    CONSTRAINT pk_purchase_order PRIMARY KEY (order_id),
    CONSTRAINT uk_purchase_order_code UNIQUE (order_code),
    -- 物理外键：强制关联供应商表
    CONSTRAINT fk_po_supplier FOREIGN KEY (supplier_id) 
        REFERENCES supplier(supplier_id),
    -- 物理外键：强制关联用户表（申请人）
    CONSTRAINT fk_po_applicant FOREIGN KEY (applicant_id) 
        REFERENCES sys_user(user_id),
    -- 物理外键：强制关联用户表（审批人）
    CONSTRAINT fk_po_approver FOREIGN KEY (approver_id) 
        REFERENCES sys_user(user_id),
    -- 检查约束：限制状态取值范围
    CONSTRAINT ck_po_status CHECK (status IN ('待审批', '已审批', '已入库', '已作废'))
);

COMMENT ON TABLE purchase_order IS '采购订单主表';
COMMENT ON COLUMN purchase_order.order_id IS '采购订单唯一标识 (主键)';
COMMENT ON COLUMN purchase_order.order_code IS '采购单据编码 (系统生成, 唯一)';
COMMENT ON COLUMN purchase_order.supplier_id IS '供应商ID (关联supplier表)';
COMMENT ON COLUMN purchase_order.applicant_id IS '申请用户ID (关联sys_user表)';
COMMENT ON COLUMN purchase_order.approver_id IS '审批用户ID (关联sys_user表)';
COMMENT ON COLUMN purchase_order.status IS '单据状态';
