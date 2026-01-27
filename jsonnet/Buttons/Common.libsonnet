# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含一些通用按键，如空格、backspace、enter
# shift、返回键、各种切换键盘键等等
# =====================================

local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local settings = import '../Settings.libsonnet';

{
  local root = self,

  // 特殊功能键
  spaceButton: {
    name: 'spaceButton',
    params: {
      action: 'space',
      systemImageName: 'space',
      center: {x: 0.5, y: 0.5},
      swipeUp: { action: { shortcut: '#次选上屏' } },
      swipeDown: { action: { shortcut: '#三选上屏' } },
      notification:
        (if settings.spaceButtonShowSchema then
          ['rimeSchemaChangedNotification']
        else []),

      whenPreeditChanged: {
        text: settings.spaceButtonComposingText,
        fontSize: fonts.systemButtonTextFontSize,
      }
    },
  },

  tabButton: {
    name: 'tabButton',
    params: {
      action: 'tab',
      systemImageName: 'arrow.right.to.line',
    },
  },

  backspaceButton: {
    name: 'backspaceButton',
    params: {
      action: 'backspace',
      repeatAction: 'backspace',
      systemImageName: 'delete.left',
      highlightSystemImageName: 'delete.left.fill',
      swipeUp: { action: { shortcut: '#deleteText'} },
      swipeDown: { action: { shortcut: '#undo' } },
    },
  },

  shiftButton: {
    name: 'shiftButton',
    params: {
      systemImageName: 'shift',
      action: 'shift',

      uppercased: { systemImageName: 'shift.fill', },
      capsLocked: { systemImageName: 'capslock.fill', },
    },
  },

  enterButton: {
    name: 'enterButton',
    params: {
      action: 'enter',
      text: '$returnKeyType',
      swipeUp: { action: { shortcut: '#行首' } },
      swipeDown: { action: { shortcut: '#行尾' } },

      longPress: [
        {
          action: { shortcut: '#换行' },
          systemImageName: 'paragraphsign',
        },
      ],

      whenPreeditChanged: {
        text: '确认',
        backgroundStyle: 'systemButtonBackgroundStyle',
        normalColor: colors.systemButtonForegroundColor,
      },
    },
  },

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

  goBackButton: {
    name: 'goBackButton',
    params: {
      action: 'returnLastKeyboard',
      systemImageName: 'arrow.uturn.backward',
    },
  },

  gotoPrimaryKeyboardButton: {
    name: 'gotoPrimaryKeyboardButton',
    params: {
      action: 'returnPrimaryKeyboard',
      systemImageName: 'arrow.backward',
    },
  },

  numericButton: {
    name: 'numericButton',
    params: {
      action: { keyboardType: 'numeric' },
      text: '123',
      swipeUp: { action: { keyboardType: 'symbolic' } },
      swipeDown: { action: { keyboardType: 'emojis' } },

      whenPreeditChanged: {
        action: settings.segmentAction,
        text: '分词',
      },
    },
  },

  segmentButton: {
    name: 'segmentButton',
    params: {
      action: settings.segmentAction,
      text: '分词',
    },
  },

  alphabeticButton: {
    name: 'alphabeticButton',
    params: {
      action: { keyboardType: 'alphabetic' },
      assetImageName: 'chineseState2',
      swipeUp: { action: { shortcut: '#方案切换' } },
    },
  },

  pinyinButton: {
    name: 'pinyinButton',
    params: {
      action: { keyboardType: 'pinyin' },
      assetImageName: 'englishState2',
    },
  },

  asciiModeButton: {
    name: 'asciiModeButton',
    params: {
      action: { shortcut: '#中英切换' },
      assetImageName: 'chineseState2',
      swipeUp: { action: { shortcut: '#方案切换' } },

      whenRimeOptionChanged: {
        optionName: 'ascii_mode',
        optionValue: true,
        assetImageName: 'englishState2'
      },
    },
  },

  commaButton: {
    name: 'commaButton',
    params: {
      action: { character: ',', },
      text: '，',
      center: { y: 0.52 },

      swipeUp: {
        action: { character: '.' },
        text: '。',
        center: { y: 0.3 }
      },

      whenAlphabetic: {
        text: ',', center: { y: 0.48 },
        swipeUp: { text: '.', center: { y: 0.28 } },
      }
    },
  },

  clearPreeditButton: {
    name: 'clearPreeditButton',
    params: {
      action: { shortcut: '#重输' },
      text: '重输',
    },
  },

  // 以下符号是为符号键盘准备的，暂时没有用到
  dismissButton: {
    name: 'dismissButton',
    params: {
      action: 'dismissKeyboard',
      systemImageName: 'keyboard.chevron.compact.down',
    },
  },


  symbolicButton: {
    name: 'symbolicButton',
    params: {
      action: { keyboardType: 'symbolic' },
      text: '#+=',
    },
  },

  otherKeyboardButton: {
    name: 'otherKeyboardButton',
    params: {
      action: 'nextKeyboard',
      systemImageName: 'globe',
    },
  },


  // 标点符号键

  // 连接号(减号)
  hyphenButton: {
    name: 'hyphenButton',
    params: {
      action: { character: '-' },
      swipeUp: { action: { character: '——' } },
    },
  },
  // 斜杠
  forwardSlashButton: {
    name: 'forwardSlashButton',
    params: {
      action: { character: '/' },
      swipeUp: { action: { character: '?' } },
    },
  },
  // 冒号
  colonButton: {
    name: 'colonButton',
    params: {
      action: { character: ':' },
    },
  },

  // 中文冒号
  chineseColonButton: {
    name: 'chineseColonButton',
    params: {
      action: { symbol: '：' },
    },
  },

  // 分号
  semicolonButton: {
    name: 'semicolonButton',
    params: {
      action: { symbol: ';' },
    },
  },

  // 中文分号
  chineseSemicolonButton: {
    name: 'chineseSemicolonButton',
    params: {
      action: { symbol: '；' },
      swipeUp: { action: { symbol: '：' } },
    },
  },

  // 左括号
  leftParenthesisButton: {
    name: 'leftParenthesisButton',
    params: {
      action: { symbol: '(' },
    },
  },

  // 右括号
  rightParenthesisButton: {
    name: 'rightParenthesisButton',
    params: {
      action: { symbol: ')' },
    },
  },

  // 中文左括号
  leftChineseParenthesisButton: {
    name: 'leftChineseParenthesisButton',
    params: {
      action: { symbol: '（' },
    },
  },

  // 中文右括号
  rightChineseParenthesisButton: {
    name: 'rightChineseParenthesisButton',
    params: {
      action: { symbol: '）' },
    },
  },

  // 美元符号
  dollarButton: {
    name: 'dollarButton',
    params: {
      action: { symbol: '$' },
    },
  },

  // 地址符号
  atButton: {
    name: 'atButton',
    params: {
      action: { symbol: '@' },
    },
  },

  // “ 双引号(有方向性的引号)
  leftCurlyQuoteButton: {
    name: 'leftCurlyQuoteButton',
    params: {
      action: { symbol: '“' },
    },
  },
  // ” 双引号(有方向性的引号)
  rightCurlyQuoteButton: {
    name: 'rightCurlyQuoteButton',
    params: {
      action: { symbol: '”' },
    },
  },
  // " 直引号(没有方向性的引号)
  straightQuoteButton: {
    name: 'straightQuoteButton',
    params: {
      action: { symbol: '"' },
    },
  },
  chineseCommaButton: {
    name: 'chineseCommaButton',
    params: {
      action: { symbol: '，' },
      swipeUp: { action: { symbol: '。' } },
    },
  },
  chinesePeriodButton: {
    name: 'chinesePeriodButton',
    params: {
      action: { symbol: '。' },
      swipeUp: { action: { symbol: '》' } },
    },
  },
  periodButton: {
    name: 'periodButton',
    params: {
      action: { character: '.' },
      swipeUp: { action: { character: ',' } },
    },
  },

  // 顿号(只在中文中使用)
  ideographicCommaButton: {
    name: 'ideographicCommaButton',
    params: {
      action: { symbol: '、' },
      swipeUp: { action: { symbol: '|' } },
    },
  },
  // 中文问号
  chineseQuestionMarkButton: {
    name: 'questionMarkButton',
    params: {
      action: { symbol: '？' },
    },
  },
  // 英文问号
  questionMarkButton: {
    name: 'questionMarkEnButton',
    params: {
      action: { symbol: '?' },
    },
  },
  // 中文感叹号
  chineseExclamationMarkButton: {
    name: 'chineseExclamationMarkButton',
    params: {
      action: { symbol: '！' },
    },
  },
  // 英文感叹号
  exclamationMarkButton: {
    name: 'exclamationMarkButton',
    params: {
      action: { symbol: '!' },
    },
  },
  // ' 直撇号(单引号)
  apostropheButton: {
    name: 'apostropheButton',
    params: {
      action: { symbol: "'" },
    },
  },
  // 中文左单引号(有方向性的单引号)
  leftSingleQuoteButton: {
    name: 'leftSingleQuoteButton',
    params: {
      action: { symbol: '‘' },
      swipeUp: { action: { symbol: '“' } },
    },
  },
  // 中文右单引号(有方向性的单引号)
  rightSingleQuoteButton: {
    name: 'rightSingleQuoteButton',
    params: {
      action: { symbol: '’' },
    },
  },
  // 等号
  equalButton: {
    name: 'equalButton',
    params: {
      action: { character: '=' },
      swipeUp: { action: { character: '+' } },
    },
  },
  leftBracketButton: {
    name: 'leftBracketButton',
    params: {
      action: { symbol: '[' },
    },
  },
  rightBracketButton: {
    name: 'rightBracketButton',
    params: {
      action: { symbol: ']' },
    },
  },

  // 中文左中括号
  leftChineseBracketButton: {
    name: 'leftChineseBracketButton',
    params: {
      action: { symbol: '【' },
      swipeUp: { action: { symbol: '「' } },
    },
  },

  // 中文右中括号
  rightChineseBracketButton: {
    name: 'rightChineseBracketButton',
    params: {
      action: { symbol: '】' },
      swipeUp: { action: { symbol: '」' } },
    },
  },

  // 英文左大括号
  leftBraceButton: {
    name: 'leftBraceButton',
    params: {
      action: { symbol: '{' },
    },
  },

  // 英文右大括号
  rightBraceButton: {
    name: 'rightBraceButton',
    params: {
      action: { symbol: '}' },
    },
  },

  // 中文左大括号
  leftChineseBraceButton: {
    name: 'leftChineseBraceButton',
    params: {
      action: { symbol: '｛' },
    },
  },

  // 中文右大括号
  rightChineseBraceButton: {
    name: 'rightChineseBraceButton',
    params: {
      action: { symbol: '｝' },
    },
  },


  // 井号
  hashButton: {
    name: 'hashButton',
    params: {
      action: { symbol: '#' },
    },
  },

  // 百分号
  percentButton: {
    name: 'percentButton',
    params: {
      action: { symbol: '%' },
    },
  },

  // ^符号
  caretButton: {
    name: 'caretButton',
    params: {
      action: { symbol: '^' },
    },
  },

  // '*' 符号
  asteriskButton: {
    name: 'asteriskButton',
    params: {
      action: { character: '*' },
    },
  },

  // + 符号
  plusButton: {
    name: 'plusButton',
    params: {
      action: { character: '+' },
    },
  },

  // _ 符号(下划线)
  underscoreButton: {
    name: 'underscoreButton',
    params: {
      action: { symbol: '_' },
    },
  },

  // —— 符号(破折号)
  emDashButton: {
    name: 'emDashButton',
    params: {
      action: { character: '—' },
    },
  },

  // \ 符号(反斜杠)
  backslashButton: {
    name: 'backslashButton',
    params: {
      action: { symbol: '\\' },
    },
  },

  // | 符号(竖线)
  verticalBarButton: {
    name: 'verticalBarButton',
    params: {
      action: { symbol: '|' },
    },
  },

  // ~ 符号
  tildeButton: {
    name: 'tildeButton',
    params: {
      action: { symbol: '~' },
    },
  },

  // < 符号(小于号)
  lessThanButton: {
    name: 'lessThanButton',
    params: {
      action: { symbol: '<' },
    },
  },

  // > 符号(大于号)
  greaterThanButton: {
    name: 'greaterThanButton',
    params: {
      action: { symbol: '>' },
    },
  },

  // 中文左书名号
  leftBookTitleMarkButton: {
    name: 'leftBookTitleMarkButton',
    params: {
      action: { symbol: '《' },
    },
  },

  // 中文右书名号
  rightBookTitleMarkButton: {
    name: 'rightBookTitleMarkButton',
    params: {
      action: { symbol: '》' },
    },
  },

  // € 符号(欧元符号)
  euroButton: {
    name: 'euroButton',
    params: {
      action: { symbol: '€' },
    },
  },

  // £ 符号(英镑符号)
  poundButton: {
    name: 'poundButton',
    params: {
      action: { symbol: '£' },
    },
  },

  // 人民币符号
  rmbButton: {
    name: 'rmbButton',
    params: {
      action: { symbol: '¥' },
    },
  },

  // & 符号(和号)
  ampersandButton: {
    name: 'ampersandButton',
    params: {
      action: { symbol: '&' },
    },
  },

  // · 中点符号
  middleDotButton: {
    name: 'middleDotButton',
    params: {
      action: { symbol: '·' },
    },
  },

  // …… 符号(省略号)
  ellipsisButton: {
    name: 'ellipsisButton',
    params: {
      action: { symbol: '…' },
    },
  },

  // ` 符号(重音符)
  graveButton: {
    name: 'graveButton',
    params: {
      action: { character: '`' },
      swipeUp: { action: { character: '~' } },
    },
  },

  // ± 符号(正负号)
  plusMinusButton: {
    name: 'plusMinusButton',
    params: {
      action: { symbol: '±' },
    },
  },

  // 「 中文左引号
  leftChineseAngleQuoteButton: {
    name: 'leftChineseAngleQuoteButton',
    params: {
      action: { symbol: '「' },
    },
  },

  // 」 中文右引号
  rightChineseAngleQuoteButton: {
    name: 'rightChineseAngleQuoteButton',
    params: {
      action: { symbol: '」' },
    },
  },
}
