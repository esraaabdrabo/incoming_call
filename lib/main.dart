import 'dart:async';
import 'package:callkeep/callkeep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              try {
                CallKitParams callKitParams = CallKitParams(
                  id: "1",
                  nameCaller: 'esraa is calling you.',
                  appName: 'Callkit',
                  avatar: 'https://i.pravatar.cc/100',
                  handle:
                      'It\'s a voice call for now. Pick up when you\'re ready!',
                  type: 0,
                  textAccept: 'Accept',
                  textDecline: 'Decline',
                  textMissedCall: "missedddd callll",
                  duration: 10000,
                  extra: <String, dynamic>{'userId': '1a2b3c4d'},
                  headers: <String, dynamic>{
                    'apiKey': 'Abc@123!',
                    'platform': 'flutter'
                  },
                  android: const AndroidParams(
                    isCustomNotification: true,
                    isShowLogo: true,
                    isShowMissedCallNotification: true,
                    isShowCallback: true,
                    ringtonePath: 'system_ringtone_default',
                    backgroundColor: '#0955fa',
                    backgroundUrl: 'https://i.pravatar.cc/500',
                    actionColor: '#4CAF50',
                    incomingCallNotificationChannelName: "Incoming Call",
                    missedCallNotificationChannelName: "Missed Call",
                  ),
                  ios: IOSParams(
                    iconName: 'CallKitLogo',
                    handleType: 'generic',
                    supportsVideo: true,
                    maximumCallGroups: 2,
                    maximumCallsPerCallGroup: 1,
                    audioSessionMode: 'default',
                    audioSessionActive: true,
                    audioSessionPreferredSampleRate: 44100.0,
                    audioSessionPreferredIOBufferDuration: 0.005,
                    supportsDTMF: true,
                    supportsHolding: true,
                    supportsGrouping: false,
                    supportsUngrouping: false,
                    ringtonePath: 'system_ringtone_default',
                  ),
                );
                await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
                FlutterCallkitIncoming.onEvent.listen((event) {
                  if (event!.event == Event.ACTION_CALL_DECLINE) {
                    print("cancel");
                  } else if (event.event == Event.ACTION_CALL_CALLBACK) {
                    print("call back");
                  } else if (event.event == Event.ACTION_CALL_ACCEPT) {
                    print('accept');
                  }
                });
              } catch (e) {
                print(e);
              }
            },
            child: Text("data")),
      ),
    );
  }
}
