import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  group('CachingService', () {
    late MockCachingService mockCachingService;

    setUp(() {
      mockCachingService = MockCachingService();
    });

    test('should cache data with a key and value', () {
      mockCachingService.cacheData('key', 'value');
      verify(mockCachingService.cacheData('key', 'value')).called(1);
    });

    test('should retrieve cached data by key', () {
      when(mockCachingService.getCachedData('key')).thenReturn('value');
      final result = mockCachingService.getCachedData('key');
      expect(result, 'value');
      verify(mockCachingService.getCachedData('key')).called(1);
    });

    test('should clear the cache', () {
      mockCachingService.clearCache();
      verify(mockCachingService.clearCache()).called(1);
    });
  });
}
