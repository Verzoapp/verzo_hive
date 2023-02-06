// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i16;
import 'package:flutter/foundation.dart' as _i17;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i18;
import 'package:verzo_one/ui/business_profile_creation/business_profile_creation_view.dart'
    as _i10;
import 'package:verzo_one/ui/create_account/create_account_view.dart' as _i6;
import 'package:verzo_one/ui/dashboard/dashboard_view.dart' as _i12;
import 'package:verzo_one/ui/expenses/expenses_view.dart' as _i13;
import 'package:verzo_one/ui/forgot_password/forgot_password_view.dart' as _i8;
import 'package:verzo_one/ui/invoicing/invoicing_view.dart' as _i15;
import 'package:verzo_one/ui/login/login_view.dart' as _i7;
import 'package:verzo_one/ui/sales/sales_view.dart' as _i14;
import 'package:verzo_one/ui/select_tags/select_tags_view.dart' as _i11;
import 'package:verzo_one/ui/verification/verification_view.dart' as _i9;
import 'package:verzo_one/ui/views/first_screen.dart' as _i3;
import 'package:verzo_one/ui/views/home_screen.dart' as _i2;
import 'package:verzo_one/ui/views/login_screen.dart' as _i4;
import 'package:verzo_one/ui/views/second_screen.dart' as _i5;

class Routes {
  static const homeScreenRoute = '/home-screen';

  static const firstScreenRoute = '/first-screen';

  static const LoginScreenRoute = '/login-screen';

  static const secondScreenRoute = '/second-screen';

  static const createAccountRoute = '/create-account-view';

  static const loginRoute = '/';

  static const forgotPasswordRoute = '/forgot-password-view';

  static const verificationRoute = '/verification-view';

  static const businessProfileCreationRoute = '/business-profile-creation-view';

  static const selectTagsRoute = '/select-tags-view';

  static const dashboardRoute = '/dashboard-view';

  static const expensesRoute = '/expenses-view';

  static const salesRoute = '/sales-view';

  static const invoicingRoute = '/invoicing-view';

