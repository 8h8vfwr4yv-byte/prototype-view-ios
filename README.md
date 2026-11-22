# 云雀音乐（PrototypeView）

把 Axure 原型「云雀音乐」的分享页打包成 iOS App（桌面显示名：云雀音乐）：内置 WKWebView，打开即加载
https://www.axureshow.com/project/R6MecepB/
底部工具栏：后退 / 前进 / 刷新 / 回到原型首页 / 用 Safari 打开。

- 这是套壳 App，内容来自网站实时加载，需要联网；分享链接失效时 App 内也会打不开
- SwiftUI 编写，GitHub Actions 使用 Xcode 27.2 / iOS 27.2 SDK 构建未签名 IPA，最低 iOS 17.0
- 用 AltStore / SideStore 签名安装
