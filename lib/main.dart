import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'services/background_service.dart';
import 'services/caching_service.dart';
import 'services/logger/logger_service.dart';
import 'services/playback_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServices();
  runApp(const TrackOverflowApp());
}

Future<void> setupServices() async {
  getIt.registerLazySingleton<PlaybackService>(() => PlaybackService());
  getIt.registerLazySingleton<CachingService>(() => CachingService());
  getIt.registerLazySingleton<BackgroundService>(() => BackgroundService());
  getIt.registerLazySingleton<LoggerService>(() => LoggerService());
}

class TrackOverflowApp extends StatelessWidget {
  const TrackOverflowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackOverflow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PlaceholderScreen(),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playbackService = getIt<PlaybackService>();
    final cachingService = getIt<CachingService>();
    final backgroundService = getIt<BackgroundService>();
    final loggerService = getIt<LoggerService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TrackOverflow'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: playbackService.play,
              child: const Text("Test Playback"),
            ),
            ElevatedButton(
              onPressed: () {
                cachingService.cacheData("testKey", "testValue");
                print(cachingService.getCachedData("testKey"));
              },
              child: const Text("Test Caching"),
            ),
            ElevatedButton(
              onPressed: backgroundService.enableBackgroundPlayback,
              child: const Text("Test Background Service"),
            ),
            ElevatedButton(
              onPressed: () {
                loggerService.showErrorDialog(context, "This is a test error!");
                loggerService.logError("Hello World (of errors)!");
                loggerService.logWarning("Hello World (of warnings)!");
                loggerService.logInfo("Hello World (of info)!");
              },
              child: const Text("Test Error Handling"),
            ),
          ],
        ),
      ),
    );
  }
}
