import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';

class DashboardService {
  ValueNotifier<GraphQLClient> client;

  final QueryOptions _getBusinessesByUserIdQuery;
  final QueryOptions _getExpensesForWeekQuery;
  final QueryOptions _getPurchasesForWeekQuery;
  final QueryOptions _getExpensesForMonthQuery;
  final QueryOptions _getPurchasesForMonthQuery;
  final QueryOptions _totalWeeklyInvoicesAmountQuery;
  final QueryOptions _totalMonthlyInvoicesAmountQuery;

  DashboardService()
      : client = ValueNotifier(GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink('https://api.verzo.app/graphql'),
        )),
        _getBusinessesByUserIdQuery = QueryOptions(
          document: gql('''
        query GetBusinessesByUserId{
          getBusinessesByUserId {
            businesses{
            id
            businessName
            businessEmail
            businessMobile
            }
            }
            }
            '''),
        ),
        _getExpensesForWeekQuery = QueryOptions(
          document: gql('''
        query GetExpensesForWeek (\$businessId: String!,\$weekly: Boolean){
          getExpensesForWeek (businessId: \$businessId, weekly: \$weekly){
            totalExpenseAmountThisWeek
            percentageOfExpenseToInvoiceThisWeek
            percentageIncreaseInExpenseThisWeek
            }
            }
            '''),
        ),
        _getPurchasesForWeekQuery = QueryOptions(
          document: gql('''
        query GetPurchasesForWeek (\$businessId: String!,\$weekly: Boolean){
          getPurchasesForWeek (businessId: \$businessId, weekly: \$weekly){
            totalPurchaseAmountThisWeek
            totalPendingPurchaseAmountThisWeek
            }
            }
            '''),
        ),
        _getExpensesForMonthQuery = QueryOptions(
          document: gql('''
        query GetExpensesForMonth(\$businessId: String!,\$monthly: Boolean) {
          getExpensesForMonth (businessId: \$businessId, monthly: \$monthly){
            totalExpenseAmountThisMonth
            percentageOfExpenseToInvoiceThisMonth
            percentageIncreaseInExpenseThisMonth
            }
            }
            '''),
        ),
        _getPurchasesForMonthQuery = QueryOptions(
          document: gql('''
        query GetPurchasesForMonth(\$businessId: String!,\$monthly: Boolean) {
          getPurchasesForMonth (businessId: \$businessId, monthly: \$monthly){
            totalPurchaseAmountThisMonth
            totalPendingPurchaseAmountThisMonth
            }
            }
            '''),
        ),
        _totalWeeklyInvoicesAmountQuery = QueryOptions(
          document: gql('''
        query TotalWeeklyInvoicesAmount(\$businessId: String!,\$weekly: Boolean){
          totalWeeklyInvoicesAmount (businessId: \$businessId, weekly: \$weekly){
            totalInvoiceAmountForWeek
            percentageOfPaidInvoices
            totalPendingInvoiceAmountThisWeek
            percentageIncreaseInPendingInvoiceThisWeek
            totalOverDueInvoiceAmountThisWeek
            percentageIncreaseInOverdueInvoicesThisWeek
            }
            }
            '''),
        ),
        _totalMonthlyInvoicesAmountQuery = QueryOptions(
          document: gql('''
        query TotalMonthlyInvoicesAmount (\$businessId: String!,\$monthly: Boolean) {
          totalMonthlyInvoicesAmount (businessId: \$businessId, monthly: \$monthly) {
            totalInvoiceAmountForMonth
            percentageOfPaidInvoicesForMonth
            totalPendingInvoiceAmountThisMonth
            percentageIncreaseInPendingInvoiceThisMonth
            totalOverdueInvoiceAmountThisMonth
            percentageIncreaseInOverdueInvoicesThisMonth
            }
            }
            '''),
        );

  Future<BusinessIdResult> businessId() async {
    final navigationService = locator<NavigationService>();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      return BusinessIdResult.error(
        error: GraphQLAuthError(
          message: "Access token not found",
        ),
      );
    }
    final authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );

    // Create a new GraphQLClient with the authlink
    final newClient = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
    );

    final QueryResult businessIdResult =
        await newClient.query(_getBusinessesByUserIdQuery);

    if (businessIdResult.hasException) {
      return BusinessIdResult.error(
        error: GraphQLAuthError(
          message: businessIdResult.exception?.graphqlErrors.first.message
              .toString(),
        ),
      );
    }

    final businessesData =
        businessIdResult.data?['getBusinessesByUserId']['businesses'];

    if (businessesData.isEmpty) {
      navigationService.replaceWith(Routes.businessProfileCreationRoute);
      return BusinessIdResult.error(
        error: GraphQLAuthError(
          message: "No business ID found",
        ),
      );
    }

    var result_businessid = businessIdResult.data?['getBusinessesByUserId']
            ['businesses'][0]['id'] ??
        '';
    var result_businessName = businessIdResult.data?['getBusinessesByUserId']
            ['businesses'][0]['businessName'] ??
        '';
    var result_businessEmail = businessIdResult.data?['getBusinessesByUserId']
            ['businesses'][0]['businessEmail'] ??
        '';
    var result_businessMobile = businessIdResult.data?['getBusinessesByUserId']
            ['businesses'][0]['businessMobile'] ??
        '';

    prefs.setString('businessId', result_businessid ?? '');
    prefs.setString('businessName', result_businessName ?? '');
    prefs.setString('businessEmail', result_businessEmail ?? '');
    prefs.setString('businessMobile', result_businessMobile ?? '');

    var businessId = BusinessIdSuccessResult(
        result_businessId: result_businessid,
        result_businessName: result_businessName,
        result_businessEmail: result_businessName,
        result_businessMobile: result_businessMobile);
    return BusinessIdResult(businessId: businessId);
  }

  Future<ExpensesForWeek> getExpensesForWeek(
      {required String businessId, bool? weekly = true}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      throw GraphQLAuthError(
        message: "Access token not found",
      );
    }

    final authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );

    final newClient = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
    );

    final QueryOptions options = QueryOptions(
      document: _getExpensesForWeekQuery.document,
      variables: {'businessId': businessId, 'weekly': weekly},
    );

    final QueryResult expensesResult = await newClient.query(options);

    if (expensesResult.hasException) {
      throw GraphQLAuthError(
        message:
            expensesResult.exception?.graphqlErrors.first.message.toString(),
      );
    }

    final totalExpenseAmountThisWeek = expensesResult
        .data?['getExpensesForWeek']['totalExpenseAmountThisWeek'];
    final percentageOfExpenseToInvoiceThisWeek = expensesResult
        .data?['getExpensesForWeek']['percentageOfExpenseToInvoiceThisWeek'];
    final percentageIncreaseInExpenseThisWeek = expensesResult
        .data?['getExpensesForWeek']['percentageIncreaseInExpenseThisWeek'];

    var expensesForTheWeek = ExpensesForWeek(
      totalExpenseAmountThisWeek: totalExpenseAmountThisWeek,
      percentageOfExpenseToInvoiceThisWeek:
          percentageOfExpenseToInvoiceThisWeek,
      percentageIncreaseInExpenseThisWeek: percentageIncreaseInExpenseThisWeek,
    );

    return expensesForTheWeek;
  }

  Future<PurchasesForWeek> getPurchasesForWeek(
      {required String businessId, bool? weekly = true}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      throw GraphQLAuthError(
        message: "Access token not found",
      );
    }

    final authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );

    final newClient = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
    );

    final QueryOptions options = QueryOptions(
      document: _getPurchasesForWeekQuery.document,
      variables: {'businessId': businessId, 'weekly': weekly},
    );

    final QueryResult purchasesResult = await newClient.query(options);

    if (purchasesResult.hasException) {
      throw GraphQLAuthError(
        message:
            purchasesResult.exception?.graphqlErrors.first.message.toString(),
      );
    }

    final totalPurchaseAmountThisWeek = purchasesResult
        .data?['getPurchasesForWeek']['totalPurchaseAmountThisWeek'];
    final totalPendingPurchaseAmountThisWeek = purchasesResult
        .data?['getPurchasesForWeek']['totalPendingPurchaseAmountThisWeek'];

    var purchasesForTheWeek = PurchasesForWeek(
      totalPurchaseAmountThisWeek: totalPurchaseAmountThisWeek,
      totalPendingPurchaseAmountThisWeek: totalPendingPurchaseAmountThisWeek,
    );

    return purchasesForTheWeek;
  }

  Future<ExpensesForMonth> getExpensesForMonth(
      {required String businessId, bool? monthly = true}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      throw GraphQLAuthError(
        message: "Access token not found",
      );
    }

    final authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );

    final newClient = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
    );

    final QueryOptions options = QueryOptions(
      document: _getExpensesForMonthQuery.document,
      variables: {'businessId': businessId, 'monthly': monthly},
    );

    final QueryResult expensesResult = await newClient.query(options);

    if (expensesResult.hasException) {
      throw GraphQLAuthError(
        message:
            expensesResult.exception?.graphqlErrors.first.message.toString(),
      );
    }

    final totalExpenseAmountThisMonth = expensesResult
        .data?['getExpensesForMonth']['totalExpenseAmountThisMonth'];
    final percentageOfExpenseToInvoiceThisMonth = expensesResult
        .data?['getExpensesForMonth']['percentageOfExpenseToInvoiceThisMonth'];
    final percentageIncreaseInExpenseThisMonth = expensesResult
        .data?['getExpensesForMonth']['percentageIncreaseInExpenseThisMonth'];

    var expensesForTheMonth = ExpensesForMonth(
      totalExpenseAmountThisMonth: totalExpenseAmountThisMonth,
      percentageOfExpenseToInvoiceThisMonth:
          percentageOfExpenseToInvoiceThisMonth,
      percentageIncreaseInExpenseThisMonth:
          percentageIncreaseInExpenseThisMonth,
    );

    return expensesForTheMonth;
  }

  Future<PurchasesForMonth> getPurchasesForMonth(
      {required String businessId, bool? weekly = true}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      throw GraphQLAuthError(
        message: "Access token not found",
      );
    }

    final authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );

    final newClient = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
    );

    final QueryOptions options = QueryOptions(
      document: _getPurchasesForMonthQuery.document,
      variables: {'businessId': businessId, 'weekly': weekly},
    );

    final QueryResult purchasesResult = await newClient.query(options);

    if (purchasesResult.hasException) {
      throw GraphQLAuthError(
        message:
            purchasesResult.exception?.graphqlErrors.first.message.toString(),
      );
    }

    final totalPurchaseAmountThisMonth = purchasesResult
        .data?['getPurchasesForMonth']['totalPurchaseAmountThisMonth'];
    final totalPendingPurchaseAmountThisMonth = purchasesResult
        .data?['getPurchasesForMonth']['totalPendingPurchaseAmountThisMonth'];

    var purchasesForTheMonth = PurchasesForMonth(
      totalPurchaseAmountThisMonth: totalPurchaseAmountThisMonth,
      totalPendingPurchaseAmountThisMonth: totalPendingPurchaseAmountThisMonth,
    );

    return purchasesForTheMonth;
  }

  Future<WeeklyInvoices> totalWeeklyInvoicesAmount(
      {required String businessId, bool? weekly = true}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      throw GraphQLAuthError(
        message: "Access token not found",
      );
    }

    final authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );

    final newClient = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
    );

    final QueryOptions options = QueryOptions(
      document: _totalWeeklyInvoicesAmountQuery.document,
      variables: {'businessId': businessId, 'weekly': weekly},
    );

    final QueryResult expensesResult = await newClient.query(options);

    if (expensesResult.hasException) {
      throw GraphQLAuthError(
        message:
            expensesResult.exception?.graphqlErrors.first.message.toString(),
      );
    }

    final totalInvoiceAmountForWeek = expensesResult
        .data?['totalWeeklyInvoicesAmount']['totalInvoiceAmountForWeek'];
    final percentageOfPaidInvoices = expensesResult
        .data?['totalWeeklyInvoicesAmount']['percentageOfPaidInvoices'];
    final totalPendingInvoiceAmountThisWeek =
        expensesResult.data?['totalWeeklyInvoicesAmount']
            ['totalPendingInvoiceAmountThisWeek'];
    final percentageIncreaseInPendingInvoiceThisWeek =
        expensesResult.data?['totalWeeklyInvoicesAmount']
            ['percentageIncreaseInPendingInvoiceThisWeek'];
    final totalOverDueInvoiceAmountThisWeek =
        expensesResult.data?['totalWeeklyInvoicesAmount']
            ['totalOverDueInvoiceAmountThisWeek'];
    final percentageIncreaseInOverdueInvoicesThisWeek =
        expensesResult.data?['totalWeeklyInvoicesAmount']
            ['percentageIncreaseInOverdueInvoicesThisWeek'];

    var weeklyInvoices = WeeklyInvoices(
      totalInvoiceAmountForWeek: totalInvoiceAmountForWeek,
      percentageOfPaidInvoices: percentageOfPaidInvoices,
      totalPendingInvoiceAmountThisWeek: totalPendingInvoiceAmountThisWeek,
      percentageIncreaseInPendingInvoiceThisWeek:
          percentageIncreaseInPendingInvoiceThisWeek,
      totalOverDueInvoiceAmountThisWeek: totalOverDueInvoiceAmountThisWeek,
      percentageIncreaseInOverdueInvoicesThisWeek:
          percentageIncreaseInOverdueInvoicesThisWeek,
    );

    return weeklyInvoices;
  }

  Future<MonthlyInvoices> totalMonthlyInvoicesAmount(
      {required String businessId, bool? monthly = true}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      throw GraphQLAuthError(
        message: "Access token not found",
      );
    }

    final authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );

    final newClient = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
    );

    final QueryOptions options = QueryOptions(
      document: _totalMonthlyInvoicesAmountQuery.document,
      variables: {'businessId': businessId, 'monthly': monthly},
    );

    final QueryResult expensesResult = await newClient.query(options);

    if (expensesResult.hasException) {
      throw GraphQLAuthError(
        message:
            expensesResult.exception?.graphqlErrors.first.message.toString(),
      );
    }

    final totalInvoiceAmountForMonth = expensesResult
        .data?['totalMonthlyInvoicesAmount']['totalInvoiceAmountForMonth'];
    final percentageOfPaidInvoicesForMonth =
        expensesResult.data?['totalMonthlyInvoicesAmount']
            ['percentageOfPaidInvoicesForMonth'];
    final totalPendingInvoiceAmountThisMonth =
        expensesResult.data?['totalMonthlyInvoicesAmount']
            ['totalPendingInvoiceAmountThisMonth'];
    final percentageIncreaseInPendingInvoiceThisMonth =
        expensesResult.data?['totalMonthlyInvoicesAmount']
            ['percentageIncreaseInPendingInvoiceThisMonth'];
    final totalOverDueInvoiceAmountThisMonth =
        expensesResult.data?['totalMonthlyInvoicesAmount']
            ['totalOverdueInvoiceAmountThisMonth'];
    final percentageIncreaseInOverdueInvoicesThisMonth =
        expensesResult.data?['totalMonthlyInvoicesAmount']
            ['percentageIncreaseInOverdueInvoicesThisMonth'];

    var monthlyInvoices = MonthlyInvoices(
      totalInvoiceAmountForMonth: totalInvoiceAmountForMonth,
      percentageOfPaidInvoicesForMonth: percentageOfPaidInvoicesForMonth,
      totalPendingInvoiceAmountThisMonth: totalPendingInvoiceAmountThisMonth,
      percentageIncreaseInPendingInvoiceThisMonth:
          percentageIncreaseInPendingInvoiceThisMonth,
      totalOverDueInvoiceAmountThisMonth: totalOverDueInvoiceAmountThisMonth,
      percentageIncreaseInOverdueInvoicesThisMonth:
          percentageIncreaseInOverdueInvoicesThisMonth,
    );

    return monthlyInvoices;
  }
}

