// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unnecessary_brace_in_string_interps, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, prefer_typing_uninitialized_variables, unused_element

import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netplayer_lite/Functions/_request.dart';
import 'Functions/parameters.dart';
import 'package:get/get.dart';


var _audioHandler;

Future<void> main() async {
  _audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.netPlayer.channel.audio',
      androidNotificationChannelName: 'Music playback',
    ),
  );
  runApp(GetMaterialApp(home: Home()));
}

final player = AudioPlayer();
// 音乐控制模块
class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  
  MediaItem item=MediaItem(id: "", title: "");

  void setInfo(){
    item=MediaItem(
      id: c.playInfo["id"],
      album: c.playInfo["album"],
      title: c.playInfo["title"],
      artist: c.playInfo["artist"],
      artUri: Uri.parse("${baseURL}/rest/getCoverArt?v=1.12.0&c=netPlayer&f=json&u=${username}&t=${token}&s=${salt}&id=${c.playInfo["id"]}"),
      duration: Duration(seconds: c.playInfo["duration"]),
    );
    mediaItem.add(item);
  }

  Future<void> getRandomSong() async {
    String url="${baseURL}/rest/getRandomSongs?v=1.12.0&c=netPlayer&f=json&u=${username}&t=${token}&s=${salt}&size=1";
    final response=await httpRequest(url);
    if(response.isEmpty || response["subsonic-response"]["status"]!="ok"){
      return;
    }else{
      c.updateInfo(response["subsonic-response"]["randomSongs"]["song"][0]);
    }
  }

	final Controller c = Get.put(Controller());

  @override
  MyAudioHandler(){
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.pause,
        MediaControl.skipToNext,
      ],
      processingState: AudioProcessingState.loading,
    ));
  }
  
  @override
  Future<void> play() async {
    c.updateIsPlay(true);
    if(c.playInfo.isEmpty){
      await getRandomSong();
    }
    String id=c.playInfo["id"];
    String url="${baseURL}/rest/stream?v=1.12.0&c=netPlayer&f=json&u=${username}&t=${token}&s=${salt}&id=${id}";
    await player.play(UrlSource(url));
    playbackState.add(playbackState.value.copyWith(
      playing: true,
      controls: [
        MediaControl.pause,
        MediaControl.skipToNext,
      ],
    ));
    setInfo();
    player.onPlayerComplete.listen((event) {
      skipToNext();
    });
  }

  @override
  Future<void> pause() async {
    c.updateIsPlay(false);
    await player.pause();
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: [
        MediaControl.play,
        MediaControl.skipToNext,
      ],
    ));
    setInfo();
  }

  @override
  Future<void> skipToNext()async {
    await player.stop();
    await getRandomSong();
    String id=c.playInfo["id"];
    String url="${baseURL}/rest/stream?v=1.12.0&c=netPlayer&f=json&u=${username}&t=${token}&s=${salt}&id=${id}";
    await player.play(UrlSource(url));
    playbackState.add(playbackState.value.copyWith(
      playing: true,
      controls: [
        MediaControl.pause,
        MediaControl.skipToNext,
      ],
    ));
    setInfo();
  }
}

// 所有的参数在这里
class Controller extends GetxController{
  var isPlay=false.obs;
  var playInfo={}.obs;
  updateIsPlay(data) => isPlay.value=data;
  updateInfo(data) => playInfo.value=data;
}

// 主界面
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Controller c = Get.put(Controller());

  void playHandler(){
    if(c.isPlay==false){
      _audioHandler.play();
    }else{
      _audioHandler.pause();
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120,),
            Container(
              width: MediaQuery.of(context).size.width-100,
              height: MediaQuery.of(context).size.width-100,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset.zero,
                  )
                ]
              ),
              child: Obx(() => 
                c.playInfo.isEmpty ? 
                Image.asset(
                  "assets/blank.jpg",
                  fit: BoxFit.cover
                ) : 
                Image.network(
                  "${baseURL}/rest/getCoverArt?v=1.12.0&c=netPlayer&f=json&u=${username}&t=${token}&s=${salt}&id=${c.playInfo["id"]}",
                  fit: BoxFit.cover
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 70, 50, 20),
              child: Container(
                height: 40,
                child: Obx(() => 
                  Text(
                    c.playInfo.isEmpty ? 
                    "没有播放" : 
                    c.playInfo["title"],
                    style: TextStyle(fontSize: 25),
                    overflow: TextOverflow.ellipsis,
                  )
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Container(
                height: 25,
                child: Obx(() => 
                  Text(
                    c.playInfo.isEmpty ? 
                    "" : 
                    c.playInfo["artist"],
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.skip_previous_rounded,
                      size: 55,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                  onTap: (){
                    playHandler();
                  },
                  child: 
										Obx(() => 
                      c.isPlay==true ? 
                      Icon(
                        Icons.pause_rounded,
                        size: 55,
                      ) 
                      : Icon(
                        Icons.play_arrow_rounded,
                        size: 55,
                      ),
                    )
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: (){
                      _audioHandler.skipToNext();
                    },
                    child: Obx(() => 
                      Icon(
                        Icons.skip_next_rounded,
                        size: 55,
                        color: c.playInfo.isEmpty ? 
                        Colors.grey[400] : 
                        Colors.black,
                      ),
                    )
                  )
                ]
              ),
            )
          ],
        )
      ),
    );
  }
}