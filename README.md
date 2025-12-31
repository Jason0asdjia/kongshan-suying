# 「空山素影」

皮肤文件通过 `Jsonnet` 语法编写，在手机端首次使用时请执行「运行 main.jsonnet」进行编译生成皮肤配置文件。

PC 端编译时需要安装 `jsonnet` 等命令行工具。

该皮肤主要与“空山五笔”方案配合使用。

## 使用说明

本皮肤不包含「英文键盘」，中英切换键使用 RIME 的 `ascii_mode` 切换。

上下划动功能说明如下：
```
1234567890 上划功能
qwertyuiop 按键

!^/;(-#{" 上划功能
asdfghjkl 按键
 |\:)_+}' 下划功能，a全选

@*%=[&? 上划功能
zxcvbnm 按键
    ]~$ 下划功能，z撤销、x剪切、c复制、v粘贴

backspace 上划清空文本，下划撤销
123 上划切换符号键盘，下划切换 emoji 键盘
逗号 上划输入句号
中英 上划切换方案
enter 下划换行
```

## 自定义皮肤调整说明

- `jsonnet/Settings.libsonnet`: 定义了皮肤的基本设置，浮动键盘中的“微调”可以直接打开该文件进行编辑。

  + `usePCLayout`: 是否使用 PC 布局，启用后 zxcv 行按键左移半格。
  + `spaceButtonComposingText`: 打字时空格键上显示的文字内容。
  + `spaceButtonShowSchema`: 空格键上是否显示当前输入方案名称。
  + `spaceButtonSchemaNameCenter`: 方案名称在空格键上的位置，有的方案名称较长，需要调整 x 值以免超出按键。
  + `showSwipeUpText`: 是否显示按键的上划文字显示。
  + `showSwipeDownText`: 是否显示按键的下划文字显示。
  + `toolbarButtonsMaxCount`: 工具栏滑动按钮的显示个数。
  + `toolbarButtons`: 工具栏显示的滑动按钮列表，按顺序排列。
  + `toolbarPreferIcon`: 工具栏按钮以图标显示。
  + `accentColor`: 主题色选择。
  + `uppercaseForChinese`: 中文模式下，字母键是否大写显示。
  + `segmentAction`: 分词键，用于输入方案中分词使用。
  + `showFunctionButton`: 是否显示空格左侧的功能键。
  + `functionButtonParams`: 空格左侧功能键的功能定义。

- `jsonnet/Constants/Keyboard.libsonnet`: 定义了键盘按键，各区域高度等常量。浮动键盘中的“按键”可以直接打开该文件进行编辑。

  + 具体配置语法可以参考下方的「按键语法说明」章节。

## 手机端编译

长按皮肤，选择「运行 main.jsonnet」

## PC 端编译

```shell
jsonnet -S -m . --tla-code debug=true .\jsonnet\main.jsonnet
```


## 按键语法说明
一个常规的按键定义如下：

```jsonnet
aButton: {
  name: 'aButton',
  params: {
    action: { character: 'a' },

    uppercased: {
      action: { character: 'A' }
    },

    swipeUp: {
      action: { character: '!' }
    },

    swipeDown: {
      action: { shortcut: '#selectText' },
      text: '全'
    },

    longPress: [
      {
        action: { shortcut: '#左手模式' },
        systemImageName: 'keyboard.onehanded.left'
      },
    ],
  },
},
```


### uppercased 大写定义、swipeUp，swipeDown 上下划动定义

其中 `uppercased`, `swipeUp` 和 `swipeDown` 中可以定义新的 action，在指定情况下覆盖默认的按键行为，例如`swipeUp: { action: { character: '!' } },` 会将上划动作设置为`!`，并且将上划字符显示在合适的位置。前景显示会通过 action 自动推导，对于无法推导的情况，可以手动添加 `text` 或 `systemImageName` 来指定显示内容，例如下划的 `#selectText` 无法推导，就指定了 `text: '全'`。


### longPress 长按列表
`longPress` 则是一个按键长按菜单的定义，可以添加多个菜单项。如果需要指定初始选中项，可以在菜单项中添加 `selected: true`，如果没有指定 `selected: true`，则默认选中第一个菜单项。例如:
```jsonnet
pButton: {
  name: 'pButton',
  params: {
    action: { character: 'p' },

    longPress: [
      {
        action: { character: 'p' },
      },
      {
        action: { character: '0' },
      },
      {
        action: { character: 'P' },
        selected: true,  # 初始选中项
      },
    ],
  },
},
```

### capsLocked 大写锁定状态定义
还可以对 `capsLocked` 状态进行单独定义，其中可以指定 action、text 或 systemImageName 覆盖默认值，以 shiftButton 为例：

```jsonnet
shiftButton: {
  name: 'shiftButton',
  params: {
    systemImageName: 'shift',
    action: 'shift',

    uppercased: { systemImageName: 'shift.fill', },

    # 大写锁定状态下显示的图标
    capsLocked: { systemImageName: 'capslock.fill', },
  },
},
```

