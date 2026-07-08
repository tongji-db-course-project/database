# 使用支持自动创建应用用户的 Oracle Free 镜像
FROM gvenzl/oracle-free:latest

# 设置环境变量
# 注意：AL32UTF8 是确保中文不乱码的关键
ENV ORACLE_PASSWORD=123456 \
    ORACLE_CHARACTERSET=AL32UTF8 \
    APP_USER=retail_admin \
    APP_USER_PASSWORD=123456

# 将 SQL 脚本拷入镜像备用
# 注意：gvenzl 镜像的 /container-entrypoint-initdb.d/ 自动执行机制在 Oracle 23ai Free
# 上有 ORA-00600 内部 bug，会导致表创建后回滚。因此脚本不再自动执行，
# 改为放在 /tmp/sql/ 目录，待容器启动后手动运行 sqlplus 执行。
RUN mkdir -p /tmp/sql
COPY *.sql /tmp/sql/

# 暴露端口
EXPOSE 1521

# 镜像启动时会自动运行自带的启动脚本
