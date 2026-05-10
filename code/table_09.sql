CREATE TABLE purchase_order (
    order_id       NUMBER(10) GENERATED AS IDENTITY,
    order_code     VARCHAR2(20) NOT NULL,
    supplier_id    NUMBER(10), -- 关联供应商表
    purchase_date  DATE DEFAULT TRUNC(SYSDATE),
    total_amount   NUMBER(12, 2),
    applicant_id   NUMBER(10), -- 申请人ID (需关联sys_user表，此处先不设外键以防报错)
    approver_id    NUMBER(10), -- 审批人ID (需关联sys_user表，此处先不设外键以防报错)
    status         VARCHAR2(20) DEFAULT '待审批',
    CONSTRAINT pk_purchase_order PRIMARY KEY (order_id),
    CONSTRAINT uk_purchase_order_code UNIQUE (order_code), -- 订单编码唯一
    CONSTRAINT fk_po_supplier FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

COMMENT ON TABLE purchase_order IS '采购订单主表';
COMMENT ON COLUMN purchase_order.order_id IS '采购订单唯一标识 (主键)';
COMMENT ON COLUMN purchase_order.order_code IS '采购单据编码 (系统生成, 唯一)';
COMMENT ON COLUMN purchase_order.applicant_id IS '申请用户ID (外键关联sys_user.user_id)';
COMMENT ON COLUMN purchase_order.approver_id IS '审批用户ID (外键关联sys_user.user_id)';
COMMENT ON COLUMN purchase_order.status IS '单据状态 (待审批/已审批/已入库等)';