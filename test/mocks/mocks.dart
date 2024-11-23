import 'package:mockito/annotations.dart';
import 'package:track_overflow/services/background_service.dart';
import 'package:track_overflow/services/caching_service.dart';
import 'package:track_overflow/services/error_handler_service.dart';
import 'package:track_overflow/services/playback_service.dart';

@GenerateMocks(
    [PlaybackService, BackgroundService, CachingService, ErrorHandlerService])
void main() {}
