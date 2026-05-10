CREATE TABLE inventory (
    inventory_id    NUMBER(10)     NOT NULL,
    product_id      NUMBER(10)     NOT NULL,
    current_stock   NUMBER(10)     NOT NULL,
    last_update_time DATE          NOT NULL,
    -- 主键约束
    CONSTRAINT pk_inventory PRIMARY KEY (inventory_id),
    -- 外键约束：关联商品表
    CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- 字段注释
COMMENT ON COLUMN inventory.inventory_id IS '库存编号';
COMMENT ON COLUMN inventory.product_id IS '商品编号，关联商品表';
COMMENT ON COLUMN inventory.current_stock IS '当前库存量';
COMMENT ON COLUMN inventory.last_update_time IS '最后更新时间';
