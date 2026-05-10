CREATE TABLE sys_menu (
    menu_id     NUMBER(10) PRIMARY KEY,
    menu_name   VARCHAR2(50) NOT NULL,
    menu_url    VARCHAR2(100),
    parent_id   NUMBER(10),
    menu_order  NUMBER(5)
);

COMMENT ON TABLE sys_menu IS '菜单功能表';
COMMENT ON COLUMN sys_menu.menu_id IS '菜单编号';
COMMENT ON COLUMN sys_menu.menu_name IS '菜单名称';
COMMENT ON COLUMN sys_menu.menu_url IS '菜单路径';
COMMENT ON COLUMN sys_menu.parent_id IS '上级菜单编号';
COMMENT ON COLUMN sys_menu.menu_order IS '菜单顺序';