CREATE TABLE member (
    member_id      NUMBER(10) GENERATED AS IDENTITY,
    member_name    VARCHAR2(100) NOT NULL,
    gender         VARCHAR2(10) CHECK (gender IN ('男', '女', '未知')), -- 性别约束
    phone          VARCHAR2(20) NOT NULL,
    birthday       DATE,
    points         NUMBER(10) DEFAULT 0,
    total_amount   NUMBER(12, 2) DEFAULT 0.00,
    level_name     VARCHAR2(20) DEFAULT '普通会员', -- 会员等级名称
    create_time    DATE DEFAULT SYSDATE,          -- 注册时间
    CONSTRAINT pk_member PRIMARY KEY (member_id),
    CONSTRAINT uk_member_phone UNIQUE (phone)      -- 手机号作为唯一标识
);

COMMENT ON TABLE member IS '会员信息表';
COMMENT ON COLUMN member.member_id IS '会员唯一标识 (主键)';
COMMENT ON COLUMN member.phone IS '会员手机号 (唯一约束)';
COMMENT ON COLUMN member.points IS '当前剩余积分';
COMMENT ON COLUMN member.level_name IS '会员等级（硬编码文本）';

