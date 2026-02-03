# 「空山素影」皮肤特点
- 支持多种键盘布局，包括 26 键、9键、14键、17键、18键等布局。
- 数字键盘布局包括九宫格数字和全键盘数字。
- 不包含图片资源，风格接近原生键盘。
- 工具栏滑动按钮自定义，方便快速对工具栏进行个性化设置，且可以设置为纯文本工具栏。
- 空格键显示当前输入方案名称，方便查看当前输入方案。
- 中文模式下字母键大写显示，英文模式下字母键小写显示，是中文还是英文一目了然。
- 支持按键上下划动功能，26键盘布局可以输入 PC 键盘上的所有符号，可快速设置是否显示划动提示文字。
- a,z,x,c,v 五个按键下划对应全选、撤销、剪切、复制、粘贴，与 PC 键盘习惯一致。
- 按键支持特定的自定义语法，可以非常简单地实现各种按键功能。
- 主题色可选，满足不同用户的审美需求。
- 可以使用浮动面板中的“微调”功能对皮肤进行快速调整。

## 上下划动功能说明
```
1234567890 上划功能
qwertyuiop 按键
       |<> 下划功能

!^/;(-#{" 上划功能
asdfghjkl 按键
 `\:)_+}' 下划功能，a全选

@*%=[&? 上划功能
zxcvbnm 按键
    ]~$ 下划功能，z撤销、x剪切、c复制、v粘贴

backspace 上划清空文本，下划撤销
123 上划切换符号键盘，下划切换 emoji 键盘
逗号 上划输入句号
中/En 上划切换方案
enter 上划行首，下划行尾，长按换行
```

## 自定义皮肤调整说明

- 皮肤的基本设置`jsonnet/Settings.libsonnet`
  + 浮动键盘中的“微调”可以直接打开该文件进行编辑。
  + 修改后保存，重新编译皮肤即可生效。

- 键盘按键功能设置`jsonnet/Buttons/`
  + 浮动键盘中的“按键”会打开`jsonnet/Buttons/`文件夹下的 README.md，方便查看各按键在哪个文件
  + 退出 README.md 后再打开同目录下的具体按键文件进行编辑。
  + 修改后保存，重新编译皮肤即可生效。

## 手机端编译

长按皮肤，选择「运行 main.jsonnet」

## PC 端编译

PC 端编译时需要安装 `jsonnet` 等命令行工具。

```shell
jsonnet -S -m . --tla-code debug=true .\jsonnet\main.jsonnet
```

## 维护方式（跟随上游更新 + 保留自定义）

本仓库是从上游仓库 fork 而来：

- `upstream`：原作者仓库 `luozikuan/kongshan-suying`
- `origin`：你自己的 fork 仓库
- 分支约定：
  - `main`：尽量保持和上游一致（只用来同步更新）
  - `custom`：你的个性化修改都放这里（日常开发/提交都在 custom）

### 0) 一次性检查（只需要做一次）

确认远端配置正确：

```bash
git remote -v
```

预期：
- `origin` 指向你的 fork
- `upstream` 指向原作者仓库

### 1) 上游作者更新后，如何更新 fork 的 main

方式 A（推荐，最省事）：在 GitHub 网页点同步

1. 打开你 fork 的仓库页面
2. 点击 `Sync fork`（同步上游到你 fork 的 `main`）

然后回到本地，把 `origin/main` 拉下来：

```bash
git checkout main
git pull origin main
```

方式 B（纯命令行，本地直接跟上游同步 main）

```bash
git fetch upstream --tags
git checkout main
git merge --ff-only upstream/main
```

如果你还希望把同步后的 `main` 推回 GitHub（让 fork 的 main 也更新）：

```bash
git push origin main
```

### 2) 把 main 的更新合并到 custom（保留你的修改）

```bash
git checkout custom
git merge main
```

如果没有冲突，这一步会直接生成一个 merge commit（或 fast-forward）。

如果发生冲突：

1) 查看冲突文件列表：

```bash
git status
git diff --name-only --diff-filter=U
```

2) 打开这些文件，手动处理冲突标记：

- `<<<<<<<` / `=======` / `>>>>>>>`

原则：
- 保留你想要的自定义行为/样式（通常在 `custom` 里）
- 同时把上游的新改动合进来（避免把上游改动整段丢掉）

3) 标记冲突已解决并完成合并：

```bash
git add <冲突文件...>
git commit
```

### 3) 合并后如何用 jsonnet 做一次“能跑通”的测试

1) 确认 jsonnet 已安装：

```bash
jsonnet --version
```

2) 生成输出到临时目录（避免污染仓库）。目录结构需要包含 `light/`、`dark/`：

```bash
rm -rf .generated
mkdir -p .generated/light .generated/dark
jsonnet -S -m .generated --tla-code debug=true jsonnet/main.jsonnet
```

预期会生成：
- `.generated/config.yaml`
- `.generated/light/*.yaml`
- `.generated/dark/*.yaml`

3) 快速校验生成结果是否完整：

```bash
ls -la .generated
ls -la .generated/light
ls -la .generated/dark
```

如果 jsonnet 报错：通常会包含具体文件路径和行号，按报错定位修复即可。