  static const all = <String>{
    homeScreenRoute,
    firstScreenRoute,
    LoginScreenRoute,
    secondScreenRoute,
    createAccountRoute,
    loginRoute,
    forgotPasswordRoute,
    verificationRoute,
    businessProfileCreationRoute,
    selectTagsRoute,
    dashboardRoute,
    expensesRoute,
    salesRoute,
    invoicingRoute,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeScreenRoute,
      page: _i2.HomeScreen,
    ),
    _i1.RouteDef(
      Routes.firstScreenRoute,
      page: _i3.FirstScreen,
    ),
    _i1.RouteDef(
      Routes.LoginScreenRoute,
      page: _i4.LoginScreen,
    ),
    _i1.RouteDef(
      Routes.secondScreenRoute,
      page: _i5.SecondScreen,
    ),
    _i1.RouteDef(
      Routes.createAccountRoute,
      page: _i6.CreateAccountView,
    ),
    _i1.RouteDef(
      Routes.loginRoute,
      page: _i7.LoginView,
    ),
    _i1.RouteDef(
      Routes.forgotPasswordRoute,
      page: _i8.ForgotPasswordView,
    ),
    _i1.RouteDef(
      Routes.verificationRoute,
      page: _i9.VerificationView,
    ),
    _i1.RouteDef(
      Routes.businessProfileCreationRoute,
      page: _i10.BusinessProfileCreationView,
    ),
    _i1.RouteDef(
      Routes.selectTagsRoute,
      page: _i11.SelectTagsView,
    ),
    _i1.RouteDef(
      Routes.dashboardRoute,
      page: _i12.DashboardView,
    ),
    _i1.RouteDef(
      Routes.expensesRoute,
      page: _i13.ExpensesView,
    ),
    _i1.RouteDef(
      Routes.salesRoute,
      page: _i14.SalesView,
    ),
    _i1.RouteDef(
      Routes.invoicingRoute,
      page: _i15.InvoicingView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeScreen: (data) {
      final args = data.getArgs<HomeScreenArguments>(
        orElse: () => const HomeScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i2.HomeScreen(key: args.key),
        settings: data,
      );
    },
    _i3.FirstScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.FirstScreen(),
        settings: data,
      );
    },
    _i4.LoginScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LoginScreen(),
        settings: data,
      );
    },
    _i5.SecondScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SecondScreen(),
        settings: data,
      );
    },
    _i6.CreateAccountView: (data) {
      final args = data.getArgs<CreateAccountViewArguments>(
        orElse: () => const CreateAccountViewArguments(),
      );
      return _i16.CupertinoPageRoute<dynamic>(
        builder: (context) => _i6.CreateAccountView(key: args.key),
        settings: data,
      );
    },
    _i7.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i16.CupertinoPageRoute<dynamic>(
        builder: (context) => _i7.LoginView(key: args.key),
        settings: data,
      );
    },
    _i8.ForgotPasswordView: (data) {
      final args = data.getArgs<ForgotPasswordViewArguments>(
        orElse: () => const ForgotPasswordViewArguments(),
      );
      return _i16.CupertinoPageRoute<dynamic>(
        builder: (context) => _i8.ForgotPasswordView(key: args.key),
        settings: data,
      );
    },
    _i9.VerificationView: (data) {
      final args = data.getArgs<VerificationViewArguments>(
        orElse: () => const VerificationViewArguments(),
      );
      return _i16.CupertinoPageRoute<dynamic>(
        builder: (context) => _i9.VerificationView(key: args.key),
        settings: data,
      );
    },
    _i10.BusinessProfileCreationView: (data) {
      final args = data.getArgs<BusinessProfileCreationViewArguments>(
        orElse: () => const BusinessProfileCreationViewArguments(),
      );
      return _i16.CupertinoPageRoute<dynamic>(
        builder: (context) =>
            _i10.BusinessProfileCreationView(key: args.key, busy: args.busy),
        settings: data,
      );
    },
    _i11.SelectTagsView: (data) {
      final args = data.getArgs<SelectTagsViewArguments>(
        orElse: () => const SelectTagsViewArguments(),
      );
      return _i16.CupertinoPageRoute<dynamic>(
        builder: (context) =>
            _i11.SelectTagsView(key: args.key, busy: args.busy),
        settings: data,
      );
    },
    _i12.DashboardView: (data) {
      return _i16.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i12.DashboardView(),
        settings: data,
      );
    },
    _i13.ExpensesView: (data) {
      return _i16.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i13.ExpensesView(),
        settings: data,
      );
    },
    _i14.SalesView: (data) {
      return _i16.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i14.SalesView(),
        settings: data,
      );
    },
    _i15.InvoicingView: (data) {
      return _i16.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i15.InvoicingView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeScreenArguments {
  const HomeScreenArguments({this.key});

  final _i17.Key? key;
}

class CreateAccountViewArguments {
  const CreateAccountViewArguments({this.key});

  final _i17.Key? key;
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i17.Key? key;
}

class ForgotPasswordViewArguments {
  const ForgotPasswordViewArguments({this.key});

  final _i17.Key? key;
}

class VerificationViewArguments {
  const VerificationViewArguments({this.key});

  final _i17.Key? key;
}

class BusinessProfileCreationViewArguments {
  const BusinessProfileCreationViewArguments({
    this.key,
    this.busy = false,
  });

  final _i17.Key? key;

  final bool busy;
}

class SelectTagsViewArguments {
  const SelectTagsViewArguments({
    this.key,
    this.busy = false,
  });

  final _i17.Key? key;

  final bool busy;
}

extension NavigatorStateExtension on _i18.NavigationService {
  Future<dynamic> navigateToHomeScreenRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeScreenRoute,
        arguments: HomeScreenArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFirstScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.firstScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.LoginScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSecondScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.secondScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateAccountRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.createAccountRoute,
        arguments: CreateAccountViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginRoute,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgotPasswordRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.forgotPasswordRoute,
        arguments: ForgotPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVerificationRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.verificationRoute,
        arguments: VerificationViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBusinessProfileCreationRoute({
    _i17.Key? key,
    bool busy = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.businessProfileCreationRoute,
        arguments: BusinessProfileCreationViewArguments(key: key, busy: busy),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSelectTagsRoute({
    _i17.Key? key,
    bool busy = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.selectTagsRoute,
        arguments: SelectTagsViewArguments(key: key, busy: busy),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExpensesRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.expensesRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSalesRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.salesRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToInvoicingRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.invoicingRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeScreenRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeScreenRoute,
        arguments: HomeScreenArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFirstScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.firstScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.LoginScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSecondScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.secondScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateAccountRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.createAccountRoute,
        arguments: CreateAccountViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginRoute,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgotPasswordRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.forgotPasswordRoute,
        arguments: ForgotPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVerificationRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.verificationRoute,
        arguments: VerificationViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBusinessProfileCreationRoute({
    _i17.Key? key,
    bool busy = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.businessProfileCreationRoute,
        arguments: BusinessProfileCreationViewArguments(key: key, busy: busy),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSelectTagsRoute({
    _i17.Key? key,
    bool busy = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.selectTagsRoute,
        arguments: SelectTagsViewArguments(key: key, busy: busy),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dashboardRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExpensesRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.expensesRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSalesRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.salesRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithInvoicingRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.invoicingRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}