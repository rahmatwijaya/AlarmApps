import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'MonitorRiwayat.dart';
import 'MonitorSuhu.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HalamanMonitor extends StatefulWidget {
  const HalamanMonitor({super.key});

  @override
  State<HalamanMonitor> createState() => _HalamanMonitorState();
}

class _HalamanMonitorState extends State<HalamanMonitor> {
  final pages = [
    MonitoringSuhu(),
    const MonitorRiwayat()
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  void initState() {
    initialization();
    FirebaseMessaging.instance.getToken().then((value) {
      print("Token: $value");
    });
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((message){
      if(message != null){
        // print(message.notification!.title);
        var routeName = message.data['route'];
        Navigator.of(context).pushNamed(routeName);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if(event != null){
        // print(event.notification!.title);
        var routeName = event.data['route'];
        Navigator.of(context).pushNamed(routeName);
      }
    });
    FirebaseMessaging.onMessage.listen((event) {
      if(event != null){
        // print(event.notification!.title);
        var routeName = event.data['route'];
        Navigator.of(context).pushNamed(routeName);
      }
    });  
    
  }
  void initialization() async {
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                label: 'Monitoring', icon: Icon(Icons.monitor)),
            BottomNavigationBarItem(label: 'Riwayat', icon: Icon(Icons.history))
          ]),
          
    );
  }
}