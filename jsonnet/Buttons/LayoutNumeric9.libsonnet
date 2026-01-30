# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含9键数字布局中的按键
# =====================================

local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local settings = import '../Settings.libsonnet';

{
  local root = self,

  button: {
    backgroundInsets: if !settings.iPad then
      {
        portrait: { top: 3, left: 4, bottom: 3, right: 4 },
        landscape: { top: 3, left: 3, bottom: 3, right: 3 },
      }
      else
      {
        portrait: { top: 3, left: 3, bottom: 3, right: 3 },
        landscape: { top: 4, left: 6, bottom: 4, right: 6 },
      },
  },

  // 数字键
  oneButton: {
    name: 'oneButton',
    params: {
      action: { character: '1' },
    },
  },
  twoButton: {
    name: 'twoButton',
    params: {
      action: { character: '2' },
    },
  },
  threeButton: {
    name: 'threeButton',
    params: {
      action: { character: '3' },
    },
  },
  fourButton: {
    name: 'fourButton',
    params: {
      action: { character: '4' },
    },
  },
  fiveButton: {
    name: 'fiveButton',
    params: {
      action: { character: '5' },
    },
  },
  sixButton: {
    name: 'sixButton',
    params: {
      action: { character: '6' },
    },
  },
  sevenButton: {
    name: 'sevenButton',
    params: {
      action: { character: '7' },
    },
  },
  eightButton: {
    name: 'eightButton',
    params: {
      action: { character: '8' },
    },
  },
  nineButton: {
    name: 'nineButton',
    params: {
      action: { character: '9' },
    },
  },
  zeroButton: {
    name: 'zeroButton',
    params: {
      action: { character: '0' },
    },
  },

  numericButtons: [
    self.oneButton, self.twoButton, self.threeButton,
    self.fourButton, self.fiveButton, self.sixButton,
    self.sevenButton, self.eightButton, self.nineButton,
    self.zeroButton,
  ],

  // 数字键盘空格
  numericSpaceButton: {
    name: 'numericSpaceButton',
    params: {
      action: 'space',
      systemImageName: 'space',
    },
  },

  local numericSymbolAction(char) =
    if settings.numericSymbolsUseRime then
      {
        action: { character: char },
        swipeUp: { action: { symbol: char } }
      }
    else
      {
        action: { symbol: char },
        swipeUp: { action: { character: char } }
      },

  // 数字键盘等号
  numericEqualButton: {
    name: 'numericEqualButton',
    params: numericSymbolAction('='),
  },

  // 数字键盘冒号
  numericColonButton: {
    name: 'numericColonButton',
    params: numericSymbolAction(':'),
  },

  // 数字键小数点符号
  dotButton: {
    name: 'dotButton',
    params: numericSymbolAction('.'),
  },

  // 数字键盘符号列表
  numericSymbolsCollection: {
    name: 'numericSymbolsCollection',
    params: {
      type: 'numericSymbols',
    },
  },

  // 数字键盘横向时全部部分视图
  numericCategorySymbolCollection: {
    name: 'numericCategorySymbolCollection',
    params: {
      type: 'categorySymbols',
    },
  },
}
