import 'dart:async';
import 'package:firebase/firebase.dart' as firebase;

class FBMessaging {
  FBMessaging._();
  static FBMessaging _instance = FBMessaging._();
  static FBMessaging get instance => _instance;
  firebase.Messaging _mc;
  String _token;

  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get stream => _controller.stream;

  void close() {
    _controller?.close();
  }

  Future<void> init() async {
    _mc = firebase.messaging();
    _mc.usePublicVapidKey(
        'BFuvDQt-sU1L3810kdLxuYTwxO4K9AKqQXlvlCN_p0pz_i1SCspVYH2zdVs6g6U-Dt9RpTp22NR1r2oYTn7nuYE');
    _mc.onMessage.listen((event) {
      _controller.add(event?.data);
    });
  }

  Future requestPermission() {
    return _mc.requestPermission();
  }

  Future<String> getToken([bool force = false]) async {
    if (force || _token == null) {
      await requestPermission();
      _token = await _mc.getToken();
    }
    return _token;
  }
}
