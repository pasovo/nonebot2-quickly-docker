#!/bin/bash

# 定义变量
DOCKERFILE_URL="https://raw.githubusercontent.com/zhiyu1998/nonebot2-quickly-docker/refs/heads/main/Dockerfile"
DOCKER_IMAGE_NAME="nonebot2-quickly-docker"
DOCKER_CONTAINER_NAME="nonebot2_quickly_docker"
NONEBOT_PATH="/nb2"
HOST_PORT=7071
CONTAINER_PORT=7071
HOST_NB2_PATH="/nb2"  # 这里定义宿主机上的 nb2 文件存储路径

# 检查宿主机上的 nb2 目录是否存在，不存在则创建
if [ ! -d "$HOST_NB2_PATH" ]; then
    echo "宿主机目录 $HOST_NB2_PATH 不存在，正在创建..."
    mkdir -p $HOST_NB2_PATH
    if [ $? -eq 0 ]; then
        echo "宿主机目录 $HOST_NB2_PATH 已成功创建"
    else
        echo "无法创建宿主机目录 $HOST_NB2_PATH"
        exit 1
    fi
else
    echo "宿主机目录 $HOST_NB2_PATH 已存在"
fi

# 步骤1：下载Dockerfile
echo "正在下载 $DOCKER_IMAGE_NAME..."
curl -O $DOCKERFILE_URL

# 检查Dockerfile是否成功下载
if [ -f "Dockerfile" ]; then
    echo "$DOCKER_IMAGE_NAME 下载成功"
else
    echo "无法下载 $DOCKER_IMAGE_NAME。"
    exit 1
fi

# 步骤2：构建Docker镜像
echo "构建 $DOCKER_IMAGE_NAME 镜像..."
docker build -t $DOCKER_IMAGE_NAME .

# 检查镜像是否成功构建
if [ $? -eq 0 ]; then
    echo "$DOCKER_IMAGE_NAME 镜像构建成功"
else
    echo "构建 $DOCKER_IMAGE_NAME 镜像失败"
    exit 1
fi

# 步骤3：运行Docker容器
echo "运行 $DOCKER_IMAGE_NAME 容器..."
docker run --name $DOCKER_CONTAINER_NAME -d -p $HOST_PORT:$CONTAINER_PORT -v $NONEBOT_PATH:$NONEBOT_PATH $DOCKER_IMAGE_NAME

# 检查容器是否成功运行
if [ $? -eq 0 ]; then
    echo "$DOCKER_IMAGE_NAME 容器已成功启动"
else
    echo "无法启动 $DOCKER_IMAGE_NAME 容器"
    exit 1
fi

# 步骤4：等待容器准备完成（可选，根据需要修改等待时间）
echo "等待容器启动完成..."
sleep 10  # 可以根据容器启动时间适当修改等待时间

# 步骤5：复制容器中的 /nb2 目录到宿主机
echo "将 $DOCKER_CONTAINER_NAME 容器中的 $NONEBOT_PATH 目录复制到宿主机 $HOST_NB2_PATH..."
docker cp $DOCKER_CONTAINER_NAME:$NONEBOT_PATH/. $HOST_NB2_PATH/

# 检查文件是否成功复制
if [ $? -eq 0 ]; then
    echo "文件成功复制到宿主机的 $HOST_NB2_PATH"
else
    echo "无法复制文件到宿主机"
    exit 1
fi

# 步骤6：停止并删除容器（根据需要是否保留容器）
echo "停止并删除容器 $DOCKER_CONTAINER_NAME..."
docker stop $DOCKER_CONTAINER_NAME
docker rm $DOCKER_CONTAINER_NAME

echo "脚本执行完毕！"
