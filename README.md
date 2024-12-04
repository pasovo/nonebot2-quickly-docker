---
updated: 2024-09-23 13:48:03
---

<div align="center">
  <a href="https://v2.nonebot.dev/store"><img src="./logo.png" width="180" height="180" alt="NoneBotPluginLogo"></a>
  <br>
  <h1>Nonebot2 Quickly Docker</h1>
  <p>【Nonebot2 （OneBot v11）机器人快速构建的 Docker镜像】</p>
</div>

## 🚀 快速开始

### 1️⃣ Linux 一键安装脚本（推荐，前提是你有 Docker）

> curl -fsSL https://raw.gitmirror.com/zhiyu1998/nonebot2-quickly-docker/refs/heads/main/nqd_starter.sh > nqd_starter.sh && chmod 755 nqd_starter.sh && ./nqd_starter.sh 7071

> [!IMPORTANT]
> 如果你想`默认的话就是7071端口`，否则自行修改，如下修改为`8080端口`作为Onebot的反向连接端口：  
> curl -fsSL https://raw.gitmirror.com/zhiyu1998/nonebot2-quickly-docker/refs/heads/main/nqd_starter.sh > nqd_starter.sh && chmod 755 nqd_starter.sh && ./nqd_starter.sh 8080


### 2️⃣ 半自动构建

1. 下载 `Dockerfile 到某个文件夹`，运行：
```shell
docker build -t nonebot2-quickly-docker . --progress=plain
```
or 如果可以`直接拉取镜像`，那么就这样运行：
```shell
docker pull rrorange/nonebot2-quickly-docker
```

2. 如果你的 `Onebot` （例如 Napcat、Lagrange.Onebot） 反向连接端口是7071，那么就这样运行（如是其他8080就是`-p 8080:7071`）

```shell
docker run -d \
  --name nonebot2_quickly_docker
  -p 7071:7071 \
  -v /nb2:/nb2 \
  --restart always \
  nonebot2-quickly-docker
```

> [!NOTE]
> 或者上面的 `\` 无法使用，可以使用下面的一行命令：
> docker run -d --name nonebot2_quickly_docker -p 7071:7071 -v /nb2:/nb2 --restart always nonebot2-quickly-docker

3. 创建目录 & 拷贝 templates 的文件到 /nb2

```shell
mkdir -p /nb2  
cp -r templates/* /nb2  
```

## 拓展知识

### 安装 & 卸载插件

如果想`安装某一个插件`，可以使用以下命令进行安装：
> docker exec -it nonebot2_quickly_docker pip install nonebot2-plugin-xxx && docker restart nonebot2_quickly_docker

同理，如果需要`卸载某个插件`，可以使用以下命令进行卸载：
> docker exec -it nonebot2_quickly_docker pip uninstall nonebot2-plugin-xxx && docker restart nonebot2_quickly_docker

### 安装 Napcat

直接一键脚本：
> curl -o napcat.sh https://nclatest.znin.net/NapNeko/NapCat-Installer/main/script/install.sh && sudo bash napcat.sh

官网参考：
> https://napneko.github.io/zh-CN/guide/getting-started

## Future Todo

- [x] 自动构建
- [x] emoji 表情合成集成
- [x] 点赞、订阅赞集成
- [x] [nonebot-plugin-resolver](https://github.com/zhiyu1998/nonebot-plugin-resolver) 集成