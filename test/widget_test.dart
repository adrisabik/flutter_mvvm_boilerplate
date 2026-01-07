import 'package:flutter_mvvm_boilerplate/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App should build without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that the app builds successfully
    expect(find.byType(App), findsOneWidget);
  });
}
