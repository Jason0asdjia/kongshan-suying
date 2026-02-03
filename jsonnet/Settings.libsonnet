#======================================
# 此文件用于微调皮肤设置。
# 可根据需要修改下方内容，调整皮肤的相关参数。
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#======================================
{
  # 主键盘布局选择，可选值如下：
  # 26 : 常规26键布局
  # 26b: 左移26键布局(zxcvbnm行左移半格)
  # 9  : 拼音9键布局
  # 14 : 14键布局（双键布局）
  # 17 : 17键布局
  # 18 : 18键布局
  keyboardLayout: '26',


  # 数字键盘布局选择，可选值如下：
  # 9 : 九宫格布局
  # row : 数字显示在一行
  numericLayout: '9',


  # 输入时空格键上的内容，支持固定内容和变量
  # 变量可选如下：
  # $rimePreedit：Rime 预编辑文本
  # $rimeCandidate：Rime 首个候选字
  # $rimeCandidateComment: Rime 首个候选字的 comment 信息
  spaceButtonComposingText: '$rimeCandidate',


  # 是否为 iPad 设备，目前仅用于调整高度
  # true 是 iPad，false 是 iPhone
  iPad: false,

  # 是否在空格键上显示方案名称
  # true 显示方案名称，false 不显示
  spaceButtonShowSchema: true,


  # 方案名称在空格键上的位置，有的方案名称
  # 较长，需要调整 x 值以免超出按键
  spaceButtonSchemaNameCenter: {
    x: 0.22,
    y: 0.7
  },


  # 方案名称文本的额外内边距（用于给长方案名留出左侧安全区）
  spaceButtonSchemaNameInsets: {
    top: 0,
    left: 10,
    bottom: 0,
    right: 0,
  },


  # 是否显示上下滑动提示
  # true 显示，false 不显示
  showSwipeUpText: true,
  showSwipeDownText: true,


  # toolbar 按钮配置
  # 注意第一个和最后一个按键是固定的，不可配置
  # 按钮代号列表如下：
  # 【元书相关】
  # 1-脚本  2-常用语  3-剪贴板
  # 4-皮肤  5-文件管理器  6-方案切换
  # 7-数字键盘  8-符号键盘  9-表情键盘
  # 10-查看性能  11-左手模式  12-右手模式
  # 【Rime 相关】
  # 13-Rime同步  14-Rime部署  15-分词
  # 16-快符  17-RimeSwitcher
  # 【皮肤相关】
  # 18-皮肤微调  19-按键功能定义
  # 【文本编辑相关】
  # 20-全选  21-复制  22-剪切
  # 23-粘贴  24-撤销  25-重做
  # 26-左移  27-右移
  #
  # 将上述代号填入下面的数组即可
  toolbarSlideButtons: [ 8, 1, 2, 3, 9 ],

  # 滑动按钮区域占几个按键宽度
  toolbarSlideButtonsMaxCount: {
    portrait: 5,   # 竖屏
    landscape: 8,  # 横屏
  },


  # toolbar 按钮以图标显示
  # true 显示图标，false 显示文字
  toolbarPreferIcon: true,


  # 主题色
  # 0-无  1-红色  2-绿色  3-橙色  4-蓝色
  accentColor: 2,


  # 中文模式下，字母键是否大写显示
  # 17键布局下此设置无效，因为它是大小写混合显示的
  # true 大写，false 小写
  uppercaseForChinese: false,


  # 分词键，用于输入方案中分词使用
  segmentAction:
    { character: '`'},
    # 'tab',
    # { character: "'"},


  # Rime 方案中的快符
  quickAction:
    { character: ';' },
    # { character: '/' },

}
