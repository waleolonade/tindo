import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Show_Post/views/openImage.dart';

class SendDummyMessage extends StatefulWidget {
  final String message;
  final String time;
  final String profilePic;
  final int messageType;
  final int index;
  const SendDummyMessage({
    Key? key,
    required this.message,
    required this.time,
    required this.profilePic,
    required this.messageType,
    required this.index,
  }) : super(key: key);

  @override
  State<SendDummyMessage> createState() => _SendDummyMessageState();
}

class _SendDummyMessageState extends State<SendDummyMessage> {
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: (widget.messageType == 5)
                    ? MediaQuery.of(context).size.width - 200
                    : MediaQuery.of(context).size.width - 130,
              ),
              child: Card(
                elevation: 2,
                shape: const RoundedRectangleBorder(
                    // side: BorderSide(
                    //     // color: Color(0xff68677C).withOpacity(0.6),
                    //     // color: theme_Color.pink,
                    //     width: 0.7),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                // color: Color(0xff1D1C2E),
                color: ThemeColor.pink,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Stack(
                  children: [
                    (widget.messageType == 1)
                        ? Container(
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.only(
                                left: 10,
                                right: (widget.message.length <= 7) ? 45 : 10,
                                top: 12,
                                bottom: 20),
                            child: Image.network(widget.message),
                          )
                        : (widget.messageType == 2)
                            ? GestureDetector(
                                onTap: () {
                                  Get.to(()=>OpenImage(
                                    images: widget.message,
                                  ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 3,
                                      right:
                                          (widget.message.length <= 7) ? 45 : 3,
                                      top: 3,
                                      bottom: 3),
                                  child: SizedBox(
                                    height: 280,
                                    width: 215,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                        topRight: Radius.circular(13),
                                      ),
                                      child: FadeInImage(
                                        placeholder: AssetImage(
                                          AppImages.placeHoder,
                                        ),
                                        image: NetworkImage(widget.message),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : (widget.messageType == 4)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        right: (widget.message.length <= 7)
                                            ? 45
                                            : 10,
                                        top: 12,
                                        bottom: 20),
                                    child: Row(
                                      children: [
                                        StreamBuilder<PlayerState>(
                                          stream: player.playerStateStream,
                                          builder: (context, snapshot) {
                                            final playerState = snapshot.data;
                                            final processingState =
                                                playerState?.processingState;
                                            final playing =
                                                playerState?.playing;
                                            if (processingState ==
                                                    ProcessingState.loading ||
                                                processingState ==
                                                    ProcessingState.buffering) {
                                              return GestureDetector(
                                                onTap: player.play,
                                                child: const Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.white),
                                              );
                                            } else if (playing != true) {
                                              return GestureDetector(
                                                onTap: player.play,
                                                child: const Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.white),
                                              );
                                            } else if (processingState !=
                                                ProcessingState.completed) {
                                              return GestureDetector(
                                                onTap: player.pause,
                                                child: const Icon(Icons.pause,
                                                    color: Colors.white),
                                              );
                                            } else {
                                              return GestureDetector(
                                                child: const Icon(Icons.replay,
                                                    color: Colors.white),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    LinearProgressIndicator(
                                                      color: ThemeColor.white,
                                                      backgroundColor:
                                                          Colors.grey.shade400,
                                                      value: snapshot.data!
                                                              .inMilliseconds /
                                                          (duration
                                                                  ?.inMilliseconds ??
                                                              1),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      prettyDuration(
                                                          snapshot.data! ==
                                                                  Duration.zero
                                                              ? duration ??
                                                                  Duration.zero
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
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: (widget.message.length <= 7)
                                                ? 45
                                                : 10,
                                            top: 12,
                                            bottom: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: ThemeColor.white,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              child: const ImageIcon(
                                                AssetImage(
                                                  "Images/new_dis/video.png",
                                                ),
                                                size: 28,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Video call",
                                                  style: TextStyle(
                                                    fontFamily: 'amidum',
                                                    fontSize: 17,
                                                    //color: theme_Color.white,
                                                    color: ThemeColor.white,
                                                    height: 1.2,
                                                  ),
                                                ),
                                                Text(
                                                  widget.message,
                                                  style: TextStyle(
                                                    fontFamily: 'amidum',
                                                    fontSize: 12,
                                                    //color: theme_Color.white,
                                                    color: ThemeColor.white
                                                        .withOpacity(0.8),
                                                    height: 1.2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: (widget.message.length <= 7)
                                                ? 45
                                                : 10,
                                            top: 12,
                                            bottom: 20),
                                        child: Text(
                                          widget.message,
                                          style: TextStyle(
                                            fontFamily: 'amidum',
                                            fontSize: 17,
                                            color: ThemeColor.white,
                                            height: 1.2,
                                          ),
                                        ),
                                      ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Text(
                        widget.time,
                        style: TextStyle(
                          fontFamily: 'amidum',
                          //color: theme_Color.offwhite.withOpacity(0.5),
                          color: ThemeColor.white.withOpacity(0.8),
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.profilePic), fit: BoxFit.cover),
              shape: BoxShape.circle,
              border: Border.all(
                // color: Color(0xff68677C),
                color: ThemeColor.pink,
                width: 1,
              ),
            ),
          )
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
