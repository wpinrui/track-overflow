import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  group('BackgroundService', () {
    late MockBackgroundService mockBackgroundService;

    setUp(() {
      mockBackgroundService = MockBackgroundService();
    });

    test('should enable background playback', () {
      mockBackgroundService.enableBackgroundPlayback();
      verify(mockBackgroundService.enableBackgroundPlayback()).called(1);
    });

    test('should disable background playback', () {
      mockBackgroundService.disableBackgroundPlayback();
      verify(mockBackgroundService.disableBackgroundPlayback()).called(1);
    });

    test('should update media controls with track name', () {
      mockBackgroundService.updateMediaControls('Track Name');
      verify(mockBackgroundService.updateMediaControls('Track Name')).called(1);
    });
  });
}
