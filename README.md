# netPlayer Lite

**netPlayer的移动端（轻量版）**

关于桌面版的netPlayer，你可以在这里查看：[Gitee](https://gitee.com/Ryan-zhou/net-player) / [Github](https://github.com/Zhoucheng133/net-player)

**使用前务必先查看下方的`使用说明`**

## 截图

<img src="https://s2.loli.net/2023/08/25/pn3jKglAd4shzDy.jpg" alt="netPlayer_Lite_截图.jpg" style="zoom:25%;" />

## 使用说明

**务必仔细阅读**

1. 你需要在`lib/Functions`文件夹下新建一个文件叫做`parameters.dart`
2. 生成Salt和Token
   1. Salt可以是一个随机的字符串，长度没有限制
   2. Token需要使用**MD5**加密方法，加密密码+Salt
      例如密码为**sesame**，随机生成的Salt为**c19b2d**，那么生成的Token： **token = md5("sesamec19b2d") = 26719a1196d2a940705a59634eb18eab**
3. 在这个文件中定义URL地址，用户名，Salt和Token

```dart
String baseURL="URL地址";
String username="用户名";
String salt="Salt";
String token="Token";
```

4. 完成之后你就可以在你的设备上运行调试了
