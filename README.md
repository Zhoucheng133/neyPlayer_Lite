# netPlayer Lite

<img src="./_assets/icon.png" width="100px">

![Flutter](https://img.shields.io/badge/Flutter-3.13-blue?logo=Flutter)
![get](https://img.shields.io/badge/get-4.6.5-red)
![audioservice](https://img.shields.io/badge/audio_service-0.18.10-green)
![audioplayers](https://img.shields.io/badge/audioplayers-1.1.0-yellow)
![http](https://img.shields.io/badge/http-1.1.0-orange)

![License](https://img.shields.io/badge/License-MIT-dark_green)

**netPlayer的移动端（轻量版）**


**注意，鉴于Subsonic没有提供“获取所有歌曲”的API，因此“所有歌曲”是通过获取随机歌曲排序后得到的，只能获取500首歌曲**

关于桌面版的netPlayer，你可以在这里查看：[Github](https://github.com/Zhoucheng133/net-player)  
关于移动版的netPlayer，你可以在这里查看：[Github](https://github.com/Zhoucheng133/netPlayer-Mobile)  
关于PWA版本的netPlayer，你可以在这里查看：[Github](https://github.com/Zhoucheng133/netPlayer-PWA)

**使用前务必先查看下方的`使用说明`**

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

## 截图

<img src="./_assets/demo.PNG" alt="netPlayer_Lite_截图.jpg" width="200px" />


## 更新日志
### v1.0.0 (2023/8/25)
- 第一个版本