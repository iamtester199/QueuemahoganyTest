import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'Data.dart';

class Info extends StatefulWidget {
  final String hnnumber;
  Info({Key key, @required this.hnnumber}) : super(key: key);
  @override
  _InfoState createState() => _InfoState();
}

final formKey = GlobalKey<FormState>();
String hnnumberString;
int indexvalue;

const appSteps = [
  'ตรวจ',
  'จ่ายเงิน',
  'รับยา',
];
const currentStep = 1;

class _InfoState extends State<Info> with SingleTickerProviderStateMixin {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    hnnumberString = widget.hnnumber;
    indexvalue = data1.indexWhere((element) => element.hn == hnnumberString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: const Color(0xffffffff),
      body:
          // Form(
          //   child: new FutureBuilder(
          //     future: senddownloadDataRequest(),
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       if (snapshot.hasData) {
          //         return
          SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  color: Color(0xFF014751),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 250.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFF014751),
                          image: DecorationImage(
                            image: AssetImage('images/logo.png'),
                            //fit: BoxFit.fitWidth,
                          ),
                          shape: BoxShape.rectangle,
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
                                print('back press');
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
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
                          data1[indexvalue].patient,
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'SukhumvitSet',
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          //margin: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(maxHeight: 320),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(
                            //     width: 1, color: const Color(0xFF9F92E2)),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
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
                                axis: TimelineAxis.vertical,
                                alignment: TimelineAlign.manual,
                                lineXY: 0.7,
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
                                  constraints:
                                      const BoxConstraints(minWidth: 120),
                                  //margin: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(left: 70),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
