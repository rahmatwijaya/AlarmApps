// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:d_chart/d_chart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MonitoringSuhu extends StatefulWidget {
  const MonitoringSuhu({super.key});

  @override
  State<MonitoringSuhu> createState() => _MonitoringSuhuState();
}

class _MonitoringSuhuState extends State<MonitoringSuhu> {
  @override
  final datasuhu = FirebaseDatabase.instance.ref();
  final datakel = FirebaseDatabase.instance.ref();
  final datakondisi = FirebaseDatabase.instance.ref();
  final datatanggal = FirebaseDatabase.instance.ref();
  final datawaktu = FirebaseDatabase.instance.ref();
  final datasensorapi = FirebaseDatabase.instance.ref();
  final datarelay = FirebaseDatabase.instance.ref();
  double datafi = 0.0;
  late bool kondisi;
  bool keterangan = false;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 400,
                height: 60,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 20, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Alarm Apps',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: StreamBuilder(
                          stream: datawaktu.child('Waktu').onValue,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && !snapshot.hasError) {
                              String datadate =
                                  snapshot.data!.snapshot.value.toString();
                              return Row(
                                children: [
                                  Text('$datadate',
                                      style: const TextStyle(fontSize: 15))
                                ],
                              );
                            }
                            return Container();
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: const Text(
                      'Data Sensor',
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 320,
                    height: 220,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 140,
                                height: 160,
                                child: StreamBuilder(
                                    stream:
                                        datasuhu.child("Sensor Api").onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          !snapshot.hasError) {
                                        String datas = snapshot
                                            .data!.snapshot.value
                                            .toString();
                                        datafi = double.parse(datas);
                                        // ignore: avoid_unnecessary_containers
                                        return Container(
                                          // padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircularPercentIndicator(
                                                    radius: 50.0,
                                                    lineWidth: 11.0,
                                                    animation: true,
                                                    percent: datafi / 1000,
                                                    center: Text(
                                                      '$datas',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0),
                                                    ),
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round,
                                                    progressColor: datafi >= 700
                                                        ? Colors.red
                                                        : Colors.yellow,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  const Text(
                                                    "Sensor Api",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17.0),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return Container();
                                    }),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 160,
                          height: 190,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      // alignment: Alignment.centerRight,

                                      margin: const EdgeInsets.only(left: 30),
                                      child: StreamBuilder(
                                          stream: datakondisi
                                              .child('Kondisi')
                                              .onValue,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                !snapshot.hasError) {
                                              String datako = snapshot
                                                  .data!.snapshot.value
                                                  .toString();
                                              return Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    width: 120,
                                                    height: 90,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Container(
                                                      width: 110,
                                                      height: 50,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              330,
                                                              236,
                                                              235,
                                                              235),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Text(
                                                        '$datako',
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                            return Container();
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 160,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        StreamBuilder(
                                            stream: datasuhu
                                                .child("Temperature")
                                                .onValue,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData &&
                                                  !snapshot.hasError) {
                                                String datas = snapshot
                                                    .data!.snapshot.value
                                                    .toString();
                                                datafi = double.parse(datas);
                                                // ignore: avoid_unnecessary_containers
                                                return Container(
                                                  // padding: const EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CircularPercentIndicator(
                                                            radius: 25.0,
                                                            lineWidth: 7.0,
                                                            animation: true,
                                                            percent:
                                                                datafi / 100,
                                                            center: Text(
                                                              '$datas C',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      10.0),
                                                            ),
                                                            circularStrokeCap:
                                                                CircularStrokeCap
                                                                    .round,
                                                            progressColor:
                                                                datafi >= 33
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .purpleAccent,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                            "Temperature",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12.0),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                              return Container();
                                            }),
                                        StreamBuilder(
                                            stream: datakel
                                                .child("Humidity")
                                                .onValue,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData &&
                                                  !snapshot.hasError) {
                                                String data = snapshot
                                                    .data!.snapshot.value
                                                    .toString();
                                                datafi = double.parse(data);
                                                return Container(
                                                  // padding: const EdgeInsets.all(5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CircularPercentIndicator(
                                                            radius: 25.0,
                                                            lineWidth: 7.0,
                                                            animation: true,
                                                            percent:
                                                                datafi / 100,
                                                            center: Text(
                                                              '$data %',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12.0),
                                                            ),
                                                            circularStrokeCap:
                                                                CircularStrokeCap
                                                                    .round,
                                                            progressColor:
                                                                datafi <= 79
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors
                                                                        .red,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                            "Kelembapan",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 10.0),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }
                                              return Container();
                                            }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        children: [
                          const RotatedBox(
                              quarterTurns: 3, child: Text('Quantity')),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 13,
                                  child: DChartLine(
                                    lineColor: (lineData, index, id) {
                                      return id == 'Line 1'
                                          ? Colors.blue
                                          : Colors.amber;
                                    },
                                    data: [
                                      {
                                        'id': 'Line 1',
                                        'data': [
                                          {'domain': 1, 'measure': 3},
                                          {'domain': 2, 'measure': 3},
                                          {'domain': 3, 'measure': 4},
                                          {'domain': 4, 'measure': 6},
                                          {'domain': 5, 'measure': 0.3},
                                        ],
                                      },
                                      {
                                        'id': 'Line 2',
                                        'data': [
                                          {'domain': 1, 'measure': 4},
                                          {'domain': 2, 'measure': 5},
                                          {'domain': 3, 'measure': 2},
                                          {'domain': 4, 'measure': 1},
                                          {'domain': 5, 'measure': 2.5},
                                        ],
                                      },
                                    ],
                                    includePoints: true,
                                    animate: true,
                                  ),
                                ),
                                const Text('Day'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // TextButton(onPressed: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=> TestGrafik()));
                    // }, child: Text('Tekan'))
                  ],
                ),
              ),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => TestGrafik()));
              //     },
              //     child: Text('Tekan'))
              // Stack(
              //   children: [
              //     Container(
              //         // height: 20,
              //         alignment: Alignment(1, 2),
              //         margin: const EdgeInsets.only(right: 30),
              //         child: FloatingActionButton(
              //             child: const Icon(Icons.graphic_eq_outlined),
              //             onPressed: () {
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => HalamanTabel()));
              //             }))
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
