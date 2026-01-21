# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含中文9键布局的按键
# =====================================

local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local settings = import '../Settings.libsonnet';

{
  local root = self,

  height: {
    iPhone: {
      portrait: 216,  // 54 * 4
      landscape: 160,  // 40 * 4
    },
    iPad: {
      portrait: 311,  // 64 * 4 + 55
      landscape: 414,  // 86 * 4 + 70
    },
  },

  button: {
    backgroundInsets: {
      iPhone: {
        portrait: { top: 3, left: 4, bottom: 3, right: 4 },
        landscape: { top: 3, left: 3, bottom: 3, right: 3 },
      },
      ipad: {
        portrait: { top: 3, left: 3, bottom: 3, right: 3 },
        landscape: { top: 4, left: 6, bottom: 4, right: 6 },
      },
    },
  },

  // T9 按键
  t9OneButton: {
    name: 't9OneButton',
    params: {
      action: { character: '1' },
      swipeUp: { action: { symbol: '1' } },
      text: '@/.',

      whenPreeditChanged: {
        text: '分词',
      }
    },
  },
  t9TwoButton: {
    name: 't9TwoButton',
    params: {
      action: { character: '2' },
      swipeUp: { action: { symbol: '2' } },
      text: 'ABC',
    },
  },
  t9ThreeButton: {
    name: 't9ThreeButton',
    params: {
      action: { character: '3' },
      swipeUp: { action: { symbol: '3' } },
      text: 'DEF',
    },
  },
  t9FourButton: {
    name: 't9FourButton',
    params: {
      action: { character: '4' },
      swipeUp: { action: { symbol: '4' } },
      text: 'GHI',
    },
  },
  t9FiveButton: {
    name: 't9FiveButton',
    params: {
      action: { character: '5' },
      swipeUp: { action: { symbol: '5' } },
      text: 'JKL',
    },
  },
  t9SixButton: {
    name: 't9SixButton',
    params: {
      action: { character: '6' },
      swipeUp: { action: { symbol: '6' } },
      text: 'MNO',
    },
  },
  t9SevenButton: {
    name: 't9SevenButton',
    params: {
      action: { character: '7' },
      swipeUp: { action: { symbol: '7' } },
      text: 'PQRS',
    },
  },
  t9EightButton: {
    name: 't9EightButton',
    params: {
      action: { character: '8' },
      swipeUp: { action: { symbol: '8' } },
      text: 'TUV',
    },
  },
  t9NineButton: {
    name: 't9NineButton',
    params: {
      action: { character: '9' },
      swipeUp: { action: { symbol: '9' } },
      text: 'WXYZ',
    },
  },
  t9ZeroButton: {
    name: 't9ZeroButton',
    params: {
      action: { character: '0' },
      swipeUp: { action: { symbol: '0' } },
      fontSize: 20,
    },
  },

  t9Buttons: [
    self.t9OneButton,
    self.t9TwoButton,
    self.t9ThreeButton,
    self.t9FourButton,
    self.t9FiveButton,
    self.t9SixButton,
    self.t9SevenButton,
    self.t9EightButton,
    self.t9NineButton,
    self.t9ZeroButton,
  ],

  // t9拼音符号列表兼拼音候选
  t9SymbolsCollection: {
    name: 't9SymbolsCollection',
    params: {
      type: 't9Symbols',
    },
  },
}
