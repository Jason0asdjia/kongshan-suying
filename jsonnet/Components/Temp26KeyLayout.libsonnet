local layout26 = import 'iPhonePinyin26.libsonnet';

{
  new(isDark, isPortrait):
    layout26.new(isDark, isPortrait, isForTempUse=true),
}
