FROM ubuntu:20.04

# 设置环境变量，避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新系统并安装基础工具
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 安装 nvm 和 Node.js
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 20.18.0 \
    && nvm use 20.18.0 \
    && nvm alias default 20.18.0

# 将 Node.js 添加到 PATH
ENV NVM_DIR /root/.nvm
ENV PATH $NVM_DIR/versions/node/v20.18.0/bin:$PATH

# 验证安装
RUN node --version && npm --version

# 设置工作目录
WORKDIR /app

# 重置环境变量
ENV DEBIAN_FRONTEND=

# 设置默认命令
CMD ["bash"]
