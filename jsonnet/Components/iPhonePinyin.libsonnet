local buttons = import '../Buttons/Layout26.libsonnet';
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

// 标准26键布局
local rows = [
  [
    buttons.qButton,
    buttons.wButton,
    buttons.eButton,
    buttons.rButton,
    buttons.tButton,
    buttons.yButton,
    buttons.uButton,
    buttons.iButton,
    buttons.oButton,
    buttons.pButton,
  ],
  [
    buttons.aButton,
    buttons.sButton,
    buttons.dButton,
    buttons.fButton,
    buttons.gButton,
    buttons.hButton,
    buttons.jButton,
    buttons.kButton,
    buttons.lButton,
  ],
  [
    commonButtons.shiftButton,
    buttons.zButton,
    buttons.xButton,
    buttons.cButton,
    buttons.vButton,
    buttons.bButton,
    buttons.nButton,
    buttons.mButton,
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

local getAlphabeticButtonSize(name) =
  local extra = {
    [buttons.aButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '111/168.75', alignment: 'right' },
    },
    [buttons.lButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '111/168.75', alignment: 'left' },
    },
  };
  (
  if std.objectHas(extra, name) then
    extra[name]
  else
    portraitNormalButtonSize
  );


local newKeyLayout(isDark=false, isPortrait=true) =
  local keyboardHeight = if isPortrait then buttons.height.iPhone.portrait else buttons.height.iPhone.landscape;
  {
    keyboardHeight: keyboardHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + utils.newRowKeyboardLayout(rows)

  // letter Buttons
  + std.foldl(function(acc, button)
      acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        getAlphabeticButtonSize(button.name) + button.params + hintStyle + alphabeticTextCenterWhenShowSwipeText +
        (
          if settings.uppercaseForChinese then
            basicStyle.newAlphabeticButtonUppercaseForegroundStyle(isDark, button.params) + basicStyle.getKeyboardActionText(button.params.uppercased)
            + {
              [if settings.uppercaseForChinese then 'whenAsciiModeOn']: basicStyle.newAlphabeticButtonForegroundStyle(isDark, button.params) + basicStyle.getKeyboardActionText(button.params),
            }
          else {}
        )
        ,
        swipeTextFollowSetting=true),
      buttons.letterButtons,
      {})

  // Third Row
  + basicStyle.newSystemButton(
    commonButtons.shiftButton.name,
    isDark,
    (
      if settings.usePCLayout then portraitNormalButtonSize else
      {
        size:
          { width: '168.75/1125' },
        bounds:
          { width: '151/168.75', alignment: 'left' },
      }
    )
    + commonButtons.shiftButton.params
  )

  + basicStyle.newSystemButton(
    commonButtons.backspaceButton.name,
    isDark,
    (
      if settings.usePCLayout then
      {
        size: { width: '225/1125' },
      }
      else
      {
        size:
          { width: '168.75/1125' },
        bounds:
          { width: '151/168.75', alignment: 'right' },
      }
    )
    + commonButtons.backspaceButton.params,
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

{
  new(isDark, isPortrait):
    local insets = if isPortrait then buttons.button.backgroundInsets.iPhone.portrait else buttons.button.backgroundInsets.iPhone.landscape;

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
