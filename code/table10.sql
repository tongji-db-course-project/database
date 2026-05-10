CREATE TABLE purchase_order_detail (
    purchase_detail_id NUMBER(10) NOT NULL,
    purchase_id NUMBER(10) NOT NULL,
    product_id NUMBER(10) NOT NULL,
    purchase_quantity NUMBER(10),
    purchase_price NUMBER(10, 2),
    CONSTRAINT pk_purchase_detail PRIMARY KEY (purchase_detail_id)
);

-- 添加表10外键约束 (执行前需确保 purchase_order 和 product 表已存在)
ALTER TABLE purchase_order_detail ADD CONSTRAINT fk_pur_detail_purchase FOREIGN KEY (purchase_id) REFERENCES purchase_order(purchase_id);
ALTER TABLE purchase_order_detail ADD CONSTRAINT fk_pur_detail_product FOREIGN KEY (product_id) REFERENCES product(product_id);

-- 添加表10字段注释
COMMENT ON TABLE purchase_order_detail IS '采购订单明细表';
COMMENT ON COLUMN purchase_order_detail.purchase_detail_id IS '明细编号';
COMMENT ON COLUMN purchase_order_detail.purchase_id IS '采购单编号';
COMMENT ON COLUMN purchase_order_detail.product_id IS '商品编号';
COMMENT ON COLUMN purchase_order_detail.purchase_quantity IS '采购数量';
COMMENT ON COLUMN purchase_order_detail.purchase_price IS '采购单价';
