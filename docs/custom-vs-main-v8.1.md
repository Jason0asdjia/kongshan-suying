# custom 与 main 的差异记录（v8.1）

本文档用于记录：基于 `v8.1` 版本（上游 `main`）时，`custom` 分支相对 `main` 做了哪些修改，以及如何在拉取 `main` 最新改动后保持这些修改。

## 参考基线

- main 的 v8.1 基线（tag）：`v8.1`（`aa1045f`）
- main 最新合并点：`origin/main`（`3290216`）
- custom 合并 main 后的 HEAD：`custom`（`650f20d`）

## custom 分支在 v8.1 相关的新增/修改

custom 开始将“生成产物”纳入 git 跟踪（不再忽略），主要包括：

- 新增：`config.yaml`
- 新增：`demo.png`
- 新增：`dark/` 下的皮肤产物文件（`*.yaml`、`.*.keyboard` 等）
- 新增：`light/` 下的皮肤产物文件（`*.yaml`、`.*.keyboard` 等）

并相应修改了 `.gitignore`：不再忽略上述文件，从而允许提交到仓库。

## 引入上述修改的 custom 提交

- `7728085` chore: add v8.1 config and demo
- `3ba1047` chore: add v8.1 dark skin assets
- `2f22b3b` chore: add v8.1 light skin assets
- `aefe732` chore: track generated skin outputs

## custom 如何拉取并合并 main 的最新版本

custom 通过 merge 的方式合并 main 最新改动：

- `650f20d` Merge remote-tracking branch 'origin/main' into custom

## 验证命令

用于核对 `custom` 相对 `origin/main` 的差异（限定到 v8.1 相关路径）：

```bash
git diff --name-status origin/main..HEAD -- config.yaml demo.png .gitignore dark light
git diff --stat origin/main..HEAD -- config.yaml demo.png .gitignore dark light
```
