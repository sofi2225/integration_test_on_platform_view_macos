import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/main.dart';

/*
Gestures we need to use in order of Priority:
  
  Priority 1: 
    Tap 

  Priority 2: 
    Scrolling with mouse wheel
    Select Text (Click on beginning of text, drag and relase click at the end)

  Priority 3: 
    Copy (CTRL +C)
    Arrow Up
    Arrow Down 
    Right click 
    Scroliing by dragging  (click on whell button and scroll up and down)
*/

loadAppAndOpenAppKitView(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  await tester.tap(find.text('load:"youtube.com"'));
  await Future.delayed(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Tap gesture', () {
    testWidgets(
      'Tap',
      (tester) async {
        //Load app and open AppKitview
        await loadAppAndOpenAppKitView(tester);

        //Perform Tap gesture in AppKitView
        await tester.tap(find.byType(AppKitView));
        await tester.pumpAndSettle();
      },
    );
  });

  group("Other gestures", () {
    testWidgets("Scrolling", (tester) async {
      //Load app and open AppKitview
      await loadAppAndOpenAppKitView(tester);

      //Scrolling
      await tester.fling(find.byType(UiKitView), const Offset(10, -1000), 80);
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });

    testWidgets('Long Press on Text should select text', (tester) async {
      //Load app and open AppKitview
      await loadAppAndOpenAppKitView(tester);

      //This coordinates might change with other screen resolutions
      final textCoordiante = tester.getCenter(find.byType(UiKitView)) + const Offset(100.0, 50.0);

      //Perform Select text gesture in AppKitView
      await tester.longPressAt(textCoordiante);
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });
  });

  group('Other unimplemented gestures', skip: true, () {
    testWidgets(
      'Right Click',
      (tester) async {
        //Load app and open AppKitview
        await loadAppAndOpenAppKitView(tester);

        //Perform Right Click gesture in AppKitView
      },
    );

    testWidgets('Scrolling with mouse wheel', (tester) async {
      //Load app and open AppKitview
      await loadAppAndOpenAppKitView(tester);

      //Perform Scrolling with mouse gesture in AppKitView
    });

    testWidgets('Copy (CLTL+C)', (tester) async {
      //Load app and open AppKitview
      await loadAppAndOpenAppKitView(tester);

      //Select text

      //Perform Copy gesture in AppKitViews
      await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
      await tester.sendKeyDownEvent(LogicalKeyboardKey.keyC);

      tester.pump();

      await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.keyC);

      await tester.pumpAndSettle();
    });

    testWidgets('Arrow up', (tester) async {
      //Load app and open AppKitview
      await loadAppAndOpenAppKitView(tester);

      //Perform arrow up gesture in AppKitViews
      await simulateKeyDownEvent(LogicalKeyboardKey.arrowUp);
      await tester.pumpAndSettle();
    });

    testWidgets('Arrow down', (tester) async {
      //Load app and open AppKitview
      await loadAppAndOpenAppKitView(tester);

      //Perform arrow down gesture in AppKitViews
      await simulateKeyDownEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
    });

    testWidgets('Scrolling by dragging', (tester) async {
      //Load app and open AppKitview
      await loadAppAndOpenAppKitView(tester);

      //Perform  Scrolling by dragging gesture in AppKitView
    });
  });
}
