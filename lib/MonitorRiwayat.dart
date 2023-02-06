// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MonitorRiwayat extends StatefulWidget {
  const MonitorRiwayat({super.key});

  @override
  State<MonitorRiwayat> createState() => _MonitorRiwayatState();
}

class _MonitorRiwayatState extends State<MonitorRiwayat> {
  StreamController<List> controllerstream = StreamController();
  late Timer _timer;
  var link = Uri.parse("http://192.168.43.2/iottugasversi2/ceksuhu.php");

  Future _ambilnilai() async {
    var res = await http.get(link);
    var _databarang = jsonDecode(res.body);
    controllerstream.add(_databarang);
  }

  @override
  void initState() {
    _ambilnilai();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) => _ambilnilai());
    super.initState();
  }

  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Suhu     Kelembapan  Sensor Api     Tanggal         Jam',
          style: TextStyle(color: Colors.black, fontSize: 13),
        ),
        backgroundColor: Colors.white,
        // foregroundColor: Colors.grey,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<List>(
            stream: controllerstream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                    dragStartBehavior: DragStartBehavior.down,
                    children: snapshot.data!.reversed.map((data) {
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: 30,
                                height: 20,
                                alignment: Alignment.center,
                                child: Text(data['temperature'])),
                            Container(
                                width: 80,
                                height: 20,
                                alignment: Alignment.center,
                                child: Text(data['humidity'])),
                            Container(
                                width: 50,
                                height: 20,
                                alignment: Alignment.center,
                                child: Text(data['sensorapi'])),
                                Container(
                                width: 77,
                                height: 20,
                                alignment: Alignment.center,
                                child: Text(data['tanggal'])),
                                Container(
                                alignment: Alignment.center,
                                width: 55,
                                height: 20,
                                child: Text(data['jam'])),
                          ],
                        ),
                      );
                    }).toList());
              }
              return Container();
            }),
      ),
    );
  }
}
