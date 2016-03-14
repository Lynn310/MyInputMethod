# MyInputMethod
===============
MyInputMethod,我的输入法...

##参考

技术参考:
iOS基础集合类:https://github.com/ming1016/study/wiki/iOS%E5%9F%BA%E7%A1%80%E9%9B%86%E5%90%88%E7%B1%BB
iOS-Core-Animation-Advanced-Techniques:http://www.cocoachina.com/ios/20150104/10814.html
自定义控件:http://objccn.io/issue-3-4/
How To Make a Custom Control:http://www.raywenderlich.com/36288/how-to-make-a-custom-control

AutoLayoutDemo:https://github.com/yechunjun/AutoLayoutDemo
先进的自动布局工具箱:http://objccn.io/issue-3-5/
细数AutoLayout以来UIView和UIViewController新增的相关API:http://chun.tips/blog/2014/10/23/xi-shu-autolayoutyi-lai-uiviewhe-uiviewcontrollerxin-zeng-de-xiang-guan-api-uiviewpian/
自动布局（autolayout）环境下图片编辑器的实现:http://blog.csdn.net/lihuiqwertyuiop/article/details/40015521
iOS界面开发的大一统:http://onevcat.com/2014/07/ios-ui-unique/


How can I set image in textDocumentProxy with custom keyboard extension iOS 8?:
http://stackoverflow.com/questions/28630338/how-can-i-set-image-in-textdocumentproxy-with-custom-keyboard-extension-ios-8
iOS-Headers私有API:https://github.com/MP0w/iOS-Headers


Undo typing in UITextView:http://stackoverflow.com/questions/1991897/undo-typing-in-uitextview
Undo/redo with a UITextView:http://stackoverflow.com/questions/4070291/undo-redo-with-a-uitextview-ios-iphone/4071681#4071681

Designing for iOS - Taming UIButton:https://robots.thoughtbot.com/designing-for-ios-taming-uibutton

加密你的SQLite:http://foggry.com/blog/2014/05/19/jia-mi-ni-de-sqlite


特殊符号:
Unicode字符:https://en.wikipedia.org/wiki/Category:Unicode


特殊表情:
getEmoji:http://getemoji.com/
Unicode/List of useful symbols:https://en.wikibooks.org/wiki/Unicode/List_of_useful_symbols
Emoji Unicode Tables:http://apps.timwhitlock.info/emoji/tables/unicode


##词库

五笔编码词库:https://github.com/ishitcno1/googleInputWubiTable


汉字转拼音:
https://github.com/jifei/Pinyin/
https://github.com/cleverdeng/pinyin.py

一个iOS版的基于zinnia的手写汉字识别:https://github.com/Crazylitm/HZRC


#授权相关

```
//获得用户评分api的文档
https://support.appannie.com/hc/en-us/articles/204208934-6-Product-Reviews-

//获得用户评分数据
curl -H "Authorization:Bearer xxxxxxxxxxxxx" "https://api.appannie.com/v1.2/apps/ios/app/990121195/ratings?page_index=0"

//获得App所支持的所有国家地区代码
curl -H "Authorization:Bearer xxxxxxxxxxxxx" "https://api.appannie.com/v1.2/meta/countries"

//获得用户评论数据
curl -H "Authorization:Bearer xxxxxxxxxxxxx" "https://api.appannie.com/v1.2/apps/ios/app/990121195/reviews?counties=US+CN&page_index=0"
```

#视图相关
纯UILabel实现文字的竖排显示:http://humin.me/archives/68
make a vertical text UILabel and UITextView for iOS:http://stackoverflow.com/questions/28544714/how-do-you-make-a-vertical-text-uilabel-and-uitextview-for-ios-in-swift
Vertical-Text-iOS:https://github.com/sangonz/Vertical-Text-iOS


#技术相关
Method Swizzling 和 AOP 实践:http://tech.glowing.com/cn/method-swizzling-aop/



#需要做的功能点

**常规键盘Extension**
```
1. 自定义皮肤,按键样式设置完善及数据存储整理；
2. 四种常规键盘(拼音全键,拼音九键,五笔全键,笔画全键)之间切换，上滑手势输入，字符键按提示窗；
3. 添加符号键盘(类似百度的符号键盘-CollectionView)；
4. 五种特殊键盘(快捷短语/emoji/emoticon/图片表情/符号键盘)
    1. 数据源统一改成plist文件存储;
    2. 添加常用分类并存储到对应plist文件；
    3. 排序的优化；
5. 主设置界面修改及存储；
6. 输入候选区的添加；
7. 英文补全；
8. 繁简转换；
9. 火星文字转换；
10. 拼音全键输入实现；
11. 拼音九键输入实现；
12. 五笔全键输入实现；
13. 笔画全键输入实现；
14. 输入加入联想联系人逻辑；
15. 九种键盘的删除键/空格键长按输入；
16. 横竖屏优化,剪粘板,按键音处理；
17. 图片表情的社会化分享的集成；
18. 主题的添加/设置/选择；
```

**Gif表情键盘Extension**
```
1. 键盘界面添加；
2. 输入逻辑实现；
```


**主App**
```
1. 启动页，教程Guide；
2. 联系人的导入；
3. 添加快捷短语及分类；
4. 图片表情的添加及分类；
5. 键盘皮肤添加；
6. 统一数据存储约定；
~~~~~~~~~~
7. Gif图片大小帧率处理
8. live photos转Gif导入；
9. gif图片/压缩包的导入；
10. url下载gif导入；
11. 恢复到默认主题设置；
```



