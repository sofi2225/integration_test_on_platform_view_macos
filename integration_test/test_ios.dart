import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../lib/main.dart';

loadAppAndOpenAppKitView(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await Future.delayed(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Tap Gesture', () {
    testWidgets(
      'Tap',
      (tester) async {
        //Load app and open UiKitview
        await loadAppAndOpenAppKitView(tester);

        //Perform Tap gesture in UiKitView
        await tester.tap(find.byType(WebViewWidget));
        await tester.pumpAndSettle();
      },
    );
  });

  group('Other Gestures', () {
    testWidgets(
      'Long press on Text should select text',
      (tester) async {
        //Load app and open UiKitview
        await loadAppAndOpenAppKitView(tester);

        //This uses a iphone 15 for tests, might change with other screen resolutions
        final textCoordiante = tester.getCenter(find.byType(UiKitView)) + const Offset(100.0, 50.0);

        //Long Press
        await tester.longPressAt(textCoordiante);
        await tester.pumpAndSettle(const Duration(seconds: 5));
      },
    );

    testWidgets(
      'Long press on Text should select text',
      (tester) async {
        //Load app and open UiKitview
        await loadAppAndOpenAppKitView(tester);

        //Scrolling
        await tester.fling(find.byType(UiKitView), const Offset(10, -1000), 80);
        await tester.pumpAndSettle(const Duration(seconds: 5));
      },
    );
  });
}
