//import 'package:borrow/screens/borrow.dart';
import 'package:Queuemahogany/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:page_transition/page_transition.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);
  @override
  _WelcomeState createState() => _WelcomeState();
}

final formKey = GlobalKey<FormState>();

class _WelcomeState extends State<Welcome> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  String depid;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getValuesSF();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.amber,
                child: Text(
                  'OK',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SukhumvitSet',
                      color: Color.fromRGBO(0, 28, 100, 1.0)),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });

    firebaseMessaging.getToken().then((token) {
      print('Firebase Token : ' +token);
    });
  }

  saveValuesandsignout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('autologin', false);
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => Home());
    Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }

  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    depid = prefs.getString('departmentid');
    print('dpid : $depid');
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () {
        myAlert();
      },
    );
  }

  void myAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure exit application'),
          content: Text('Do you want sign out ?'),
          actions: <Widget>[cancelButton(), okButton()],
        );
      },
    );
  }

  Widget okButton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
        firebaseMessaging.unsubscribeFromTopic(depid);
        saveValuesandsignout();
        //processSignOut();
      },
    );
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget showBorrowText() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          'ระบบยืมคืน',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'SukhumvitSet',
          ),
        ),
      ),
    );
  }

  // Widget showBorrowLogo() {
  //   return Container(
  //     padding: EdgeInsets.all(3),
  //     width: 150.0,
  //     height: 150.0,
  //     child: IconButton(
  //       icon: Image.asset('images/borrow.png'),
  //       color: Color.fromRGBO(0, 28, 100, 1.0),
  //       onPressed: () {
  //         // MaterialPageRoute materialPageRoute = MaterialPageRoute(
  //         //     builder: (BuildContext context) => Borrow());
  //         // Navigator.of(context).push(materialPageRoute);
  //         Navigator.push(
  //             context,
  //             PageTransition(
  //                 type: PageTransitionType.rightToLeft, child: Borrow()));
  //       },
  //     ),
  //   );
  // }

  // Widget showVehicleText() {
  //   return Container(
  //     padding: const EdgeInsets.all(10),
  //     child: Center(
  //       child: Text(
  //         'ระบบจองรถ',
  //         style: TextStyle(
  //           fontSize: 30,
  //           fontWeight: FontWeight.bold,
  //           fontFamily: 'SukhumvitSet',
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget showVehicleLogo() {
  //   return Container(
  //     padding: EdgeInsets.all(3),
  //     width: 150.0,
  //     height: 150.0,
  //     child: IconButton(
  //       icon: Image.asset('images/bookingcar.png'),
  //       color: Color.fromRGBO(0, 28, 100, 1.0),
  //       onPressed: () {
  //         // Navigator.push(
  //         //     context,
  //         //     PageTransition(
  //         //         type: PageTransitionType.rightToLeft, child: Borrow()));
  //         Fluttertoast.showToast(
  //             msg: "ระบบจองรถเร็ว ๆ นี้!",
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIos: 1,
  //             backgroundColor: Colors.amber,
  //             textColor: Color.fromRGBO(0, 28, 100, 1.0),
  //             fontSize: 16.0);
  //       },
  //     ),
  //   );
  // }

  // Widget showBorrowLogo() {
  //   return Card(
  //       elevation: 1.0,
  //       margin: new EdgeInsets.all(8.0),
  //       child: Container(
  //         decoration: BoxDecoration(color: Colors.amber[100]),
  //         child: new InkWell(
  //           onTap: () {
  //             Navigator.push(
  //                 context,
  //                 PageTransition(
  //                     type: PageTransitionType.rightToLeft, child: Borrow()));
  //           },
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             mainAxisSize: MainAxisSize.min,
  //             verticalDirection: VerticalDirection.down,
  //             children: <Widget>[
  //               SizedBox(height: 42.0),
  //               Center(
  //                 child: IconButton(
  //                   alignment: Alignment.center,
  //                   icon: Image.asset('images/borrow.png'),
  //                   onPressed: () {
  //                     Navigator.push(
  //                         context,
  //                         PageTransition(
  //                             type: PageTransitionType.rightToLeft,
  //                             child: Borrow()));
  //                   },
  //                   // size: 40.0,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //               SizedBox(height: 20.0),
  //               new Center(
  //                 child: new Text('ระบบยืมคืน',
  //                     style: new TextStyle(
  //                       fontSize: 18.0,
  //                       color: Color.fromRGBO(0, 28, 100, 1.0),
  //                       fontWeight: FontWeight.bold,
  //                       fontFamily: 'SukhumvitSet',
  //                     )),
  //               )
  //             ],
  //           ),
  //         ),
  //       ));
  // }

  Widget showVehicleLogo() {
    return Card(
      elevation: 1.0,
      margin: new EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.amber[100]),
        child: new InkWell(
          onTap: () {
            Fluttertoast.showToast(
                msg: "ระบบจองรถเร็ว ๆ นี้!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.amber,
                textColor: Color.fromRGBO(0, 28, 100, 1.0),
                fontSize: 16.0);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: 50.0),
              Center(
                child: Icon(
                  Icons.time_to_leave,
                  size: 40.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.0),
              new Center(
                child: new Text(
                  'ระบบจองรถ',
                  style: new TextStyle(
                    fontSize: 18.0,
                    color: Color.fromRGBO(0, 28, 100, 1.0),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SukhumvitSet',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'depa portal',
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'SukhumvitSet'),
        ),
        backgroundColor: Color.fromRGBO(0, 28, 100, 1.0),
        actions: <Widget>[signOutButton()],
        leading: new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 10),
          children: <Widget>[
            DrawerHeader(
              child: Text(
                '',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('images/logo.png'))),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'ตั้งค่า',
                style: new TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SukhumvitSet'),
              ),
              onTap: () => {
                Fluttertoast.showToast(
                    msg: "การตั้งค่าเร็ว ๆ นี้!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.amber,
                    textColor: Color.fromRGBO(0, 28, 100, 1.0),
                    fontSize: 16.0)
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'ออกจากระบบ',
                style: new TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SukhumvitSet'),
              ),
              onTap: () => {myAlert()},
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            //showBorrowText(),
            //showBorrowLogo(),
            //showVehicleText(),
            showVehicleLogo(),
          ],
        ),
      ),
    );
  }
}
