import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  group('ErrorHandlerService', () {
    late MockErrorHandlerService mockErrorHandlerService;

    setUp(() {
      mockErrorHandlerService = MockErrorHandlerService();
    });

    test('should log an error message', () {
      mockErrorHandlerService.logError('Test Error');
      verify(mockErrorHandlerService.logError('Test Error')).called(1);
    });

    testWidgets('should show an error dialog', (WidgetTester tester) async {
      final BuildContext context = tester.element(find.byType(Placeholder));
      mockErrorHandlerService.showErrorDialog(context, 'Test Error Message');
      verify(mockErrorHandlerService.showErrorDialog(
              context, 'Test Error Message'))
          .called(1);
    });
  });
}
