# 本地修改整理（2026-05-18）

分支：`custom`  
基线：当前工作区未提交改动（`git status`）

## 1. 本次改动概览

- 变更文件：28 个
- 代码统计：+106 / -919（以删除冗余布局与组件为主）
- 主要方向：
  - 收敛键盘布局能力，移除较少使用的 Sigma 与 Hex 相关实现
  - 精简 Settings 与 README 文档中的可选项说明，保持与当前代码一致
  - 在工具函数中补充 Rime option changed notification 的通用构造能力
  - 同步更新 dark/light 下已生成的 yaml 文件

## 2. 结构性调整

### 已删除文件

- `jsonnet/Buttons/LayoutSigma.libsonnet`
- `jsonnet/Components/iPhonePinyinSigma.libsonnet`
- `jsonnet/Components/iPhoneNumericHex.libsonnet`
- `dark/.gitkeep`
- `light/.gitkeep`

### 相关精简

- `jsonnet/Buttons/LayoutNumeric.libsonnet`：删除 Hex（A-F、\\、x）按键定义
- `jsonnet/Settings.libsonnet`：移除 `keyboardLayout: sigma` 与 `numericLayout: hex` 的说明
- `README.md`：删除对 Sigma / Hex 的介绍，改为与现状一致的布局说明

## 3. 能力补充与行为微调

- `jsonnet/Components/Utils.libsonnet`
  - 新增 `rimeOptionChangedForegroundStyleName`
  - 新增 `rimeOptionChangedNotificationName`
  - 新增 `newRimeOptionChangedNotification`
  - 并导出以上工具函数，供组件层复用

- `jsonnet/Settings.libsonnet`
  - 调整 `uppercaseForChinese` 注释，明确在不同布局下的生效范围
  - `shiftButton.whenPreeditChanged` 相关配置改为注释保留（分词/Shift/Tab 示例）

## 4. 关联文件更新

- 按键与组件：
  - `jsonnet/Buttons/Common.libsonnet`
  - `jsonnet/Buttons/Layout26.libsonnet`
  - `jsonnet/Buttons/Layout9.libsonnet`
  - `jsonnet/Buttons/Toolbar.libsonnet`
  - `jsonnet/Buttons/README.md`
  - `jsonnet/Components/BasicStyle.libsonnet`
  - `jsonnet/Components/iPhoneBopomofo.libsonnet`
  - `jsonnet/Components/iPhoneNumeric.libsonnet`
  - `jsonnet/Components/iPhoneNumericRow.libsonnet`
  - `jsonnet/Components/iPhonePinyin.libsonnet`
  - `jsonnet/Components/iPhonePinyin26.libsonnet`

- 编译产物（主题 yaml）：
  - `dark/alphabeticLandscape.yaml`
  - `dark/alphabeticPortrait.yaml`
  - `dark/pinyinLandscape.yaml`
  - `dark/pinyinPortrait.yaml`
  - `light/alphabeticLandscape.yaml`
  - `light/alphabeticPortrait.yaml`
  - `light/pinyinLandscape.yaml`
  - `light/pinyinPortrait.yaml`

## 5. 结论

本次改动核心是“减法”：移除 Sigma 与 Hex 两套链路，收敛维护范围；同时补齐 Rime option changed notification 的通用工具能力，并将文档说明与当前可用配置对齐。
