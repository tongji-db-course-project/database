# 使用支持自动创建应用用户的 Oracle Free 镜像
FROM gvenzl/oracle-free:latest

# 设置环境变量
# 注意：AL32UTF8 是确保中文不乱码的关键
ENV ORACLE_PASSWORD=123456 \
    ORACLE_CHARACTERSET=AL32UTF8 \
    APP_USER=retail_admin \
    APP_USER_PASSWORD=123456

# 将你的初始化脚本（建表、插入基础数据）放入镜像中的特定目录
# 容器首次启动时会自动按顺序执行这些 SQL 文件
COPY ./init-scripts/ /container-entrypoint-initdb.d/

# 暴露端口
EXPOSE 1521

# 镜像启动时会自动运行自带的启动脚本
