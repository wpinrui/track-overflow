import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  group('PlaybackService', () {
    late MockPlaybackService mockPlaybackService;

    setUp(() {
      mockPlaybackService = MockPlaybackService();
    });

    test('should call play on PlaybackService', () {
      mockPlaybackService.play();
      verify(mockPlaybackService.play()).called(1);
    });
  });
}
