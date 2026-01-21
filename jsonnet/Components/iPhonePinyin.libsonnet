local layout26 = import 'iPhonePinyin26.libsonnet';
local layout9 = import 'iPhonePinyin9.libsonnet';
local settings = import '../Settings.libsonnet';

{
  new(isDark, isPortrait):
    if settings.keyboardLayout == '9' then
      layout9.new(isDark, isPortrait)
    else
      layout26.new(isDark, isPortrait),
}
