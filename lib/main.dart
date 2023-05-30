import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/verzo_auth_service.dart';
import 'package:verzo_one/ui/setup_bottom_sheet_ui.dart';
import 'package:verzo_one/ui/setup_dialog_ui.dart';
import 'package:verzo_one/ui/setup_snackbar_ui.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'helpers/auth_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  setupDialogUi();
  setupSnackbarUi();
  setupBottomSheetUi();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authService = VerzoAuthService();

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: authService.client,
      child: MaterialApp(
        title: 'Stacked Services Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorObservers: [
          StackedService.routeObserver,
          _LoggingObserver(),
        ],
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
      ),
    );
  }
}

class _LoggingObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    print(
        'route.name: ${route.settings.name}, previousRoute.name: ${previousRoute?.settings?.name}');
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    print(
        'route.name: ${route.settings.name}, previousRoute.name: ${previousRoute?.settings?.name}');
    super.didRemove(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    print(
        'route.name: ${route.settings.name}, previousRoute.name: ${previousRoute?.settings?.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    print(
        'newRoute.name: ${newRoute?.settings.name}, oldRoute.name: ${oldRoute?.settings.name}');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
