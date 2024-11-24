import 'package:flutter/material.dart';
import 'package:track_overflow/services/logger/destinations/log_destination.dart';

enum LogLevel {
  info,
  warning,
  error;

  @override
  String toString() {
    switch (this) {
      case LogLevel.info:
        return "INFO";
      case LogLevel.warning:
        return "WARNING";
      case LogLevel.error:
        return "ERROR";
    }
  }
}

class LoggerService {
  final List<LogDestination> _destinations = [];

  void addDestination(LogDestination destination) {
    _destinations.add(destination);
  }

  void _log(LogLevel level, String message) {
    for (final destination in _destinations) {
      destination.sendLog(level, message);
    }
  }

  void logError(String message) {
    _log(LogLevel.error, message);
  }

  void logWarning(String message) {
    _log(LogLevel.warning, message);
  }

  void logInfo(String message) {
    _log(LogLevel.info, message);
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
