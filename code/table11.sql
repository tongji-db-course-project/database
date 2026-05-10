CREATE TABLE sale_order (
    sale_id NUMBER(10) NOT NULL,
    sale_no VARCHAR2(50) NOT NULL,
    member_id NUMBER(10),          -- 可空
    user_id NUMBER(10) NOT NULL,
    sale_date DATE,
    total_amount NUMBER(12, 2),
    discount_amount NUMBER(12, 2),
    paid_amount NUMBER(12, 2),
    pay_type VARCHAR2(20),
    status VARCHAR2(20),
    CONSTRAINT pk_sale_order PRIMARY KEY (sale_id),
    CONSTRAINT uk_sale_no UNIQUE (sale_no)
);

-- 添加表11外键约束 (执行前需确保 member 和 sys_user 表已存在)
ALTER TABLE sale_order ADD CONSTRAINT fk_sale_member FOREIGN KEY (member_id) REFERENCES member(member_id);
ALTER TABLE sale_order ADD CONSTRAINT fk_sale_user FOREIGN KEY (user_id) REFERENCES sys_user(user_id);

-- 添加表11字段注释
COMMENT ON TABLE sale_order IS '销售订单表';
COMMENT ON COLUMN sale_order.sale_id IS '销售单编号';
COMMENT ON COLUMN sale_order.sale_no IS '销售单号';
COMMENT ON COLUMN sale_order.member_id IS '会员编号';
COMMENT ON COLUMN sale_order.user_id IS '收银员编号';
COMMENT ON COLUMN sale_order.sale_date IS '销售日期';
COMMENT ON COLUMN sale_order.total_amount IS '原始总金额';
COMMENT ON COLUMN sale_order.discount_amount IS '优惠金额';
COMMENT ON COLUMN sale_order.paid_amount IS '实付金额';
COMMENT ON COLUMN sale_order.pay_type IS '支付方式';
COMMENT ON COLUMN sale_order.status IS '销售单状态';