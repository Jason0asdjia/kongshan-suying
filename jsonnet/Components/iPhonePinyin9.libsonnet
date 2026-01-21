local fonts = import '../Constants/Fonts.libsonnet';
local params = import '../Constants/Keyboard.libsonnet';
local pinyin9Buttons = import '../Buttons/Layout9.libsonnet';
local commonButtons = import '../Buttons/Common.libsonnet';
local settings = import '../Settings.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

local alphabeticTextCenterWhenShowSwipeText =
  local showSwipeText = settings.showSwipeUpText || settings.showSwipeDownText;
  {
    [if showSwipeText then 'center']: { y: 0.55 }
  };

local backgroundInsets = {
  portrait: { top: 3, left: 4, bottom: 3, right: 4 },
  landscape: { top: 3, left: 3, bottom: 3, right: 3 },
};

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

// 9 键布局
local alphabeticKeyboardLayout = {
  keyboardLayout: [
    {
      VStack: {
        style: narrowVStackStyle.name,
        subviews: [
          { Cell: pinyin9Buttons.t9SymbolsCollection.name, },
          { Cell: commonButtons.numericButton.name, },
        ],
      },
    },
    {
      VStack: {
        subviews: [
          {
            HStack: {
              subviews: [
                { Cell: pinyin9Buttons.t9OneButton.name, },
                { Cell: pinyin9Buttons.t9TwoButton.name, },
                { Cell: pinyin9Buttons.t9ThreeButton.name, },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: pinyin9Buttons.t9FourButton.name, },
                { Cell: pinyin9Buttons.t9FiveButton.name, },
                { Cell: pinyin9Buttons.t9SixButton.name, },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: pinyin9Buttons.t9SevenButton.name, },
                { Cell: pinyin9Buttons.t9EightButton.name, },
                { Cell: pinyin9Buttons.t9NineButton.name, },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: commonButtons.spaceButton.name, },
                { Cell: commonButtons.alphabeticButton.name, },
              ],
            },
          },
        ],
      },
    },
    {
      VStack: {
        style: narrowVStackStyle.name,
        subviews: [
          { Cell: commonButtons.backspaceButton.name, },
          { Cell: pinyin9Buttons.t9ZeroButton.name, },
          { Cell: commonButtons.enterButton.name, },
        ],
      },
    },
  ],
};


local newKeyLayout(isDark=false, isPortrait=false, extraParams={}) =

  local keyboardHeight = if isPortrait then pinyin9Buttons.height.iPhone.portrait else pinyin9Buttons.height.iPhone.landscape;

  {
    keyboardHeight: keyboardHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }

  + alphabeticKeyboardLayout

  + basicStyle.newSymbolicCollection(
    pinyin9Buttons.t9SymbolsCollection.name,
    isDark,
    pinyin9Buttons.t9SymbolsCollection.params + extraParams
  )

  // t9 Buttons
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        alphabeticTextCenterWhenShowSwipeText + button.params + {
          fontSize: fonts.t9ButtonTextFontSize,
        },
        needHint=false,
      ),
    pinyin9Buttons.t9Buttons,
    {})

  + basicStyle.newSystemButton(
    commonButtons.numericButton.name,
    isDark,
    {
      size: { height: '1/4' },
    } + commonButtons.numericButton.params
  )

  + basicStyle.newAlphabeticButton(
    commonButtons.spaceButton.name,
    isDark,
    {
      foregroundStyleName: basicStyle.spaceButtonForegroundStyle,
      foregroundStyle: basicStyle.newSpaceButtonRimeSchemaForegroundStyle('$rimeSchemaName', isDark),
    }
    + commonButtons.spaceButton.params,
    needHint=false
  )

  + basicStyle.newSystemButton(
    commonButtons.alphabeticButton.name,
    isDark, commonButtons.alphabeticButton.params +
    {
      size: { width: '1/3' },
    }
  )

  + basicStyle.newSystemButton(
    commonButtons.backspaceButton.name,
    isDark,
    commonButtons.backspaceButton.params,
  )

  + basicStyle.newColorButton(
    commonButtons.enterButton.name,
    isDark,
    {
      size: { height: '2/4' },
    } + commonButtons.enterButton.params
  );

{
  new(isDark, isPortrait):
    local insets = if isPortrait then pinyin9Buttons.button.backgroundInsets.iPhone.portrait else pinyin9Buttons.button.backgroundInsets.iPhone.landscape;

    local extraParams = {
      insets: insets,
    };

    preedit.new(isDark)
    + toolbar.new(isDark, isPortrait)
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
    + basicStyle.rimeSchemaChangedNotification,
}
