import 'package:eve/eve.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moovy/core/services/local_storage_service.dart';
import 'package:moovy/main.dart';
import 'package:moovy/ui/widgets/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Widgets smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localStorageServiceProvider.overrideWithValue(MockLocalStorageService())
        ],
        child: Home(),
      ),
    );

    // Verify that widgets are rendered
    expect(find.byType(EveInputField), findsNWidgets(2));
    expect(find.byType(EveButton), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);

    //Verify that loader is not shown at default state
    expect(find.byType(Loader), findsNothing);

     //Verify that nothing happens when the login button is tapped at default state
     await tester.tap(find.byType(EveButton));
     await tester.pump();

  });
}

class MockLocalStorageService implements LocalStorageService{
  @override
  Future<void> setToken(String token) {
    throw UnimplementedError();
  }

  @override
  SharedPreferences get sharedPreferences => throw UnimplementedError();

  @override
  String get token => throw UnimplementedError();

}
