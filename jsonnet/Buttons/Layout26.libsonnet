# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含中文26键布局和英文26键布局中的字母键
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
        portrait: { top: 5, left: 3, bottom: 5, right: 3 },
        landscape: { top: 3, left: 3, bottom: 3, right: 3 },
      },
      ipad: {
        portrait: { top: 3, left: 3, bottom: 3, right: 3 },
        landscape: { top: 4, left: 6, bottom: 4, right: 6 },
      },
    },
  },

  // 按键定义
  qButton: {
    name: 'qButton',
    params: {
      action: { character: 'q' },
      uppercased: { action: { character: 'Q' } },
      swipeUp: { action: { character: '!' } },
      swipeDown: { action: { character: '1' } },
    },
  },
  wButton: {
    name: 'wButton',
    params: {
      action: { character: 'w' },
      uppercased: { action: { character: 'W' } },
      swipeUp: { action: { character: '@' } },
      swipeDown: { action: { character: '2' } },
    },
  },
  eButton: {
    name: 'eButton',
    params: {
      action: { character: 'e' },
      uppercased: { action: { character: 'E' } },
      swipeUp: { action: { character: '#' } },
      swipeDown: { action: { character: '3' } },
    },
  },
  rButton: {
    name: 'rButton',
    params: {
      action: { character: 'r' },
      uppercased: { action: { character: 'R' } },
      swipeUp: { action: { character: '$' } },
      swipeDown: { action: { character: '4' } },
    },
  },
  tButton: {
    name: 'tButton',
    params: {
      action: { character: 't' },
      uppercased: { action: { character: 'T' } },
      swipeUp: { action: { character: '%' } },
      swipeDown: { action: { character: '5' } },
      longPress: [
        { action: 'tab', systemImageName: 'arrow.right.to.line' },
      ],
    },
  },
  yButton: {
    name: 'yButton',
    params: {
      action: { character: 'y' },
      uppercased: { action: { character: 'Y' } },
      swipeUp: { action: { character: '^' } },
      swipeDown: { action: { character: '6' } },
    },
  },
  uButton: {
    name: 'uButton',
    params: {
      action: { character: 'u' },
      uppercased: { action: { character: 'U' } },
      swipeUp: { action: { character: '&' } },
      swipeDown: { action: { character: '7' } },
    },
  },
  iButton: {
    name: 'iButton',
    params: {
      action: { character: 'i' },
      uppercased: { action: { character: 'I' } },
      swipeUp: { action: { character: '*' } },
      swipeDown: { action: { character: '8' } },
    },
  },
  oButton: {
    name: 'oButton',
    params: {
      action: { character: 'o' },
      uppercased: { action: { character: 'O' } },
      swipeUp: { action: { character: '|' } },
      swipeDown: { action: { character: '9' } },
    },
  },
  pButton: {
    name: 'pButton',
    params: {
      action: { character: 'p' },
      uppercased: { action: { character: 'P' } },
      swipeUp: { action: { character: '?' } },
      swipeDown: { action: { character: '0' } },
    },
  },

  // 第二行字母键 (ASDF)
  aButton: {
    name: 'aButton',
    params: {
      action: { character: 'a' },
      uppercased: { action: { character: 'A' } },
      swipeUp: { action: { character: '~' } },
      swipeDown: { action: { shortcut: '#selectText' }, text: '全' },
      longPress: [
        { action: { shortcut: '#左手模式' }, systemImageName: 'keyboard.onehanded.left' },
      ],
    },
  },
  sButton: {
    name: 'sButton',
    params: {
      action: { character: 's' },
      uppercased: { action: { character: 'S' } },
      swipeUp: { action: { character: '-' } },
      swipeDown: { action: { character: '_' } },
    },
  },
  dButton: {
    name: 'dButton',
    params: {
      action: { character: 'd' },
      uppercased: { action: { character: 'D' } },
      swipeUp: { action: { character: '=' } },
      swipeDown: { action: { character: '+' } },
    },
  },
  fButton: {
    name: 'fButton',
    params: {
      action: { character: 'f' },
      uppercased: { action: { character: 'F' } },
      swipeUp: { action: { character: '[]' } },
      swipeDown: { action: { character: '{}' } },
    },
  },
  gButton: {
    name: 'gButton',
    params: {
      action: { character: 'g' },
      uppercased: { action: { character: 'G' } },
      swipeUp: { action: { openURL: 'chatgpt://' }, systemImageName: 'magnifyingglass.circle' },
      swipeDown: { action: { openURL: 'googlegemini://' }, systemImageName: 'sparkle.magnifyingglass' },
    },
  },
  hButton: {
    name: 'hButton',
    params: {
      action: { character: 'h' },
      uppercased: { action: { character: 'H' } },
      swipeUp: { action: { character: '()' } },
      swipeDown: { action: { character: '「」' } },
    },
  },
  jButton: {
    name: 'jButton',
    params: {
      action: { character: 'j' },
      uppercased: { action: { character: 'J' } },
      swipeUp: { action: { character: '/' } },
      swipeDown: { action: { symbol: '\\' } },
    },
  },
  kButton: {
    name: 'kButton',
    params: {
      action: { character: 'k' },
      uppercased: { action: { character: 'K' } },
      swipeUp: { action: { character: ';' } },
      swipeDown: { action: { character: ':' } },
    },
  },
  lButton: {
    name: 'lButton',
    params: {
      action: { character: 'l' },
      uppercased: { action: { character: 'L' } },
      swipeUp: { action: { symbol: "'" } },
      swipeDown: { action: { symbol: '"' } },
      longPress: [
        { action: { shortcut: '#右手模式' }, systemImageName: 'keyboard.onehanded.right' }
      ],
    },
  },

  // 第三行字母键 (ZXCV)
  zButton: {
    name: 'zButton',
    params: {
      action: { character: 'z' },
      uppercased: { action: { character: 'Z' } },
      swipeUp: { action: { character: '`' } },
      swipeDown: { action: { shortcut: '#undo' }, text: '撤' },
    },
  },
  xButton: {
    name: 'xButton',
    params: {
      action: { character: 'x' },
      uppercased: { action: { character: 'X' } },
      swipeUp: { action: { symbol: ',' } },
      swipeDown: { action: { shortcut: '#cut' }, text: '剪' },
    },
  },
  cButton: {
    name: 'cButton',
    params: {
      action: { character: 'c' },
      uppercased: { action: { character: 'C' } },
      swipeUp: { action: { symbol: '.' } },
      swipeDown: { action: { shortcut: '#copy' }, text: '复' },
    },
  },
  vButton: {
    name: 'vButton',
    params: {
      action: { character: 'v' },
      uppercased: { action: { character: 'V' } },
      swipeUp: { action: { openURL: 'clipjar://' }, systemImageName: 'paperclip.circle' },
      swipeDown: { action: { shortcut: '#paste' }, text: '贴' },
    },
  },
  bButton: {
    name: 'bButton',
    params: {
      action: { character: 'b' },
      uppercased: { action: { character: 'B' } },
      swipeUp: { action: { symbol: '‘’' } },
      swipeDown: { action: { symbol: '“”' } },
    },
  },
  nButton: {
    name: 'nButton',
    params: {
      action: { character: 'n' },
      uppercased: { action: { character: 'N' } },
      swipeUp: { action: { character: '、' } },
      swipeDown: { action: { character: '…' } },
    },
  },
  mButton: {
    name: 'mButton',
    params: {
      action: { character: 'm' },
      uppercased: { action: { character: 'M' } },
      swipeUp: { action: { openURL: 'eudic://dict/#pasteboardContent' }, text: 'ɑː' },
      swipeDown: { action: { openURL: 'mojisho://?search=#pasteboardContent' }, text: 'あ' },
    },
  },

  letterButtons: [
    self.qButton, self.wButton, self.eButton, self.rButton, self.tButton,
    self.yButton, self.uButton, self.iButton, self.oButton, self.pButton,
    self.aButton, self.sButton, self.dButton, self.fButton, self.gButton,
    self.hButton, self.jButton, self.kButton, self.lButton,
    self.zButton, self.xButton, self.cButton, self.vButton, self.bButton,
    self.nButton, self.mButton,
  ],
}
