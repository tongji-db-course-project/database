CREATE TABLE inventory_record (
    record_id       NUMBER(10) NOT NULL,
    product_id      NUMBER(10) NOT NULL,
    record_type     VARCHAR2(20) NOT NULL,
    source_no       VARCHAR2(50),
    change_qty      NUMBER(10) NOT NULL,
    remain_qty      NUMBER(10) NOT NULL,
    operator_id     NUMBER(10) NOT NULL,
    record_time     DATE NOT NULL,
    remark          VARCHAR2(200),
    CONSTRAINT pk_inventory_record PRIMARY KEY (record_id),
    CONSTRAINT fk_inv_record_product FOREIGN KEY (product_id) REFERENCES product(product_id),
    CONSTRAINT fk_inv_record_user FOREIGN KEY (operator_id) REFERENCES sys_user(user_id)
);

-- 字段注释
COMMENT ON COLUMN inventory_record.record_id     IS '流水编号';
COMMENT ON COLUMN inventory_record.product_id    IS '商品编号';
COMMENT ON COLUMN inventory_record.record_type   IS '流水类型(入库/销售/退货/盘点)';
COMMENT ON COLUMN inventory_record.source_no     IS '来源单号';
COMMENT ON COLUMN inventory_record.change_qty    IS '变动数量';
COMMENT ON COLUMN inventory_record.remain_qty    IS '变动后库存';
COMMENT ON COLUMN inventory_record.operator_id   IS '操作人编号';
COMMENT ON COLUMN inventory_record.record_time   IS '记录时间';
COMMENT ON COLUMN inventory_record.remark        IS '备注';
