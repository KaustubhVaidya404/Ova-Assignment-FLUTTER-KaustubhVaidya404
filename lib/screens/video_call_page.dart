import 'package:chatlily/config/color_config.dart';
import 'package:chatlily/webrtcservices/signaling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  Signaling _signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  String? roomId;

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    _signaling.onAddRemoteStream = ((strem) {
      _remoteRenderer.srcObject = strem;
    });
    //_signaling.openUserMedia(_localRenderer, _remoteRenderer);
    // roomId = await _signaling.createRoom(_remoteRenderer);
    // _signaling.joinRoom(roomId!, _remoteRenderer);
    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Video Call'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
                Expanded(child: RTCVideoView(_remoteRenderer)),
              ],
            ),
          )),
          const SizedBox(
            height: 8,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    roomId = await _signaling.createRoom(_remoteRenderer);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: createCallButtonColor),
                  child: const Text("create")),
            ),
            const SizedBox(
              width: 2,
            ),
            // Container(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //       onPressed: () {
            //         _signaling.joinRoom(roomId!.trim(), _remoteRenderer);
            //       },
            //       child: const Text("join")),
            // ),
            // const SizedBox(
            //   width: 2,
            // ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await _signaling.openUserMedia(
                        _localRenderer, _remoteRenderer);
                  },
                  child: const Text("cam")),
            ),
            const SizedBox(
              width: 2,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    _signaling.hangUp(_localRenderer);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: endCallButtonColor),
                  child: const Text("End")),
            ),
          ]),
        ],
      ),
    );
  }
}
