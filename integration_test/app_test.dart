import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turathi/main.dart' as app;

void main(){

  app.main();
  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
            (tester) async {
          await tester.pumpWidget(const app.MyApp());

         expect(find.byKey(Key("SplashImage")), findsOneWidget);
        //   await tester.pumpAndSettle();
        //
        //   if (FirebaseAuth.instance.currentUser != null){
        //     expect(find.byKey(Key("Notification")), findsOneWidget);
        //     final fab = find.byKey(const ValueKey('Notification'));
        //     await tester.tap(fab);
        //     await tester.pumpAndSettle();
        //     expect(find.byKey( Key("Notifications page")), findsOneWidget);
        //   }
        //   else
        //
        //     expect(find.byKey(Key("log in")), findsOneWidget);
        //
        });
  });
}