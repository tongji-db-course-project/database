CREATE TABLE sys_role (
    role_id    NUMBER(10) PRIMARY KEY,
    role_name  VARCHAR2(50) NOT NULL UNIQUE,
    role_desc  VARCHAR2(200)
);

COMMENT ON TABLE sys_role IS '角色表';
COMMENT ON COLUMN sys_role.role_id IS '角色编号';
COMMENT ON COLUMN sys_role.role_name IS '角色名称';
COMMENT ON COLUMN sys_role.role_desc IS '角色说明';