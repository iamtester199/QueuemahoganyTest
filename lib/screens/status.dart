import 'package:Queuemahogany/screens/info.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeline_tile/timeline_tile.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:http/http.dart' as http;
import 'dart:async';
// import 'dart:convert';
import 'Data.dart';
import 'currentQueue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_messaging.dart';

class Status extends StatefulWidget {
  final String hnnumber;
  Status({Key key, @required this.hnnumber}) : super(key: key);
  @override
  _StatusState createState() => _StatusState();
}

final formKey = GlobalKey<FormState>();
String hnnumberString;
String waitQueue = "novalue";
int indexvalue, intQueue;

const appSteps = [
  'ตรวจ',
  'จ่ายเงิน',
  //'รับยา',
];
int currentStep = 0;

class _StatusState extends State<Status> with SingleTickerProviderStateMixin {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    hnnumberString = widget.hnnumber;
    indexvalue = data1.indexWhere((element) => element.hn == hnnumberString);
    firebaseRead();
    //firebaseMessage();
  }

  Future firebaseMessage() async {
    final _messaging = FBMessaging.instance;

    _messaging.stream.listen((event) {
      print('New Message: ${event.toString()}');
    });
  }

  Future firebaseRead() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference = firestore.collection('queue');
      collectionReference.snapshots().listen((response) {
        List<DocumentSnapshot> snapshots = response.docs;
        for (var snaphot in snapshots) {
          print('MyData : ${snaphot.data()}');
          currentQueue = new List<CurrentQueue>();
          currentQueue.clear();
          currentQueue.add(new CurrentQueue.fromJson(snaphot.data()));

          if (mounted) {
            setState(() {
              currentQueue.add(new CurrentQueue.fromJson(snaphot.data()));
              calculate();
            });
          }
        }
      });
    });
  }

  Future calculate() async {
    if (data1[indexvalue].room == '1') {
      intQueue = int.parse(data1[indexvalue].no) - currentQueue[0].room1;
    } else if (data1[indexvalue].room == '2') {
      intQueue = int.parse(data1[indexvalue].no) - currentQueue[0].room2;
    } else if (data1[indexvalue].room == '3') {
      intQueue = int.parse(data1[indexvalue].no) - currentQueue[0].room3;
    } else if (data1[indexvalue].room == '4') {
      intQueue = int.parse(data1[indexvalue].no) - currentQueue[0].room4;
    } else if (data1[indexvalue].room == '5') {
      intQueue = int.parse(data1[indexvalue].no) - currentQueue[0].room5;
    } else {
      intQueue = int.parse(data1[indexvalue].no) - currentQueue[0].room6;
    }

    if (intQueue == 0) {
      currentStep = 0;
      waitQueue = "ถึงคิวของคุณแล้ว";
    } else if (intQueue < 0) {
      currentStep = 1;
      waitQueue = "ดำเนินการตรวจแล้ว";
    } else {
      currentStep = 0;
      waitQueue = "รออีก ${intQueue.toString()} คิว";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: const Color(0xffffffff),
      body:
          // Form(
          //   child: new FutureBuilder(
          //       future: senddownloadDataRequest(),
          //       builder: (BuildContext context, AsyncSnapshot snapshot) {
          //         if (snapshot.hasData) {
          //           return
          SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      if (currentStep == 0)
                        Container(
                          height: 250.0,
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xFF657ee5),
                        ),
                      if (currentStep == 1)
                        Container(
                          height: 250.0,
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xFFE565D0),
                        ),
                      if (currentStep == 2)
                        Container(
                          height: 250.0,
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xFF014751),
                        ),
                      Transform.translate(
                        offset: Offset(
                            MediaQuery.of(context).size.width - 72.0, 30.0),
                        child: ClipOval(
                          child: Material(
                            color: Color(0x657EE5), // button color
                            child: InkWell(
                              splashColor: Color(0x014751), // inkwell color
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(
                                  //Icons.power_settings_new,
                                  Icons.info,
                                  size: 56,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                print('info press');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Info(
                                        hnnumber: hnnumberString,
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(10.0, 30.0),
                        child: ClipOval(
                          child: Material(
                            color: Color(0x657EE5), // button color
                            child: InkWell(
                              splashColor: Color(0x014751), // inkwell color
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(
                                  //Icons.power_settings_new,
                                  Icons.arrow_back,
                                  size: 56,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                print('exit press');
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            Text(
                              'คิวปัจจุบัน',
                              style: TextStyle(
                                fontFamily: 'SukhumvitSet',
                                fontSize: 40,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            if (data1[indexvalue].room == '1')
                              Text(
                                currentQueue[0].room1.toString(),
                                style: TextStyle(
                                  fontFamily: 'SukhumvitSet',
                                  fontSize: 120,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffffffff),
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (data1[indexvalue].room == '2')
                              Text(
                                currentQueue[0].room2.toString(),
                                style: TextStyle(
                                  fontFamily: 'SukhumvitSet',
                                  fontSize: 120,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffffffff),
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (data1[indexvalue].room == '3')
                              Text(
                                currentQueue[0].room3.toString(),
                                style: TextStyle(
                                  fontFamily: 'SukhumvitSet',
                                  fontSize: 120,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffffffff),
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (data1[indexvalue].room == '4')
                              Text(
                                currentQueue[0].room4.toString(),
                                style: TextStyle(
                                  fontFamily: 'SukhumvitSet',
                                  fontSize: 120,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffffffff),
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (data1[indexvalue].room == '5')
                              Text(
                                currentQueue[0].room5.toString(),
                                style: TextStyle(
                                  fontFamily: 'SukhumvitSet',
                                  fontSize: 120,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffffffff),
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (data1[indexvalue].room == '6')
                              Text(
                                currentQueue[0].room6.toString(),
                                style: TextStyle(
                                  fontFamily: 'SukhumvitSet',
                                  fontSize: 120,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffffffff),
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'คิวของคุณ',
                        style: TextStyle(
                          fontFamily: 'SukhumvitSet',
                          fontSize: 40,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'HN : ${data1[indexvalue].hn}',
                        style: TextStyle(
                          fontFamily: 'SukhumvitSet',
                          fontSize: 20,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        data1[indexvalue].no.toString(),
                        style: TextStyle(
                          fontFamily: 'SukhumvitSet',
                          fontSize: 120,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        waitQueue,
                        style: TextStyle(
                          fontFamily: 'SukhumvitSet',
                          fontSize: 50,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // Text(
                      //   'รออีกประมาณ x นาที',
                      //   style: TextStyle(
                      //     fontFamily: 'Sukhumvit Set',
                      //     fontSize: 30,
                      //     color: const Color(0xff000000),
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 322.0,
                        height: 117.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          border: Border.all(
                              width: 1.0, color: const Color(0xff707070)),
                        ),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'SukhumvitSet',
                              fontSize: 37,
                              color: const Color(0xff000000),
                            ),
                            children: [
                              if (currentStep == 0)
                                TextSpan(
                                  text:
                                      'ห้องตรวจที่ ${data1[indexvalue].room}\n',
                                  style: TextStyle(
                                    fontFamily: 'SukhumvitSet',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (currentStep == 0)
                                TextSpan(
                                  text: (data1[indexvalue].physician),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'SukhumvitSet',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (currentStep == 1)
                                TextSpan(
                                  text: 'ชำระเงิน\n',
                                  style: TextStyle(
                                    fontFamily: 'SukhumvitSet',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (currentStep == 1)
                                TextSpan(
                                  text: 'ที่ช่องจ่ายเงิน',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'SukhumvitSet',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (currentStep == 2)
                                TextSpan(
                                  text: 'รับยา\n',
                                  style: TextStyle(
                                    fontFamily: 'SukhumvitSet',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (currentStep == 2)
                                TextSpan(
                                  text: 'ที่ช่องบริการ 3',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'SukhumvitSet',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                //SliverToBoxAdapter(
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  constraints: const BoxConstraints(maxHeight: 120),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        //Border.all(width: 1, color: const Color(0xFF9F92E2)),
                        Border.all(width: 1, color: const Color(0xFF000000)),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: appSteps.length,
                    itemBuilder: (BuildContext context, int index) {
                      var beforeLineStyle = const LineStyle(
                        thickness: 20,
                        color: Color(0xFFD4D4D4),
                      );

                      LineStyle afterLineStyle;
                      if (index <= currentStep) {
                        beforeLineStyle = const LineStyle(
                          thickness: 20,
                          //color: Color(0xFF9F92E2),
                          color: Color(0xFF014751),
                        );
                      }

                      if (index == currentStep) {
                        afterLineStyle = const LineStyle(
                          thickness: 20,
                          color: Color(0xFFD4D4D4),
                        );
                      }

                      final isFirst = index == 0;
                      final isLast = index == appSteps.length - 1;
                      var indicatorX = 0.5;
                      if (isFirst) {
                        indicatorX = 0.3;
                      } else if (isLast) {
                        indicatorX = 0.7;
                      }

                      return TimelineTile(
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.manual,
                        lineXY: 0.8,
                        isFirst: isFirst,
                        isLast: isLast,
                        beforeLineStyle: beforeLineStyle,
                        afterLineStyle: afterLineStyle,
                        hasIndicator: index <= currentStep || isLast,
                        indicatorStyle: IndicatorStyle(
                          width: 20,
                          height: 20,
                          indicatorXY: indicatorX,
                          color: const Color(0xFFD4D4D4),
                          indicator: index <= currentStep
                              ? const _IndicatorApp()
                              : null,
                        ),
                        startChild: Container(
                          constraints: const BoxConstraints(minWidth: 120),
                          margin: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if ('$index' == '0')
                                Icon(
                                  Icons.access_time,
                                  size: 40,
                                  color: index <= currentStep
                                      ? const Color(0xFF014751)
                                      : const Color(0xFFD4D4D4),
                                ),
                              if ('$index' == '1')
                                Icon(
                                  Icons.local_atm,
                                  size: 40,
                                  color: index <= currentStep
                                      ? const Color(0xFF014751)
                                      : const Color(0xFFD4D4D4),
                                ),
                              if ('$index' == '2')
                                Icon(
                                  Icons.done,
                                  size: 40,
                                  color: index <= currentStep
                                      ? const Color(0xFF014751)
                                      : const Color(0xFFD4D4D4),
                                ),
                              //Image.asset('images/logo.jpg', height: 40),
                              const SizedBox(width: 8),
                              Text(
                                appSteps[index],
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'SukhumvitSet',
                                  fontWeight: FontWeight.w500,
                                  color: index <= currentStep
                                      ? const Color(0xFF014751)
                                      : const Color(0xFFD4D4D4),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //),
              ],
            ),
          ),
        ),
        //     );
        //   } else {
        //     return Center(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         mainAxisSize: MainAxisSize.max,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: <Widget>[
        //           CircularProgressIndicator(
        //             valueColor: new AlwaysStoppedAnimation<Color>(
        //                 Color(0xFF014751)),
        //           ),
        //           Text(
        //             'กำลังโหลดข้อมูล...',
        //             style: new TextStyle(
        //                 fontSize: 20.0,
        //                 fontWeight: FontWeight.bold,
        //                 color: Color.fromRGBO(0, 28, 100, 1.0),
        //                 fontFamily: 'SukhumvitSet'),
        //           ),
        //         ],
        //       ),
        //     );
        //   }
        // }),
      ),
    );
  }
}

class _IndicatorApp extends StatelessWidget {
  const _IndicatorApp();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        //color: Color(0xFF9F92E2),
        color: Color(0xFF014751),
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
