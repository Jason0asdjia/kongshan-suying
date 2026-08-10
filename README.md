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

## ⌨️ 按键功能映射

> 以下为 `custom` 当前配置。`↑` 表示上滑，`↓` 表示下滑；“长按”表示长按后可选动作。字母键在中文/英文状态下会根据 Rime 状态显示相应大小写。

### 🔤 26 键字母区

| 按键 | 默认输入 | ↑ 上滑 | ↓ 下滑 | 长按/特殊功能 |
|---|---:|---:|---:|---|
| Q | q / Q | ! | 1 | Q |
| W | w / W | @ | 2 | W |
| E | e / E | # | 3 | E |
| R | r / R | $ | 4 | R |
| T | t / T | % | 5 | T、Tab、简繁切换 |
| Y | y / Y | ^ | 6 | Y |
| U | u / U | & | 7 | U |
| I | i / I | * | 8 | I |
| O | o / O | \| | 9 | O |
| P | p / P | ? | 0 | P |
| A | a / A | ~ | 全选 | A、左手模式 |
| S | s / S | - | _ | S |
| D | d / D | = | + | D |
| F | f / F | [ | ] | F、`{}` |
| G | g / G | — | — | G |
| H | h / H | ( ) | 「」 | H |
| J | j / J | / | \ | J |
| K | k / K | ; | : | K |
| L | l / L | ' | " | L、右手模式 |
| Z | z / Z | ` | 撤销 | Z |
| X | x / X | , | 剪切 | X |
| C | c / C | . | 复制 | C |
| V | v / V | — | 粘贴 | V |
| B | b / B | ‘’ | “” | B |
| N | n / N | 、 | … | N |
| M | m / M | — | `.com` | M、`.com`、`@gmail.com` |

### 🔢 数字键盘

| 按键 | 点击 | ↑ 上滑 | ↓ 下滑 | 说明 |
|---|---|---|---|---|
| 0–9 | 输入数字 | — | — | 通过 `character` 输入 Rime |
| 空格 | 空格 | — | **粘贴** | ↓ 执行 `#paste`，显示“粘贴” |
| `=` | 输入等号 | — | — | 交给 Rime，可作为计算器输入字符 |
| `function` | 发送 `cC` | `:` | — | 进入 rice 计算器；实际使用 `cC1+2` |
| `.` | 小数点 | — | — | 预编辑状态下交给 Rime |
| `-` | 减号 | — | — | 注音布局下直接上屏 |
| `/` | 斜杠 | — | — | 行式数字键盘符号 |
| `;` | 分号 | — | — | 行式数字键盘符号 |
| `:` | 冒号 | — | — | 行式数字键盘符号 |
| `(` / `)` | 括号 | — | — | 行式数字键盘符号 |
| `$` / `@` | 符号 | — | — | 行式数字键盘符号 |

> 🧮 计算器：点击 `function` 后输入算式，例如 `cC1+2`。`function` 键使用 `sendKeys: 'cC'` 发送给 Rime，而不是直接上屏。

### 🧰 公共功能键

| 按键 | 点击 | ↑ 上滑 | ↓ 下滑 | 长按 |
|---|---|---|---|---|
| Backspace | 删除 | 清空文本 | 撤销 | — |
| Enter | 回车/确认 | 行首 | 行尾 | 换行 |
| Space | 空格 | 次选上屏 | 三选上屏 | — |
| 逗号 | `,` | `.` | — | — |
| 中/En | 中英切换 | 方案切换 | — | — |
| `123` | 数字键盘 | 符号键盘 | Emoji 键盘 | — |
| 工具栏 | — | — | — | 常用语、剪贴板、方案、脚本等 |

### 📌 说明

- `character`：交给元书 Rime 引擎处理。
- `symbol`：绕过 Rime，直接上屏。
- `sendKeys`：向 Rime 发送一组字符；当前数字键盘 `function` 使用 `sendKeys: 'cC'`。
- 具体实现文件：`jsonnet/Buttons/Layout26.libsonnet`、`LayoutNumeric.libsonnet`、`Common.libsonnet`。
- 修改后运行 `main.jsonnet`，再重新加载皮肤。

## 🔄 同步上游

```bash
git checkout main
git pull origin main
git checkout custom
git merge main
```
