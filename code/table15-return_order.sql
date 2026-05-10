CREATE TABLE return_order (
    return_id       NUMBER(10) NOT NULL,
    return_no       VARCHAR2(50) NOT NULL,
    sale_id         NUMBER(10) NOT NULL,
    member_id       NUMBER(10),
    operator_id     NUMBER(10) NOT NULL,
    return_date     DATE NOT NULL,
    refund_amount   NUMBER(12,2) NOT NULL,
    status          VARCHAR2(20) NOT NULL,
    remark          VARCHAR2(200),
    CONSTRAINT pk_return_order PRIMARY KEY (return_id),
    CONSTRAINT uk_return_order_no UNIQUE (return_no),
    CONSTRAINT fk_return_sale FOREIGN KEY (sale_id) REFERENCES sale_order(sale_id),
    CONSTRAINT fk_return_member FOREIGN KEY (member_id) REFERENCES member(member_id),
    CONSTRAINT fk_return_operator FOREIGN KEY (operator_id) REFERENCES sys_user(user_id)
);

-- 字段注释
COMMENT ON COLUMN return_order.return_id       IS '退货单编号';
COMMENT ON COLUMN return_order.return_no       IS '退货单号';
COMMENT ON COLUMN return_order.sale_id         IS '对应销售单编号';
COMMENT ON COLUMN return_order.member_id       IS '会员编号';
COMMENT ON COLUMN return_order.operator_id     IS '经办人编号';
COMMENT ON COLUMN return_order.return_date     IS '退货日期';
COMMENT ON COLUMN return_order.refund_amount   IS '退款金额';
COMMENT ON COLUMN return_order.status          IS '退货状态';
COMMENT ON COLUMN return_order.remark          IS '备注';
