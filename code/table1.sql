CREATE TABLE sys_user (
    user_id     NUMBER(10) PRIMARY KEY,
    role_id     NUMBER(10),
    username    VARCHAR2(50) NOT NULL UNIQUE,
    password    VARCHAR2(100) NOT NULL,
    real_name   VARCHAR2(50),
    gender      VARCHAR2(10),
    phone       VARCHAR2(20),
    status      VARCHAR2(20),
    create_time DATE DEFAULT SYSDATE,
    -- 设置外键关联到角色表
    CONSTRAINT fk_user_role FOREIGN KEY (role_id) REFERENCES sys_role(role_id)
);

COMMENT ON TABLE sys_user IS '用户表';
COMMENT ON COLUMN sys_user.user_id IS '用户编号';
COMMENT ON COLUMN sys_user.role_id IS '角色编号';
COMMENT ON COLUMN sys_user.username IS '登录账号';
COMMENT ON COLUMN sys_user.password IS '登录密码';
COMMENT ON COLUMN sys_user.real_name IS '真实姓名';
COMMENT ON COLUMN sys_user.gender IS '性别';
COMMENT ON COLUMN sys_user.phone IS '联系电话';
COMMENT ON COLUMN sys_user.status IS '用户状态';
COMMENT ON COLUMN sys_user.create_time IS '创建时间';