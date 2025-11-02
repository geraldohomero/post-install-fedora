# Fedora 安装后脚本

一个全面的自动化脚本，用于为新安装的 Fedora 42 Workstation 设置必要的软件、配置和开发工具。

> 注意：该脚本专为 Fedora 42 Workstation 设计，但也可能适用于其他基于 Fedora 的发行版。但在其他系统上运行之前，请务必谨慎并确保兼容性。

> 重要提示：虽然该脚本旨在自动执行设置任务，但在您的机器上运行之前，请务必查看代码并了解其功能。在继续操作之前，请确保备份关键数据。所提供的脚本仅用于教育目的，不提供任何保证或支持。

[Fedora 42 - Post Install](https://github.com/geraldohomero/post-install-fedora)

[Pop\!\_OS (22.04) - Post Install](https://github.com/geraldohomero/post-install-pop-os)

## 功能

  - 🔄 系统更新与优化
  - 📦 必要软件安装 (DNF & Flatpak)
  - 🗂️ 启用 RPM Fusion 仓库
  - 🛠️ 开发环境设置
  - 🔧 自定义别名配置
  - 🔐 GitHub 集成
  - 🎮 游戏和多媒体支持
  - 🎯 Android 开发设置

## 目录结构

```bash
post-install-fedora/
├── src/
│ ├── alias.sh # 自定义 shell 别名配置
│ └── altTab.sh # Alt+Tab 行为配置
│ ├── devEnv.sh # 开发环境设置
│ ├── dnf-config.sh # DNF 软件包管理器优化
│ ├── githubCloneAndConfig.sh # GitHub 仓库设置
│ ├── homeScript.sh # 为 `misc` 设置家目录工具
│ └── post-install.sh # 主要安装脚本
├── misc/
│ ├── update.sh # 系统更新工具
│ ├── syncthingStatus.sh # Syncthing 状态检查器
│ └── swapAudio.sh # 音频通道切换工具
└── run.sh # 主要执行脚本
```

## 脚本说明

### 主要脚本

1.  **run.sh**

      - 安装过程的入口点
      - 协调所有其他脚本的执行
      - 处理初始设置和权限

2.  **post-install.sh**

      - 管理软件安装
      - 配置 RPM Fusion 仓库
      - 安装 DNF 和 Flatpak 软件包
      - 设置 Android SDK 环境

### 工具脚本

3.  **alias.sh**

      - 配置自定义 shell 别名
      - 创建和管理 `.bash_aliases` 文件
      - 与 `.bashrc` 集成

4.  **dnf-config.sh**

      - 优化 DNF 软件包管理器设置
      - 提高下载速度和软件包管理效率
      - 创建原始配置的备份

5.  **devEnv.sh**

      - 设置开发工具
      - 安装 Node.js、NVM 和其他开发软件包

6.  **githubCloneAndConfig.sh**

      - 配置 GitHub CLI
      - 克隆用户仓库
      - 设置 Git 全局配置

7.  **altTab.sh**

      - 配置 Alt+Tab 行为
      - 为所有打开的应用程序启用窗口预览

8.  **homeScript.sh**

      - 将 update.sh、syncthingStatus.sh 和 swapAudio.sh 添加到家目录

### 其他工具

7.  **misc/update.sh**

      - 系统更新工具
      - 处理 DNF 和 Flatpak 更新
      - 执行系统清理

8.  **misc/syncthingStatus.sh**

      - 检查 Syncthing 服务状态

9.  **misc/swapAudio.sh**

      - 用于切换音频通道的工具

## 自定义别名

该脚本包含几个预定义的别名，您可以自定义它们。要修改它们，请编辑 `src/alias.sh` 中的 `CUSTOM_ALIASES` 数组：

```bash
CUSTOM_ALIASES=(
'alias ips="ip -c -br a"'
'alias his="history|grep"'
'alias ports="netstat -tulanp"'
# 在此处添加您的自定义别名
)
```

包含的常用别名：

  - `update`, `upd`, `up`: 运行系统更新 `misc/update.sh`
  - `ips`: 显示 IP 地址
  - `his`: 搜索命令历史
  - `ports`: 显示网络端口
  - `swap`: 切换音频输出
  - `syncstatus`: 检查 Syncthing 状态 `misc/syncThingStatus.sh`

## 自定义软件包安装

要修改安装哪些软件包，请编辑 `src/post-install.sh` 中的数组：

1.  DNF 软件包：

<!-- end list -->

```bash
PROGRAMS_TO_INSTALL_DNF=(
btop
vim
# 在此处添加/删除软件包
)
```

2.  Flatpak 软件包：

<!-- end list -->

```bash
PROGRAMS_TO_INSTALL_FLATPAK=(
org.qbittorrent.qBittorrent
# 在此处添加/删除软件包
)
```

## 使用方法

1.  克隆仓库：

<!-- end list -->

```bash
git clone https://github.com/geraldohomero/post-install-fedora.git
```

2.  使脚本可执行：

<!-- end list -->

```bash
chmod +x run.sh
```

3.  运行脚本：

<!-- end list -->

```bash
sudo ./run.sh
```

## 先决条件

  - 全新安装的 Fedora
  - 互联网连接
  - Sudo 权限

## 贡献

欢迎贡献！请随时提交 Pull Request。
