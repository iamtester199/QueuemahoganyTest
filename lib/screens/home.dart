import 'package:flutter/material.dart';
import 'package:Queuemahogany/screens/status.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:Queuemahogany/widget/text_field_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'Data.dart';
import 'currentQueue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_messaging.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final formKey = GlobalKey<FormState>();
String hnnumberString;

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    senddownloadDataRequest();
    firebaseRead();
    firebaseMessage();
  }

  Future firebaseRead() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference = firestore.collection('queue');
      collectionReference.snapshots().listen((response) {
        List<DocumentSnapshot> snapshots = response.docs;
        for (var snaphot in snapshots) {
          //print('MyData : ${snaphot.data()}');
          currentQueue = new List<CurrentQueue>();

          setState(() {
            currentQueue.add(new CurrentQueue.fromJson(snaphot.data()));
          });
        }
      });
    });
  }

  Future firebaseMessage() async {
    final _messaging = FBMessaging.instance;
    await _messaging.init();
    _messaging.requestPermission().then((_) async {
      final _token = await _messaging.getToken();
      print('Token: $_token');
    });

    _messaging.stream.listen((event) {
      // ignore: unnecessary_brace_in_string_interps
      print('New Message: ${event}');
    });
  }

  // Future<void> senddownloadDataRequest() async {
  //   var url =
  //       'https://sheets.googleapis.com/v4/spreadsheets/1jJOi0vZYjMZa5SnxvHBt3w4Vl3qaHPsZo3fzACzLLqI/values/queue!A2:E/?key=AIzaSyBqaDDBMrB6s4JYcR3KVPnoKdGFmdYN-dw';
  //   http.get(url).then((response) {
  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body);
  //       //print(data['values']);
  //       if (data['values'] != null) {
  //         data1 = new List<Data>();
  //         data['values'].forEach((v) {
  //           data1.add(new Data.fromJson(v));
  //         });
  //       }
  //     } else {
  //       AwesomeDialog(
  //           context: context,
  //           animType: AnimType.LEFTSLIDE,
  //           headerAnimationLoop: false,
  //           dialogType: DialogType.ERROR,
  //           title: 'ข้อผิดพลาด',
  //           desc: 'ไม่สามารถเชื่อมต่อเซิพเวอร์ได้ กรุณาลองใหม่อีกครั้ง',
  //           btnOkOnPress: () {
  //             debugPrint('OnClcik');
  //             senddownloadDataRequest();
  //           },
  //           btnOkIcon: Icons.cached,
  //           btnOkText: "ลองใหม่อีกครั้ง",
  //           btnOkColor: Colors.red,
  //           onDissmissCallback: () {
  //             debugPrint('Dialog Dissmiss from callback');
  //           })
  //         ..show();
  //     }
  //     print("Response status: ${response.statusCode}");
  //     print("Response body: ${response.body}");
  //   });
  // }

  Future<void> senddownloadDataRequest() async {
    var url =
        'https://sheets.googleapis.com/v4/spreadsheets/1jJOi0vZYjMZa5SnxvHBt3w4Vl3qaHPsZo3fzACzLLqI/values/all!A2:E/?key=AIzaSyBqaDDBMrB6s4JYcR3KVPnoKdGFmdYN-dw';
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        //print(data['values']);
        if (data['values'] != null) {
          data1 = new List<Data>();
          if (data['values'][0].toString().isNotEmpty) {
            data['values'].forEach((v) {
              data1.add(new Data.fromJson(v));
            });
          }
        }
      } else {
        AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.ERROR,
            title: 'ข้อผิดพลาด',
            desc: 'ไม่สามารถเชื่อมต่อเซิพเวอร์ได้ กรุณาลองใหม่อีกครั้ง',
            btnOkOnPress: () {
              debugPrint('OnClcik');
              senddownloadDataRequest();
            },
            btnOkIcon: Icons.cached,
            btnOkText: "ลองใหม่อีกครั้ง",
            btnOkColor: Colors.red,
            onDissmissCallback: () {
              debugPrint('Dialog Dissmiss from callback');
            })
          ..show();
      }
      //print("Response status: ${response.statusCode}");
      //print("Response body: ${response.body}");
    });
  }

  final hnHolder = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  //color: Color(0xFF014751),
                  height: 250.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF014751),
                    image: DecorationImage(
                      image: AssetImage('images/logo.png'),
                      //fit: BoxFit.fitWidth,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Text(
                            'คลินิกพิเศษเฉพาะทางนอกเวลาราชการ',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'SukhumvitSet',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: 331.0,
                          child: PBTextField(
                            controller: hnHolder,
                            leadingIcon: Icons.person,
                            hintText: "Please enter your HN",
                            onSaved: (value) => hnnumberString = value,
                            onChange: (value) => hnnumberString = value,
                            maxLength: 25,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 288.0,
                          height: 100.0,
                          child: Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 288.0, 78.0),
                                size: Size(288.0, 100.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40)
                                        // topLeft: Radius.circular(40.0),
                                        // bottomLeft: Radius.circular(40.0),
                                        ),
                                    color: Color(0xFF014751),
                                  ),
                                  child: FlatButton(
                                    child: Text(
                                      'ดูคิวตรวจ',
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontFamily: 'SukhumvitSet',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (hnHolder.value.text.isNotEmpty) {
                                        print('press search');
                                        print(hnnumberString);
                                        var contain = data1.where((element) =>
                                            element.hn ==
                                            hnnumberString.toString());
                                        if (contain.isEmpty) {
                                          AwesomeDialog(
                                              context: context,
                                              animType: AnimType.LEFTSLIDE,
                                              headerAnimationLoop: false,
                                              dialogType: DialogType.WARNING,
                                              title: 'ข้อผิดพลาด',
                                              desc:
                                                  'ไม่พบหมายเลข HN ของท่านกรุณาระบุใหม่อีกครั้ง',
                                              btnOkOnPress: () {
                                                debugPrint('OnClcik');
                                                //hnnumberString = "";
                                              },
                                              //btnOkIcon: Icons.cached,
                                              btnOkText: "ตกลง",
                                              btnOkColor: Colors.red,
                                              onDissmissCallback: () {
                                                debugPrint(
                                                    'Dialog Dissmiss from callback');
                                              })
                                            ..show();
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Status(
                                                  hnnumber: hnnumberString,
                                                ),
                                              ));
                                        }
                                      } else {
                                        AwesomeDialog(
                                            context: context,
                                            animType: AnimType.LEFTSLIDE,
                                            headerAnimationLoop: false,
                                            dialogType: DialogType.WARNING,
                                            title: 'ข้อผิดพลาด',
                                            desc: 'กรุณาระบุหมายเลข HN ของท่าน',
                                            btnOkOnPress: () {
                                              debugPrint('OnClcik');
                                              //hnHolder.clear();
                                              //hnnumberString = "";
                                            },
                                            //btnOkIcon: Icons.cached,
                                            btnOkText: "ตกลง",
                                            btnOkColor: Colors.red,
                                            onDissmissCallback: () {
                                              debugPrint(
                                                  'Dialog Dissmiss from callback');
                                            })
                                          ..show();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
