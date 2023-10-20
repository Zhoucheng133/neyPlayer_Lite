# netPlayer Lite

<img src="./_assets/icon.png" width="100px">

![Flutter](https://img.shields.io/badge/Flutter-3.13-blue?logo=Flutter)
![get](https://img.shields.io/badge/get-4.6.5-red)
![audioservice](https://img.shields.io/badge/audio_service-0.18.10-green)
![audioplayers](https://img.shields.io/badge/audioplayers-1.1.0-yellow)
![http](https://img.shields.io/badge/http-1.1.0-orange)

![License](https://img.shields.io/badge/License-MIT-dark_green)

**netPlayer的移动端（轻量版）**

关于桌面版的netPlayer，你可以在这里查看：[Gitee](https://gitee.com/Ryan-zhou/net-player) / [Github](https://github.com/Zhoucheng133/net-player)  
关于移动版的netPlayer，你可以在这里查看：[Gitee](https://gitee.com/Ryan-zhou/net-player-mobile) / [Github](https://github.com/Zhoucheng133/netPlayer-Mobile)  
关于PWA版本的netPlayer，你可以在这里查看：[Gitee](https://gitee.com/Ryan-zhou/net-player-pwa) / [Github](https://github.com/Zhoucheng133/netPlayer-PWA)


|                          | netPlayer                       | netPlayer Mobile                                             | netPlayer Lite                                               | netPlayer PWA         |
| ------------------------ | ------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | --------------------- |
| 兼容系统                 | Windows<br />macOS<br />Linux ⭕ | iOS<br />Android<br />Web (PWA) <sup>1</sup><br />Windows❗<br />macOS❗<br />Linux❗ | iOS<br />Android<br />Web (PWA) ⭕<br />Windows❗<br />macOS❗<br />Linux❗ | Web (PWA)<sup>1</sup> |
| 基于                     | Vue & Electron                  | Flutter                                                      | Flutter                                                      | Vue                   |
| 登录                     | ✅                               | ✅                                                            | ✳️                                                            | ✅                     |
| 通过系统控制<sup>1</sup> | ✅                               | ✅                                                            | ✅                                                            | ✅                     |
| 查看所有歌曲             | ✅                               | ✅                                                            | ❌                                                            | ✅                     |
| 查看歌单                 | ✅                               | ✅                                                            | ❌                                                            | ✅                     |
| 查看喜欢的歌曲           | ✅                               | ✅                                                            | ❌                                                            | ✅                     |
| 搜索                     | ✅                               | ✅                                                            | ❌                                                            | ✅                     |
| 播放顺序                 | 顺序/随机                       | 顺序/随机                                                    | 随机                                                         | 顺序/随机             |
| 添加到喜欢               | ✅                               | ✅                                                            | ❌                                                            | ✅                     |
| 添加到歌单               | ✅                               | ✅                                                            | ❌                                                            | ✅                     |
| 删除歌单                 | ✅                               | ✅                                                            | ❌                                                            | 放弃开发              |
| 编辑歌单                 | ✅                               | ✅                                                            | ❌                                                            | ❌                     |

⭕：理论上支持，但是没有做测试  
❗：理论上支持，但是不推荐在该平台上运行

✅：支持  
❌：不支持  
✳️：有限的支持

1：对于所有需要运行在iOS设备上的PWA应用程序，**可能**因为苹果的后台管理政策无法实现自动播放下一首和系统控制功能，如果你希望在iOS设备上正确的工作，可以使用纯Web模式使用浏览器打开

**相对于Mobile版本，PWA版本在iOS平台以PWA方式安装的时候如果放在前台可以自动切换下一首**


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