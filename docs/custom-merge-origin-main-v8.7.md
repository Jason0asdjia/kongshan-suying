# custom 合并 origin/main 记录（v8.7）

本文档用于记录：在 `custom` 分支上合并远端 `origin/main` 的更新时，本次合并引入了哪些改动、合并策略与验证方式。

备注：仓库内目前最高 tag 为 `v8.4`，本次 `origin/main` 的最新提交为 `d42be6f`，`git describe --tags d42be6f` 输出为 `v8.4-40-gd42be6f`。

## 合并信息

- 合并时间：`2026-03-07T20:33:06+09:00`
- 合并来源分支：`origin/main`
- 合并来源最新提交：`d42be6f`
- custom 合并提交：`cf311d8`（merge commit）
- 合并前双方共同基线（merge-base）：`3b572b3`（tag: `v8.4`）

## 本次合并引入的提交（来自 origin/main）

以下提交来自 `origin/main`，在本次合并后进入 `custom`（来自 `git log --oneline cf311d8^1..cf311d8^2`）：

- `d42be6f` add 分词 icon for shiftButton.whenPreeditChanged
- `7b8ea4a` add '简繁'(Control+Shift+dollar) switch to candidate contex menu
- `adcb21a` toolbarPreferIcon was renamed to preferIcon and affected more places
- `9a88321` remove settings.spaceButtonShowSchema, use spaceButtonSchemaNameCenter:null to indicate hiding
- `3e30647` simplify space button config in bopomofo
- `f9adfa8` fix swipe text on space when settings.swipeUpTextCenter=hide
- `6252be8` no logic change, improve readablity
- `14d5b6b` fix swipeUp/Down display glitch in notification when swipeUpTextCenter set to hide
- `d8abf9c` simplify code
- `09bec44` set clearPreeditButton.action to 换行 and whenPreeditChanged.action to 重输
- `d606b70` change enter.longPress 换行 icon to 'return'
- `95fe7db` t9 set space.swipeUp from character 0 to symbol 0
- `1f98955` fix swipe text not change when set in whenPreeditChanged.swipeUp/swipeDown
- `be7596b` take care of the situation where there is no backgroundStyle property
- `c23f36d` update README
- `7dd1410` support repeatAction for moveCursorForward/Backward when slider area disabled
- `6658033` use openSkinsFile to open files in current skin, so remove SkinConfig.libsonnet
- `1b7c44e` change yuanshu icon
- `518acf8` update Buttons/README.md for longPress.selected default value changes
- `a336c8a` add Common.iOSNextKeyboardButton for later use
- `f153f32` change iPad keyboard height
- `47011d7` remove useless code
- `4fa39c2` simplify code
- `0050809` change emoji system image in toolbar
- `8b78b12` add globe into number longPress for iPad
- `ed97cb1` change default segment action to single quote char
- `631b3df` shift button act as segment when preedit changed
- `cb03103` replace isAlphabetic/isForTempUse with keyboardType enum
- `643bf55` add space for two letters button
- `39a6553` remove dangling import
- `02f70e6` fix typo
- `6f0ec09` for 26 layout, long press to input uppercase character
- `b4e1484` default select center item in long press list
- `589f809` reimplement alphabetic keyboard by adding isAlphabetic param to pinyin26 keyboard
- `d5d0a40` fix border color not displayed
- `687d63c` make comma and alphabetic key bigger in layout 14/17/18
- `83a178c` add purple accentColor
- `13badcf` add bopomofo layout
- `5b1ec2e` update README
- `8d67616` allow set backgroundStyle in button.params

## custom 分支在本次合并中实际变更的文件

本次 merge commit（`cf311d8`）相对合并前的 `custom`，实际更新的文件如下（来自 `git show --stat cf311d8`）：

- `README.md`
- `jsonnet/Buttons/Common.libsonnet`
- `jsonnet/Buttons/Layout14.libsonnet`
- `jsonnet/Buttons/Layout18.libsonnet`
- `jsonnet/Buttons/Layout26.libsonnet`
- `jsonnet/Buttons/Layout9.libsonnet`
- `jsonnet/Buttons/LayoutBopomofo.libsonnet`（新增）
- `jsonnet/Buttons/LayoutNumeric.libsonnet`
- `jsonnet/Buttons/README.md`
- `jsonnet/Buttons/Toolbar.libsonnet`
- `jsonnet/Components/BasicStyle.libsonnet`
- `jsonnet/Components/Temp26KeyLayout.libsonnet`
- `jsonnet/Components/Toolbar.libsonnet`
- `jsonnet/Components/Utils.libsonnet`
- `jsonnet/Components/iPhoneAlphabetic.libsonnet`
- `jsonnet/Components/iPhoneBopomofo.libsonnet`（新增）
- `jsonnet/Components/iPhoneNumeric9.libsonnet`
- `jsonnet/Components/iPhoneNumericRow.libsonnet`
- `jsonnet/Components/iPhonePinyin.libsonnet`
- `jsonnet/Components/iPhonePinyin14.libsonnet`
- `jsonnet/Components/iPhonePinyin17.libsonnet`
- `jsonnet/Components/iPhonePinyin18.libsonnet`
- `jsonnet/Components/iPhonePinyin26.libsonnet`
- `jsonnet/Components/iPhonePinyin9.libsonnet`
- `jsonnet/Settings.libsonnet`
- `jsonnet/SkinConfig.libsonnet`（删除）

## 合并策略（保留 custom 为主）

本次合并使用的命令：

```bash
git fetch origin
git checkout custom
git merge origin/main -X ours
```

说明：

- `-X ours` 的含义是：当发生冲突时，优先保留当前分支（`custom`）在冲突 hunk 中的内容。
- 非冲突的 `origin/main` 改动仍会被合并进来，用于吸收更新与修复。

## 合并后补丁（让编译通过）

合并后在本地编译时触发运行时断言（`newStyleByPriority 生成样式失败`），原因是部分 `swipeUp/swipeDown` 仅配置了 `action.shortcut`，但未配置可用于显示的 `text/systemImageName/assetImageName`。

已在 `jsonnet/Buttons/Common.libsonnet` 为相关 `swipeUp/swipeDown` 补齐 `text`，对应提交：`4674628`。

## 验证命令

快速查看本次合并引入的提交：

```bash
git log --oneline cf311d8^1..cf311d8^2
```

查看合并对 `custom` 的实际修改范围：

```bash
git show --stat cf311d8
```

编译验证（避免污染仓库，输出到临时目录）：

```bash
rm -rf .generated
mkdir -p .generated/light .generated/dark
jsonnet -S -m .generated --tla-code debug=true jsonnet/main.jsonnet
```
