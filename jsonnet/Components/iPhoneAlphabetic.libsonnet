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
    commonButtons.pinyinButton,
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

// 英文键盘下，对按键的 params 进行处理
// 1. 将 character 替换为 symbol
//    处理方式为 params = repalceCharacterToSymbolRecursive(params)
// 2. 将 params 中的 whenAlphabetic 合并到 params
//    处理方式为 params = std.objectRemoveKey(params + std.get(params, 'whenAlphabetic', default={}), 'whenAlphabetic') 的内容
local processAlphabeticButtonParams(params) =
  local paramsWithSymbol = utils.repalceCharacterToSymbolRecursive(params);
  utils.deepMerge(paramsWithSymbol, std.get(paramsWithSymbol, 'whenAlphabetic', default={}));


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
        getAlphabeticButtonSize(button.name) + processAlphabeticButtonParams(button.params) + hintStyle + alphabeticTextCenterWhenShowSwipeText,
        swipeTextFollowSetting=true),
      buttons.letterButtons,
      {})

  // Third Row
  + basicStyle.newSystemButton(
    commonButtons.shiftButton.name,
    isDark,
    (
      if settings.keyboardLayout=='26b' then portraitNormalButtonSize else
      {
        size:
          { width: '168.75/1125' },
        bounds:
          { width: '151/168.75', alignment: 'left' },
      }
    )
    + processAlphabeticButtonParams(commonButtons.shiftButton.params)
  )

  + basicStyle.newSystemButton(
    commonButtons.backspaceButton.name,
    isDark,
    (
      if settings.keyboardLayout=='26b' then
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
    + processAlphabeticButtonParams(commonButtons.backspaceButton.params),
  )

  // Fourth Row
  + basicStyle.newSystemButton(
    commonButtons.numericButton.name,
    isDark,
    { size: { width: '225/1125' } }
    + processAlphabeticButtonParams(commonButtons.numericButton.params)
  )
  + basicStyle.newAlphabeticButton(
    commonButtons.commaButton.name,
    isDark,
    portraitNormalButtonSize + processAlphabeticButtonParams(commonButtons.commaButton.params) + hintStyle
  )
  + basicStyle.newAlphabeticButton(
    commonButtons.spaceButton.name,
    isDark,
    {
      foregroundStyleName: basicStyle.spaceButtonForegroundStyle,
      foregroundStyle: basicStyle.newSpaceButtonRimeSchemaForegroundStyle('English', isDark),
    }
    + processAlphabeticButtonParams(commonButtons.spaceButton.params),
    needHint=false,
  )
  + basicStyle.newSystemButton(
    commonButtons.pinyinButton.name,
    isDark,
    portraitNormalButtonSize
    + processAlphabeticButtonParams(commonButtons.pinyinButton.params)
  )
  + basicStyle.newColorButton(
    commonButtons.enterButton.name,
    isDark,
    {
      size: { width: '250/1125' },
    } + processAlphabeticButtonParams(commonButtons.enterButton.params)
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
    + basicStyle.rimeSchemaChangedNotification
    + basicStyle.returnKeyTypeChangedNotification,
}
