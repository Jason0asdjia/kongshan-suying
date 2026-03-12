# custom 合并 origin/main 记录（2026-03-12）

本文档用于记录：在 `custom` 分支上，将远端 `origin/main` 的更新拉取并合并进来，同时保留 `custom` 的个性化修改。

## 合并信息

- 合并时间：`2026-03-12T22:10:31+09:00`
- 合并来源分支：`origin/main`
- 合并来源最新提交：`bef29d1`（Don't overdesign keyboardLayout）
- custom 合并提交：`bf129ab`（merge commit）
- 合并前双方共同基线（merge-base）：`d42be6f`

## 本次合并引入的提交（来自 origin/main）

以下提交来自 `origin/main`，在本次合并后进入 `custom`（来自 `git log --oneline bf129ab^1..bf129ab^2`）：

- `bef29d1` Don't overdesign keyboardLayout
- `53cde9e` explain color format
- `556f1c9` adjust some buttons in row numeric keyboard
- `d681875` for alphabetic keyboard, change numeric keyboard action to numericRowEn
- `4514d23` do not abuse std.prune to prevent compilation times from being too long
- `3db5d85` replace deepMerge by std.mergePatch
- `04ec3d6` remove segment action, and make shiftButton configurable in settings
- `811291b` update Buttons/README.md
- `684bfc5` add new numeric row keyboard for english
- `0dbb07b` allow config schemaName as space text
- `fa6c967` make side column wider in numeric9 and pinyin9 layout
- `066d5eb` remove useless code

## custom 分支在本次合并中产生冲突的文件与处理结果

本次合并使用普通 `git merge main`，产生冲突并已手动解决：

- `jsonnet/Components/BasicStyle.libsonnet`
  - 处理：以 `main` 的新版逻辑为主，删除旧的空格键 schemaName 样式冲突块，保留新版 `spaceButtonSchemaNameCenter != null` 的显示逻辑。
- `jsonnet/Constants/Colors.libsonnet`
  - 处理：保留 `custom` 的颜色取值（例如标准按键深色背景、accent 颜色的 light/dark 配置），同时补充 `main` 新增的颜色格式说明与更稳健的取色逻辑。
- `jsonnet/Constants/Fonts.libsonnet`
  - 处理：按 `main` 的字段集合为主，移除冲突中 `custom` 侧已不再需要的字段（例如 `numericCollectionTextFontSize`）。
- `jsonnet/Settings.libsonnet`
  - 处理：按 `main` 的设置结构为主（用 `spaceButtonSchemaNameCenter` 控制显示与否），并保留 `custom` 对该位置的微调：`{ x: 0.22, y: 0.7 }`。

## 合并后补丁（让编译通过 + 产物同步）

本次 `origin/main` 更新中移除了 `settings.segmentAction`（对应提交 `04ec3d6`）。合并后发现：

- `jsonnet/Buttons/Common.libsonnet` 的 `numericButton.whenPreeditChanged.action` 仍在引用 `settings.segmentAction`，导致 jsonnet 运行时报错。

已追加修复提交：

- `7288435` fix: restore segment action via shiftButtonParams
  - 将 `settings.segmentAction` 替换为 `settings.shiftButtonParams.whenPreeditChanged.action`。

同时由于本仓库在 `custom` 分支中跟踪了生成产物（`light/`、`dark/` 下的 `.yaml` 与 `.*.keyboard`），合并后需要重新生成并提交以保持与 `jsonnet/` 源一致：

- `939c841` chore: regenerate alphabetic/numeric/pinyin outputs

## 验证命令

编译验证（避免污染仓库，输出到临时目录）：

```bash
rm -rf .tmp
mkdir -p .tmp/light .tmp/dark
jsonnet -S -m .tmp --tla-code debug=true jsonnet/main.jsonnet
```
