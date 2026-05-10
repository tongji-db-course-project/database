CREATE TABLE sale_order_detail (
    sale_detail_id NUMBER(10) NOT NULL,
    sale_id NUMBER(10) NOT NULL,
    product_id NUMBER(10) NOT NULL,
    sale_quantity NUMBER(10),
    sale_price NUMBER(10, 2),
    CONSTRAINT pk_sale_order_detail PRIMARY KEY (sale_detail_id)
);

-- 添加表12外键约束
ALTER TABLE sale_order_detail ADD CONSTRAINT fk_sale_detail_sale FOREIGN KEY (sale_id) REFERENCES sale_order(sale_id);
ALTER TABLE sale_order_detail ADD CONSTRAINT fk_sale_detail_product FOREIGN KEY (product_id) REFERENCES product(product_id);

-- 添加表12字段注释
COMMENT ON TABLE sale_order_detail IS '销售单明细表';
COMMENT ON COLUMN sale_order_detail.sale_detail_id IS '明细编号';
COMMENT ON COLUMN sale_order_detail.sale_id IS '销售单编号';
COMMENT ON COLUMN sale_order_detail.product_id IS '商品编号';
COMMENT ON COLUMN sale_order_detail.sale_quantity IS '销售数量';
COMMENT ON COLUMN sale_order_detail.sale_price IS '销售单价';