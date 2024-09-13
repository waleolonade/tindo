import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Show_Post/views/openImage.dart';

class ReceiveDummyMessage extends StatefulWidget {
  final String message;
  final String time;
  final String profilePic;
  final int messageType;
  final int? callType;
  const ReceiveDummyMessage({
    Key? key,
    required this.message,
    required this.time,
    required this.profilePic,
    required this.messageType,
    this.callType,
  }) : super(key: key);

  @override
  State<ReceiveDummyMessage> createState() => _ReceiveDummyMessageState();
}

class _ReceiveDummyMessageState extends State<ReceiveDummyMessage> {
  final player = AudioPlayer();
  Duration? duration;
  @override
  void initState() {
    super.initState();
    if (widget.messageType == 4) {
      player.setUrl(widget.message).then((value) {
        setState(() {
          duration = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(widget.profilePic), fit: BoxFit.cover),
              shape: BoxShape.circle,
              border: Border.all(
                  // color: theme_Color.pink,
                  color: Colors.grey.shade200,
                  width: 1),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                //
                maxWidth:
                    (widget.messageType == 5) ? MediaQuery.of(context).size.width - 200 : MediaQuery.of(context).size.width - 130,
              ),
              child: Card(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15), bottomRight: Radius.circular(15), topRight: Radius.circular(15))),
                //color: ThemeColor.pink,
                color: Colors.grey.shade200,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Stack(
                  children: [
                    (widget.messageType == 1)
                        ? Container(
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.only(left: 10, right: (widget.message.length <= 7) ? 40 : 8, top: 10, bottom: 20),
                            child: Image.network(widget.message),
                          )
                        : (widget.messageType == 2)
                            ? GestureDetector(
                                onTap: () {
                                  Get.to(OpenImage(
                                    images: widget.message,
                                  ));
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 4, right: (widget.message.length <= 7) ? 40 : 4, top: 4, bottom: 4),
                                  child: SizedBox(
                                    height: 280,
                                    width: 215,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(13),
                                          bottomRight: Radius.circular(13),
                                          topRight: Radius.circular(13)),
                                      // child: FadeInImage(
                                      //   placeholder:
                                      //       AssetImage(AppImages.placeHoder),
                                      //   image: NetworkImage(widget.message),
                                      //   fit: BoxFit.cover,
                                      // ),
                                      child: Image.network(widget.message, fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              )
                            : (widget.messageType == 4)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: (widget.message.length <= 7) ? 40 : 8, top: 10, bottom: 20),
                                    child: Row(
                                      children: [
                                        StreamBuilder<PlayerState>(
                                          stream: player.playerStateStream,
                                          builder: (context, snapshot) {
                                            final playerState = snapshot.data;
                                            final processingState = playerState?.processingState;
                                            final playing = playerState?.playing;
                                            if (processingState == ProcessingState.loading ||
                                                processingState == ProcessingState.buffering) {
                                              return GestureDetector(
                                                onTap: player.play,
                                                child: const Icon(Icons.play_arrow),
                                              );
                                            } else if (playing != true) {
                                              return GestureDetector(
                                                onTap: player.play,
                                                child: const Icon(Icons.play_arrow),
                                              );
                                            } else if (processingState != ProcessingState.completed) {
                                              return GestureDetector(
                                                onTap: player.pause,
                                                child: const Icon(Icons.pause),
                                              );
                                            } else {
                                              return GestureDetector(
                                                child: const Icon(Icons.replay),
                                                onTap: () {
                                                  player.seek(Duration.zero);
                                                },
                                              );
                                            }
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: StreamBuilder<Duration>(
                                            stream: player.positionStream,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    LinearProgressIndicator(
                                                      color: ThemeColor.pink,
                                                      backgroundColor: Colors.grey.shade400,
                                                      value: snapshot.data!.inMilliseconds / (duration?.inMilliseconds ?? 1),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      prettyDuration(snapshot.data! == Duration.zero
                                                          ? duration ?? Duration.zero
                                                          : snapshot.data!),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return const LinearProgressIndicator();
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : (widget.messageType == 5)
                                    ? Padding(
                                        padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: ThemeColor.blacklight,
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              child: const ImageIcon(
                                                AssetImage(
                                                  "Images/new_dis/video.png",
                                                ),
                                                size: 28,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Video call",
                                                  style: TextStyle(
                                                    fontFamily: 'amidum',
                                                    fontSize: 17,
                                                    //color: theme_Color.white,
                                                    color: ThemeColor.blackback,
                                                    height: 1.2,
                                                  ),
                                                ),
                                                Text(
                                                  widget.message,
                                                  style: TextStyle(
                                                    fontFamily: 'amidum',
                                                    fontSize: 12,
                                                    //color: theme_Color.white,
                                                    color: ThemeColor.grayIcon,
                                                    height: 1.2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Spacer(),
                                            // (widget.callType == 1)
                                            //     ? Icon(
                                            //         Icons.call,
                                            //         color: Colors.green,
                                            //       )
                                            //     : Icon(
                                            //         Icons.call_end,
                                            //         color: Colors.red,
                                            //       )
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: (widget.message.length <= 7) ? 40 : 8, top: 10, bottom: 20),
                                        child: Text(
                                          widget.message,
                                          style: TextStyle(
                                            fontFamily: 'amidum',
                                            fontSize: 17,
                                            //color: theme_Color.white,
                                            color: ThemeColor.blackback,
                                            height: 1.2,
                                          ),
                                        ),
                                      ),
                    Positioned(
                      bottom: 5,
                      right: 12,
                      child: Text(
                        widget.time,
                        style: TextStyle(
                          fontFamily: 'amidum',
                          //color: theme_Color.white.withOpacity(0.8),
                          color: (widget.messageType == 2) ? ThemeColor.white : ThemeColor.blackback.withOpacity(0.7),
                          fontSize: 8,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String prettyDuration(Duration d) {
    var min = d.inMinutes < 10 ? "0${d.inMinutes}" : d.inMinutes.toString();
    var sec = d.inSeconds < 10 ? "0${d.inSeconds}" : d.inSeconds.toString();
    return "$min:$sec";
  }
}
