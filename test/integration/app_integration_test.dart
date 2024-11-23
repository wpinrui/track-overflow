import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:track_overflow/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('full app test', (WidgetTester tester) async {
    await tester.pumpWidget(const TrackOverflowApp());

    // Verify the placeholder screen is shown
    expect(find.text('Welcome to TrackOverflow!'), findsOneWidget);

    // Test button interactions
    await tester.tap(find.text('Test Playback'));
    await tester.pump(); // Process updates
    // You'd normally mock the service and assert it was called.

    await tester.tap(find.text('Test Error Handling'));
    await tester.pump();

    // Verify error dialog appears
    expect(find.text('This is a test error!'), findsOneWidget);
  });
}
