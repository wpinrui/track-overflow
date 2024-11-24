import 'package:track_overflow/services/logger/logger_service.dart';

abstract class LogDestination {
  Future<void> sendLog(LogLevel level, String message);
}