class WeeklyInvoices {
  WeeklyInvoices({
    required this.totalInvoiceAmountForWeek,
    required this.percentageOfPaidInvoices,
    required this.totalPendingInvoiceAmountThisWeek,
    required this.percentageIncreaseInPendingInvoiceThisWeek,
    required this.totalOverDueInvoiceAmountThisWeek,
    required this.percentageIncreaseInOverdueInvoicesThisWeek,
  });

  final num totalInvoiceAmountForWeek;
  final num percentageOfPaidInvoices;
  final num totalPendingInvoiceAmountThisWeek;
  final num percentageIncreaseInPendingInvoiceThisWeek;
  final num totalOverDueInvoiceAmountThisWeek;
  final num percentageIncreaseInOverdueInvoicesThisWeek;
}

class MonthlyInvoices {
  MonthlyInvoices({
    required this.totalInvoiceAmountForMonth,
    required this.percentageOfPaidInvoicesForMonth,
    required this.totalPendingInvoiceAmountThisMonth,
    required this.percentageIncreaseInPendingInvoiceThisMonth,
    required this.totalOverDueInvoiceAmountThisMonth,
    required this.percentageIncreaseInOverdueInvoicesThisMonth,
  });

  final num totalInvoiceAmountForMonth;
  final num percentageOfPaidInvoicesForMonth;
  final num totalPendingInvoiceAmountThisMonth;
  final num percentageIncreaseInPendingInvoiceThisMonth;
  final num totalOverDueInvoiceAmountThisMonth;
  final num percentageIncreaseInOverdueInvoicesThisMonth;
}