### whenAsciiModeOn, whenAsciiModeOff 当 Rime 选项 ascii_mode 打开或关闭时的定义
whenAsciiModeOn 和 whenAsciiModeOff 只用定义一个即可，以字母键 b 为例，如果我们想让它在中文模式下显示为大写，英文模式下显示为小写，则可以写出如下配置：

```jsonnet
bButton: {
  name: 'bButton',
  params: {
    action: { character: 'b' },

    whenAsciiModeOff: { text: 'B' },
  },
},
```
上面的配置表示，当 ascii_mode 关闭时（即中文模式），显示为大写 B；params 中的 action 定义则自动被推导为在 ascii_mode 打开时生效（即英文模式），显示为小写 b。

whenAsciiModeOn / whenAsciiModeOff 还可以对 swipeUp / swipeDown 等进行重新定义，例如逗号键，在中文模式和英文模式下，显示有差异，如做如下配置：

```jsonnet
commaButton: {
  name: 'commaButton',
  params: {
    action: { character: ',' }, center: { y: 0.48 },
    swipeUp: { action: { character: '.' }, center: { y: 0.28 } },

    whenAsciiModeOff: {  # 中文模式下
      text: '，', center: { y: 0.52 },
      swipeUp: { text: '。', center: { y: 0.3 } },
    },
  },
},
```
解释：whenAsciiModeOff 中的定义会覆盖默认的 action 和 swipeUp 定义，从而在中文模式下显示中文逗号和句号，而在英文模式下会由 params.action 和 params.swipeUp.action 自动推导显示英文逗号和句号。

如果有需要，也可以在 whenAsciiModeOn / whenAsciiModeOff 中对 action / swipeUp.action / swipeDown.action 进行重新定义。比如，如果想让逗号键在中文模式上划输入句号，但在英文模式下直接输入句号，上划输入逗号，则可以这样写：

```jsonnet
commaButton: {
  name: 'commaButton',
  params: {
    # 英文模式输入为句号
    action: { character: '.' }, center: { y: 0.48 },
    # 英文模式上划输入逗号
    swipeUp: { action: { character: ',' }, center: { y: 0.28 } },

    whenAsciiModeOff: {  # 中文模式下
      # 中文模式输入为逗号
      action: { character: ',' },
      text: '，', center: { y: 0.52 },

      swipeUp: {
        # 中文模式上划输入句号
        action: { character: '.' },
        text: '。',
        center: { y: 0.3 },
      },
    },
  },
},
```

### whenPreeditChanged 当预编辑文本变化时的定义
`whenPreeditChanged` 可以用来定义按键在有预编辑文本时的显示和行为，例如左下角的 123 按键，没打字时功能为切换数字键盘，有预编辑文本时功能为分词键，写法如下：

```jsonnet
numericButton: {
  name: 'numericButton',
  params: {
    action: { keyboardType: 'numeric' },
    text: '123',

    whenPreeditChanged: {
      action: { character: "'" },  # 分词键单引号
      text: '分词',
    },
  },
},
```
因为不想使用推导出的 `'` 作为按键显示，所以手动指定了 `text` 为“分词”。

### whenKeyboardAction 当监听到某个键盘动作时的定义
`whenKeyboardAction` 可以用来定义按键在监听到某个键盘动作时，当前按键应该变成什么样子。举例来说，如果空格左边放一个功能键，功能为“全选”，当执行“全选”后，想让该按键变成“剪切”，这样就可以双击此按钮来实现“全选”加“剪切”，配置可以这样写：

```jsonnet
functionButton: {
  name: 'functionButton',
  params: {
    action: { shortcut: '#selectText' },
    systemImageName: 'selection.pin.in.out',

    whenKeyboardAction: [
      {
        notificationKeyboardAction: {
          shortcut: '#selectText'
        },
        action: { shortcut: '#cut' },
        systemImageName: 'scissors',
      },
    ],
  },
},
```
上面的配置表示，当监听到“全选”动作时，按键变成“剪切”功能，并且图标变成剪刀图标。当“剪切”动作执行后，按键会自动恢复回“全选”功能。

如果想让按键在监听到某个动作后变成另一个动作，并且锁定这个新动作，可以添加 `lockedNotificationMatchState: true` 属性，例如：

```jsonnet
functionButton: {
  name: 'functionButton',
  params: {
    action: { shortcut: '#selectText' },
    systemImageName: 'selection.pin.in.out',

    whenKeyboardAction: [
      {
        notificationKeyboardAction: {
          shortcut: '#selectText'
        },
        action: { shortcut: '#cut' },
        systemImageName: 'scissors',

        # 变成剪切后就一直是剪切，不会自动恢复回全选
        lockedNotificationMatchState: true,
      },
    ],
  },
},
```

