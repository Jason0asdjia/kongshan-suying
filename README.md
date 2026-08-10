# 🌿 空山素影 · Custom 分支

> 基于 [luozikuan/kongshan-suying](https://github.com/luozikuan/kongshan-suying) 的个性化定制版本

---

## ✨ Custom 与 Main 的差异

| 项目 | Main 原版 | Custom 定制 | 说明 |
|------|-----------|-------------|------|
| 亮色按键下边缘 | `#898A8D` | `#DCDEE3` 💧 | 大幅淡化，接近 iOS 原生键盘的无缝质感 |
| 亮色按下边缘 | `#898A8D` | `#CFD1D7` | 按下时边缘依然柔和 |
| 暗色按键下边缘 | `#1E1E1E` | 保持原版 🌙 | 暗色模式原有深度感已足够 |

> 📍 修改位置：`jsonnet/Constants/Colors.libsonnet` → `lowerEdgeOfButtonNormalColor` / `lowerEdgeOfButtonHighlightColor`

### 🎨 效果对比

```
         原版 (main)                   定制 (custom)
   ┌─────────────────┐          ┌─────────────────┐
   │     Q W E       │          │     Q W E       │
   │  ▔▔▔▔▔▔▔▔▔▔▔  │          │                 │
   │  深色下影线 👁    │          │  几乎无缝 ✨     │
   └─────────────────┘          └─────────────────┘
    #898A8D 边缘明显              #DCDEE3 融化在背景中
```

### 📦 预编译文件

`light/` 和 `dark/` 目录包含已编译的 `.yaml` 文件，可直接导入使用：

- 🚀 无需 jsonnet 环境，直接导入到仓/元书
- 📱 手机上快速切换皮肤

---

## ⚡ 快速开始

1. 在仓/元书中导入本仓库
2. 选择「空山素影」皮肤
3. 如需调整 → 修改 `jsonnet/Constants/Colors.libsonnet` → 运行 `main.jsonnet`

## 🛠 编译

- 📱 手机端：长按皮肤 → 「运行 main.jsonnet」
- 💻 PC 端：
  ```bash
  jsonnet -S -m . --tla-code debug=true ./jsonnet/main.jsonnet
  ```

## 🔄 同步上游

```bash
git checkout main
git pull origin main
git checkout custom
git merge main
```
