local buttons = import '../Buttons/Layout17.libsonnet';
local commonButtons = import '../Buttons/Common.libsonnet';
local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local settings = import '../Settings.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

local portraitNormalButtonSize = {
  size: { width: '112.5/1125' },
};

local hintStyle = {
  hintStyle: {
    size: { width: self.height, height: toolbarParams.toolbar.height },
  },
};

local alphabeticTextCenterWhenShowSwipeText =
  local showSwipeText = settings.showSwipeUpText || settings.showSwipeDownText;
  {
    [if showSwipeText then 'center']: { y: 0.55 }
  };

// 乱序17键布局
local rows = [
  [
    buttons.hButton,
    buttons.sButton,
    buttons.zButton,
    buttons.bButton,
    buttons.xButton,
    buttons.mButton,
  ],
  [
    buttons.lButton,
    buttons.dButton,
    buttons.yButton,
    buttons.wButton,
    buttons.jButton,
    buttons.nButton,
  ],
  [
    buttons.cButton,
    buttons.qButton,
    buttons.gButton,
    buttons.fButton,
    buttons.tButton,
    commonButtons.backspaceButton,
  ],
  [
    commonButtons.numericButton,
    commonButtons.commaButton,
    commonButtons.spaceButton,
    commonButtons.alphabeticButton,
    commonButtons.enterButton,
  ],
];


local newKeyLayout(isDark=false, isPortrait=true) =
  local rowHeight = if isPortrait then commonButtons.rowHeight.portrait else commonButtons.rowHeight.landscape;
  {
    keyboardHeight: rowHeight * std.length(rows),
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + utils.newRowKeyboardLayout(rows)

  // letter Buttons
  + std.foldl(function(acc, button)
      acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        button.params + hintStyle + alphabeticTextCenterWhenShowSwipeText,
        swipeTextFollowSetting=true),
      buttons.letterButtons,
      {})

  // Third Row
  + basicStyle.newSystemButton(
    commonButtons.backspaceButton.name,
    isDark,
    commonButtons.backspaceButton.params,
  )

  // Fourth Row
  + basicStyle.newSystemButton(
    commonButtons.numericButton.name,
    isDark,
    { size: { width: '225/1125' } }
    + commonButtons.numericButton.params
  )

  + basicStyle.newAlphabeticButton(
    commonButtons.commaButton.name,
    isDark,
    portraitNormalButtonSize + commonButtons.commaButton.params + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    commonButtons.spaceButton.name,
    isDark,
    {
      foregroundStyleName: basicStyle.spaceButtonForegroundStyle,
      foregroundStyle: basicStyle.newSpaceButtonRimeSchemaForegroundStyle('$rimeSchemaName', isDark),
    }
    + commonButtons.spaceButton.params,
    needHint=false,
  )
  + basicStyle.newSystemButton(
    commonButtons.alphabeticButton.name,
    isDark,
    portraitNormalButtonSize
    + commonButtons.alphabeticButton.params
  )
  + basicStyle.newColorButton(
    commonButtons.enterButton.name,
    isDark,
    {
      size: { width: '250/1125' },
    } + commonButtons.enterButton.params
  )
;

local backgroundInsets = if !settings.iPad then
{
  portrait: { top: 5, left: 3, bottom: 5, right: 3 },
  landscape: { top: 3, left: 3, bottom: 3, right: 3 },
}
else
{
  portrait: { top: 3, left: 3, bottom: 3, right: 3 },
  landscape: { top: 4, left: 6, bottom: 4, right: 6 },
};

{
  new(isDark, isPortrait):
    local insets = if isPortrait then backgroundInsets.portrait else backgroundInsets.landscape;

    local extraParams = {
      insets: insets,
    };

    preedit.new(isDark)
    + toolbar.new(isDark, isPortrait)
    + basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newAlphabeticButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newSystemButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newColorButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newAlphabeticHintBackgroundStyle(isDark, { cornerRadius: 10 })
    + basicStyle.newLongPressSymbolsBackgroundStyle(isDark, extraParams)
    + basicStyle.newLongPressSymbolsSelectedBackgroundStyle(isDark, extraParams)
    + basicStyle.newButtonAnimation()
    + newKeyLayout(isDark, isPortrait)
    // Notifications
    + basicStyle.rimeSchemaChangedNotification,
}
