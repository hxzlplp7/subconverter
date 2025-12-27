# subconverter

订阅转换工具 - 支持多种代理订阅格式之间的转换

基于 [tindy2013/subconverter](https://github.com/tindy2013/subconverter) 修改

## ✨ 本项目改进

- **修复 AnyTLS 转换问题**：原版转换 AnyTLS 链接时缺少 `sni`、`alpn`、`udp`、`skip-cert-verify` 等关键参数，本项目已修复
- **新增 FreeBSD 支持**：增加 FreeBSD (Serv00/Hostuno) 平台编译，可直接在 Serv00 上运行

## 📦 下载

从 [Releases](../../releases) 页面下载对应平台的版本：

| 平台 | 文件名 | 说明 |
|------|--------|------|
| Linux x64 | `subconverter_linux64.tar.gz` | 适用于大多数 Linux 服务器 |
| Linux x86 | `subconverter_linux32.tar.gz` | 32位 Linux |
| Linux ARM64 | `subconverter_aarch64.tar.gz` | ARM64 服务器/树莓派等 |
| Linux ARMv7 | `subconverter_armv7.tar.gz` | ARMv7 设备 |
| Windows x64 | `subconverter_win64.7z` | Windows 64位 |
| Windows x86 | `subconverter_win32.7z` | Windows 32位 |
| macOS Intel | `subconverter_darwin64.tar.gz` | macOS Intel 芯片 |
| macOS ARM | `subconverter_darwinarm.tar.gz` | macOS Apple Silicon |
| **FreeBSD x64** | `subconverter_freebsd64.tar.gz` | **Serv00/Hostuno 专用** |

## 🐳 Docker 部署

```bash
# 拉取并运行容器
docker run -d --restart=always -p 25500:25500 hxzlplp7/subconverter:latest

# 验证是否运行成功
curl http://localhost:25500/version
# 返回 "subconverter vx.x.x backend" 表示成功
```

Docker Compose 方式：

```yaml
version: '3'
services:
  subconverter:
    image: hxzlplp7/subconverter:latest
    container_name: subconverter
    ports:
      - "25500:25500"
    restart: always
```

## 🚀 Serv00/Hostuno 部署

1. 下载 FreeBSD 版本：
```bash
wget https://github.com/hxzlplp7/subconverter/releases/latest/download/subconverter_freebsd64.tar.gz
tar -xzf subconverter_freebsd64.tar.gz
cd subconverter
```

2. 运行：
```bash
chmod +x subconverter
./subconverter
```

3. 后台运行（使用 nohup 或 pm2）：
```bash
nohup ./subconverter > /dev/null 2>&1 &
```

## 📋 支持的格式

| 类型 | 作为源 | 作为目标 | 目标名称 |
|------|:------:|:--------:|----------|
| Clash | ✓ | ✓ | clash |
| ClashR | ✓ | ✓ | clashr |
| Quantumult | ✓ | ✓ | quan |
| Quantumult X | ✓ | ✓ | quanx |
| Loon | ✓ | ✓ | loon |
| SS (SIP002) | ✓ | ✓ | ss |
| SS Android | ✓ | ✓ | sssub |
| SSD | ✓ | ✓ | ssd |
| SSR | ✓ | ✓ | ssr |
| Surfboard | ✓ | ✓ | surfboard |
| Surge 2/3/4/5 | ✓ | ✓ | surge&ver=X |
| V2Ray | ✓ | ✓ | v2ray |
| Singbox | ✓ | ✓ | singbox |
| **AnyTLS** | ✓ | ✓ | (自动识别) |

## 🔧 快速使用

### 基本接口

```
http://127.0.0.1:25500/sub?target=目标格式&url=订阅链接
```

### 参数说明

| 参数 | 必填 | 示例 | 说明 |
|------|:----:|------|------|
| target | 是 | clash | 目标订阅格式 |
| url | 是 | https%3A%2F%2F... | 订阅链接（需 URL 编码） |
| config | 否 | https%3A%2F%2F... | 外部配置文件（需 URL 编码） |

### 合并多个订阅

使用 `|` 分隔多个订阅链接，然后进行 URL 编码：

```
原始链接：
https://sub1.com/link|https://sub2.com/link

URL 编码后：
https%3A%2F%2Fsub1.com%2Flink%7Chttps%3A%2F%2Fsub2.com%2Flink

完整请求：
http://127.0.0.1:25500/sub?target=clash&url=https%3A%2F%2Fsub1.com%2Flink%7Chttps%3A%2F%2Fsub2.com%2Flink
```

## 📤 自动上传到 Gist

1. 在 [GitHub 设置](https://github.com/settings/tokens/new) 创建 Personal Access Token
2. 编辑 `gistconf.ini`：
```ini
[common]
token = 你的Token
```
3. 在订阅链接后添加 `&upload=true`

## 🛠️ AnyTLS 转换示例

输入链接：
```
anytls://password@server:port?sni=example.com&fp=chrome#节点名称
```

转换后的 Clash 配置：
```yaml
- name: 节点名称
  type: anytls
  server: server
  port: port
  password: password
  client-fingerprint: chrome
  udp: true
  alpn: [h2, http/1.1]
  sni: example.com
  skip-cert-verify: true
```

## 🙏 致谢

- [tindy2013/subconverter](https://github.com/tindy2013/subconverter) - 原始项目
- [asdlokj1qpi23/subconverter](https://github.com/asdlokj1qpi23/subconverter) - 上游 fork

## 📄 许可证

GPL-3.0 License