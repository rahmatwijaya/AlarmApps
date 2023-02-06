
import 'package:flutter/material.dart';
import 'HalamanMonitor.dart';
import 'HalamanNotifikasi.dart';

class AlarmApps extends StatefulWidget {
  const AlarmApps({super.key});

  @override
  State<AlarmApps> createState() => _AlarmAppsState();
}

class _AlarmAppsState extends State<AlarmApps> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm Apps',
      debugShowCheckedModeBanner: false,
      routes: {'/fcm-page':(_) => HalamanNotifikasi()},
      home: HalamanMonitor(),
    );
  }
}
