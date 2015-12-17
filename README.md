# 这是啥？

一个阅读工具，它聚合了主流的信息来源，提供「简单直接」的阅读体验。同时它也是一个完整的 RubyMotion 项目，在学习使用 RubyMotion 的过程中，它给我留下了不一样的开发体验。

# 为啥会创造出它？

 - 我不想一觉醒来收到一大堆莫名其妙的推送和通知
 - 我不想注册登录点赞留言，我只想看看
 - 我不想装一大堆仅仅是在极为零散碎片的时间比如吃饭等车上厕所睡觉前才偶尔想起来看一下的App
 - 我想起了以前主流的网站都提供RSS，而现在大家都变得封闭新的网站不再提供RSS，旧的网站不再维护RSS

# 它是如何工作的？

## 三种信息源

### 通过selector过滤出的源

受到 @WTSER的 Chrome 插件[十阅](https://coding.net/u/wtser/p/ten-read/git)启发，意识到可以通过CSS选择器过滤出网站首页的内容，往往这一部分也是可读性较高的。

地址：https://coding.net/u/shiweifu/p/OneReadRouter/git/blob/master/ten_read_list


### 抓取第三方应用的接口

基本上，主流的信息类应用结构都一样。都是有列表、有翻页、详情页。

地址：https://coding.net/u/shiweifu/p/OneReadRouter/git/blob/master/list


### RSS 接口

对仍旧提供RSS接口的网站提供了RSS支持。

地址：
https://coding.net/u/shiweifu/p/OneReadRouter/git/blob/master/rss_list

需要说明的是，不管是哪种源，「一读」本身都不会抓取任何内容，它严重依赖目标网站对手机浏览器的支持。分享出去的链接也是目标网站的链接。

# 说了这么多，你倒是上个图啊！

## 列表

![](http://i4.tietuku.com/93465f6d7e264249.png)


## 源
![](http://i4.tietuku.com/a207142be194caac.png)

## 选择源

![](http://i4.tietuku.com/47ac74573f762002.jpg)

![](http://i4.tietuku.com/20ebd0b0b7d74999.jpg)

![](http://i4.tietuku.com/7bd0b3be0d43d881.jpg)


# 那么，哪里可以用？

https://itunes.apple.com/us/app/yi-du/id1032943622?ls=1&mt=8


# 如何贡献？

 - 给[仓库](https://coding.net/u/shiweifu/p/OneReadRouter/)提交新的源，一起来丰富阅读内容
 - 反馈你的使用情况，任何途径都可以
 - 给这个项目加个star
 - 去AppStore给予真实的评价

# 如何联系：

邮箱：shiweifu@gmail.com
微信：kernel32
