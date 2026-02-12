# custom 合并 upstream/main 记录（v8.4）

本文档用于记录：在 `custom` 分支上合并上游仓库 `upstream/main` 的更新时，本次合并引入了哪些上游改动，以及合并策略与验证方式。

## 合并信息

- 合并时间：`2026-02-12T18:12:22+09:00`
- 上游分支：`upstream/main`
- 上游最新提交：`3b572b3`（tag: `v8.4`）
- custom 合并后的提交：`72d140c`（merge commit）
- 合并前双方共同基线（merge-base）：`3290216`

## 本次合并引入的上游提交

以下提交来自 `upstream/main`，在本次合并后进入 `custom`：

- `3b572b3` change the way to config swipeUp/Down text, allow set position or hide
- `b14d554` change button order of verticalCandidatePage
- `606025a` swipeUp space to choose second candidate
- `a66e97f` for non-26-key layout, swipedown 中/En to open temp26Key keyboard
- `4d230fa` numericSymbols / t9Symbols don't support CellStyle

## custom 分支在本次合并中实际变更的文件

本次 merge commit（`72d140c`）相对合并前的 `custom`，实际更新的文件如下（来自 `git show --stat 72d140c`）：

- `jsonnet/Buttons/Common.libsonnet`
- `jsonnet/Components/BasicStyle.libsonnet`
- `jsonnet/Components/Toolbar.libsonnet`
- `jsonnet/Components/Utils.libsonnet`
- `jsonnet/Components/iPhoneAlphabetic.libsonnet`
- `jsonnet/Components/iPhoneNumeric9.libsonnet`
- `jsonnet/Components/iPhoneNumericRow.libsonnet`
- `jsonnet/Components/iPhonePinyin14.libsonnet`
- `jsonnet/Components/iPhonePinyin17.libsonnet`
- `jsonnet/Components/iPhonePinyin18.libsonnet`
- `jsonnet/Components/iPhonePinyin26.libsonnet`
- `jsonnet/Components/iPhonePinyin9.libsonnet`
- `jsonnet/Settings.libsonnet`

## 合并策略（保留 custom 为主）

本次合并使用的命令：

```bash
git fetch upstream
git checkout custom
git merge upstream/main -X ours
```

说明：

- `-X ours` 的含义是：当发生冲突时，优先保留当前分支（`custom`）在冲突 hunk 中的内容。
- 非冲突的上游改动仍会被合并进来，用于吸收上游的 bugfix / 行为更新。

## 验证命令

快速查看本次合并是否引入了预期的上游提交：

```bash
# 列出 merge commit 引入的上游提交（第二父分支独有的提交）
git log --oneline 72d140c^1..72d140c^2
```

查看合并对 `custom` 的实际修改范围：

```bash
git show --stat 72d140c
```
