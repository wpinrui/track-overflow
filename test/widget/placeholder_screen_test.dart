import 'package:flutter_test/flutter_test.dart';
import 'package:track_overflow/main.dart';

void main() {
  testWidgets('should display welcome message and buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TrackOverflowApp());

    // Verify the welcome message
    expect(find.text('Welcome to TrackOverflow!'), findsOneWidget);

    // Verify the buttons
    expect(find.text('Test Playback'), findsOneWidget);
    expect(find.text('Test Caching'), findsOneWidget);
    expect(find.text('Test Background Service'), findsOneWidget);
    expect(find.text('Test Error Handling'), findsOneWidget);

    // Simulate tapping the "Test Playback" button
    await tester.tap(find.text('Test Playback'));
    await tester.pump(); // Process animations and updates
  });
}
