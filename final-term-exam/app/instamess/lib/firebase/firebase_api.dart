import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:instamess/repositories/firebase_repository.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _firebaseRepository = FirebaseRepository();

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      await _firebaseRepository.storeToken(fcmToken);
    }
  }
}