class ExpensesForMonth {
  ExpensesForMonth({
    required this.totalExpenseAmountThisMonth,
    required this.percentageOfExpenseToInvoiceThisMonth,
    required this.percentageIncreaseInExpenseThisMonth,
  });

  final num totalExpenseAmountThisMonth;
  final num percentageOfExpenseToInvoiceThisMonth;
  final num percentageIncreaseInExpenseThisMonth;
}

class ExpensesForWeek {
  final num totalExpenseAmountThisWeek;
  final num percentageOfExpenseToInvoiceThisWeek;
  final num percentageIncreaseInExpenseThisWeek;

  ExpensesForWeek(
      {required this.totalExpenseAmountThisWeek,
      required this.percentageOfExpenseToInvoiceThisWeek,
      required this.percentageIncreaseInExpenseThisWeek});
}

class PurchasesForWeek {
  final num totalPurchaseAmountThisWeek;
  final num totalPendingPurchaseAmountThisWeek;

  PurchasesForWeek({
    required this.totalPurchaseAmountThisWeek,
    required this.totalPendingPurchaseAmountThisWeek,
  });
}

class PurchasesForMonth {
  final num totalPurchaseAmountThisMonth;
  final num totalPendingPurchaseAmountThisMonth;

  PurchasesForMonth({
    required this.totalPurchaseAmountThisMonth,
    required this.totalPendingPurchaseAmountThisMonth,
  });
}

class BusinessIdResult {
  late final BusinessIdSuccessResult? businessId;
  late final GraphQLAuthError? error;

  BusinessIdResult({this.businessId}) : error = null;
  BusinessIdResult.error({this.error}) : businessId = null;

  bool get hasError => error != null;
}

class BusinessIdSuccessResult {
  BusinessIdSuccessResult({
    this.result_businessId,
    this.result_businessName,
    this.result_businessEmail,
    this.result_businessMobile,
  });

  late final String? result_businessId;
  late final String? result_businessName;
  late final String? result_businessEmail;
  late final String? result_businessMobile;
}

class GraphQLAuthError {
  final String? message;

  GraphQLAuthError({required this.message});
}
