local numeric9Buttons = import '../Buttons/LayoutNumeric9.libsonnet';
local commonButtons = import '../Buttons/Common.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';
local settings = import '../Settings.libsonnet';

// 窄 VStack 宽度样式
local narrowVStackStyle = {
  local this = self,
  name: 'narrowVStackStyle',
  style: {
    [this.name]: {
      size: {
        width: { percentage: 0.17 },
      },
    },
  },
};

// 宽 VStack 宽度样式
local wideVStackStyle = {
  local this = self,
  name: 'wideVStackStyle',
  style: {
    [this.name]: {
      size: {
        width: { percentage: 0.22 },
      },
    },
  },
};

// 半宽 VStack 宽度样式，横屏时一半显示数字，一半显示符号
local halfVStackStyle = {
  local this = self,
  name: 'halfVStackStyle',
  style: {
    [this.name]: {
      size: {
        width: { percentage: 0.48 },
      },
    },
  },
};

// 9 键布局
local numericKeyboardLayout = {
  keyboardLayout: [
    {
      VStack: {
        style: narrowVStackStyle.name,
        subviews: [
          { Cell: numeric9Buttons.numericSymbolsCollection.name, },
          { Cell: commonButtons.gotoPrimaryKeyboardButton.name, },
        ],
      },
    },
    {
      VStack: {
        style: wideVStackStyle.name,
        subviews: [
          { Cell: numeric9Buttons.oneButton.name, },
          { Cell: numeric9Buttons.fourButton.name, },
          { Cell: numeric9Buttons.sevenButton.name, },
          { Cell: numeric9Buttons.numericSpaceButton.name, },
        ],
      },
    },
    {
      VStack: {
        style: wideVStackStyle.name,
        subviews: [
          { Cell: numeric9Buttons.twoButton.name, },
          { Cell: numeric9Buttons.fiveButton.name, },
          { Cell: numeric9Buttons.eightButton.name, },
          { Cell: numeric9Buttons.zeroButton.name, },
        ],
      },
    },
    {
      VStack: {
        style: wideVStackStyle.name,
        subviews: [
          { Cell: numeric9Buttons.threeButton.name, },
          { Cell: numeric9Buttons.sixButton.name, },
          { Cell: numeric9Buttons.nineButton.name, },
          { Cell: numeric9Buttons.dotButton.name, },
        ],
      },
    },
    {
      VStack: {
        style: narrowVStackStyle.name,
        subviews: [
          { Cell: commonButtons.backspaceButton.name, },
          { Cell: numeric9Buttons.numericEqualButton.name, },
          { Cell: numeric9Buttons.numericColonButton.name, },
          { Cell: commonButtons.enterButton.name, },
        ],
      },
    },
  ],
};

local totalKeyboardLayout(isPortrait=false) =
  if isPortrait then
    numericKeyboardLayout
  else {
    local numberPart = {
        VStack: {
          style: halfVStackStyle.name,
          subviews: numericKeyboardLayout.keyboardLayout,
        }
      },
    local symbolPart = {
        VStack: {
          style: halfVStackStyle.name,
          subviews: [
            { Cell: numeric9Buttons.numericCategorySymbolCollection.name, },
          ],
        }
      },
    keyboardLayout: if settings.keyboardLayout=='9' then
      [
        symbolPart,
        { VStack: {} }, // 中间留白
        numberPart,
      ]
    else
      [
        numberPart,
        { VStack: {} }, // 中间留白
        symbolPart,
      ],
  };


local newKeyLayout(isDark=false, isPortrait=false, extraParams={}) =

  local keyboardHeight = if isPortrait then numeric9Buttons.height.iPhone.portrait else numeric9Buttons.height.iPhone.landscape;

  {
    keyboardHeight: keyboardHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + totalKeyboardLayout(isPortrait)
  // number Buttons
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        {
          fontSize: fonts.numericButtonTextFontSize,
        }
        + (
          if settings.keyboardLayout=='9' then
            utils.repalceCharacterToSymbolRecursive(button.params)
          else
            button.params
        ),
        needHint=false,
      ),
    numeric9Buttons.numericButtons,
    {})

  + basicStyle.newSymbolicCollection(
    numeric9Buttons.numericSymbolsCollection.name,
    isDark,
    numeric9Buttons.numericSymbolsCollection.params + extraParams
  )
  + {
    [numeric9Buttons.numericCategorySymbolCollection.name]:
      utils.newBackgroundStyle(style=basicStyle.systemButtonBackgroundStyleName)
      + numeric9Buttons.numericCategorySymbolCollection.params
      + extraParams,
  }
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newSystemButton(
        button.name,
        isDark,
        button.params
      ),
    [
      numeric9Buttons.numericSpaceButton,
      numeric9Buttons.dotButton,
      commonButtons.backspaceButton,
      numeric9Buttons.numericEqualButton,
      numeric9Buttons.numericColonButton,
      commonButtons.enterButton,
    ],
    basicStyle.newColorButton(
        commonButtons.gotoPrimaryKeyboardButton.name,
        isDark,
        commonButtons.gotoPrimaryKeyboardButton.params + {
          size: { height: '1/4' },
        }
      ));

{
  new(isDark, isPortrait):
    local insets = if isPortrait then numeric9Buttons.button.backgroundInsets.iPhone.portrait else numeric9Buttons.button.backgroundInsets.iPhone.landscape;

    local extraParams = {
      insets: insets,
    };

    preedit.new(isDark)
    + toolbar.new(isDark, isPortrait)
    + (
      if !isPortrait then halfVStackStyle.style else {}
    )
    + narrowVStackStyle.style
    + wideVStackStyle.style
    + basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newAlphabeticButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newSystemButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newColorButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newAlphabeticHintBackgroundStyle(isDark, { cornerRadius: 10 })
    + basicStyle.newLongPressSymbolsBackgroundStyle(isDark, extraParams)
    + basicStyle.newLongPressSymbolsSelectedBackgroundStyle(isDark, extraParams)
    + basicStyle.newButtonAnimation()
    + newKeyLayout(isDark, isPortrait, extraParams)
    // Notifications
}
