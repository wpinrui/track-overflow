import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_overflow/services/logger/destinations/log_destination.dart';
import 'package:track_overflow/services/logger/logger_service.dart';

const kLogCollection = 'logs';

class FirestoreLogDestination implements LogDestination {
  final FirebaseFirestore _firestore;

  FirestoreLogDestination(this._firestore);

  @override
  Future<void> sendLog(LogLevel level, String message) async {
    final timestampId = DateTime.now().toUtc().toIso8601String();
    await _firestore.collection(kLogCollection).doc(timestampId).set({
      'level': level.toString(),
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
}
