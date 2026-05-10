CREATE TABLE supplier (
    supplier_id    NUMBER(10) GENERATED AS IDENTITY,
    supplier_name  VARCHAR2(100) NOT NULL,
    contact_name   VARCHAR2(50),
    phone          VARCHAR2(20),
    email          VARCHAR2(100),
    address        VARCHAR2(200),
    credit_level   VARCHAR2(20), -- 信誉等级
    payment_cycle  NUMBER(5),    -- 结算周期（天）
    CONSTRAINT pk_supplier PRIMARY KEY (supplier_id)
);

COMMENT ON TABLE supplier IS '供应商信息表';
COMMENT ON COLUMN supplier.supplier_id IS '供应商唯一标识 (主键)';
COMMENT ON COLUMN supplier.credit_level IS '供应商信誉等级';
COMMENT ON COLUMN supplier.payment_cycle IS '约定结算周期（天数）';
