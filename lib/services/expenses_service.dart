import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ExpenseService {
  ValueNotifier<GraphQLClient> client;

//Expense
  final MutationOptions _createExpenseMutation;
  final QueryOptions _getExpenseByBusinessMobileQuery;

//Expensecategory
  final MutationOptions _createExpenseCategoryMutation;
  final QueryOptions _getExpenseCategoryByBusinessQuery;

  ExpenseService()
      : client = ValueNotifier(GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink('https://api.verzo.app/graphql'),
        )),
        _createExpenseMutation = MutationOptions(
          document: gql('''
        mutation CreateExpense(\$input: CreateExpense!) {
          createExpense(input: \$input) {
            id
            amount
            description
            expenseDate
          }
        }
      '''),
        ),
        _getExpenseByBusinessMobileQuery = QueryOptions(
          document: gql('''
        query GetExpenseByBusinessMobile(\$businessId: String!, \$take: Float, \$cursor: String) {
          getExpenseByBusinessMobile(businessId: \$businessId, take: \$take, cursor: \$cursor) {
            expenseByBusiness{
            id
            description
            amount
            createdAt
            }
            }
          }
        '''),
        ),
        _createExpenseCategoryMutation = MutationOptions(
          document: gql('''
        mutation CreateExpenseCategory(\$input: CreateExpenseCategory!) {
          createExpenseCategory(input:\$input) {
            id
            name
            businessId
          }
         }
        '''),
        ),
        _getExpenseCategoryByBusinessQuery = QueryOptions(
          document: gql('''
        query GetExpenseCategoryByBusiness(\$input: String!) {
          getExpenseCategoryByBusiness(businessId: \$input) {
            expenseCategoryByBusiness{
            id
            name
            businessId
            }
            }
          }
        '''),
        );

//Expense

  Future<ExpenseCreationResult> createExpenses(
      {required double amount,
      required String description,
      required String expenseCategoryId,
      required String businessId,
      String? merchantId,
      required String expenseDate}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('id');

    if (token == null) {
      return ExpenseCreationResult.error(
        error: GraphQLExpenseError(
          message: "Access token not found",
        ),
      );
    }
// Use the token to create an authlink
    final authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );

    // Create a new GraphQLClient with the authlink
    final newClient = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
    );

    final MutationOptions options = MutationOptions(
      document: _createExpenseMutation.document,
      variables: {
        'input': {
          'amount': amount,
          'description': description,
          'expenseCategoryId': expenseCategoryId,
          'businessId': businessId,
          'merchantId': merchantId,
          'expenseDate': expenseDate
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      return ExpenseCreationResult.error(
        error: GraphQLExpenseError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    if (result.data == null || result.data!['createExpense'] == null) {
      return ExpenseCreationResult.error(
        error: GraphQLExpenseError(
          message: "Error parsing response data",
        ),
      );
    }

    var result_id = result.data?['createExpense']['id'];
    var result_description = result.data?['createExpense']['description'];
    var result_amount = result.data?['createExpense']['amount'];
    var result_expenseDate = result.data?['createExpense']['expenseDate'];

    var expense = ExpenseCreationSuccessResult(
        result_id: result_id,
        result_amount: result_amount,
        result_description: result_description,
        result_expenseDate: result_expenseDate);

    return ExpenseCreationResult(expense: expense);
  }

  Future<List<Expenses>> getExpenseByBusiness(
      {required String businessId, double? take, String? cursor}) async {
    final QueryOptions options = QueryOptions(
      document: _getExpenseByBusinessMobileQuery.document,
      variables: {'businessId': businessId, 'take': take, 'cursor': cursor},
    );

    final QueryResult expenseByBusinessResult =
        await client.value.query(options);

    if (expenseByBusinessResult.hasException) {
      throw GraphQLExpenseError(
        message: expenseByBusinessResult.exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List expensesData = expenseByBusinessResult
            .data?['getExpenseByBusiness']['expenseByBusiness'] ??
        [];

    final List<Expenses> expenses = expensesData.map((data) {
      return Expenses(
        id: data['id'],
        description: data['description'],
        amount: data['amount'],
        expenseDate: data['expenseDate'],
      );
    }).toList();

    return expenses;
  }

//ExpenseCategory
  Future<ExpenseCategoryCreationResult> createExpenseCategory(
      {required String name, required String businessId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('id');

    if (token == null) {
      return ExpenseCategoryCreationResult.error(
        error: GraphQLExpenseError(
          message: "Access token not found",
        ),
      );
    }

    // Use the token to create an authlink
    final authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );

    // Create a new GraphQLClient with the authlink
    final newClient = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
    );

    final MutationOptions options = MutationOptions(
      document: _createExpenseCategoryMutation.document,
      variables: {
        'input': {
          'name': name,
          'businessId': businessId,
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    var expenseCategory_id = result.data?['createExpenseCategory']['id'];
    var expenseCategory_name = result.data?['createExpenseCategory']['name'];
    var expenseCategory_businessId =
        result.data?['createExpenseCategory']['businessId'];

    if (result.hasException) {
      return ExpenseCategoryCreationResult.error(
        error: GraphQLExpenseError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    if (result.data == null || result.data!['createExpenseCategory'] == null) {
      return ExpenseCategoryCreationResult.error(
        error: GraphQLExpenseError(
          message: "Error parsing response data",
        ),
      );
    }

    var expenseCategory = ExpenseCategoryCreationSuccessResult(
        id: expenseCategory_id,
        name: expenseCategory_name,
        businessId: expenseCategory_businessId);

    return ExpenseCategoryCreationResult(expenseCategory: expenseCategory);
  }

  Future<List<ExpenseCategory>> getExpenseCategoryByBusiness(
      {required String businessId}) async {
    final QueryOptions options = QueryOptions(
      document: _getExpenseCategoryByBusinessQuery.document,
      variables: {'input': businessId},
    );

    final QueryResult expenseCategoryByBusinessResult =
        await client.value.query(options);

    if (expenseCategoryByBusinessResult.hasException) {
      throw GraphQLExpenseError(
        message: expenseCategoryByBusinessResult
            .exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List expenseCategoriesData =
        expenseCategoryByBusinessResult.data?['getExpenseCategoryByBusiness']
                ['expenseCategoryByBusiness'] ??
            [];

    final List<ExpenseCategory> expenseCategories =
        expenseCategoriesData.map((data) {
      return ExpenseCategory(
          id: data['id'], name: data['name'], businessId: data['businessId']);
    }).toList();

    return expenseCategories;
  }
}

class ExpenseCategory {
  final String id;
  final String name;
  final String businessId;

  ExpenseCategory(
      {required this.id, required this.name, required this.businessId});
}

class ExpenseCategoryCreationResult {
  late final ExpenseCategoryCreationSuccessResult? expenseCategory;
  late final GraphQLExpenseError? error;

  ExpenseCategoryCreationResult({this.expenseCategory}) : error = null;
  ExpenseCategoryCreationResult.error({this.error}) : expenseCategory = null;

  bool get hasError => error != null;
}

class ExpenseCategoryCreationSuccessResult {
  final String id;
  final String name;
  final String businessId;

  ExpenseCategoryCreationSuccessResult(
      {required this.id, required this.name, required this.businessId});
}

class ExpenseCreationResult {
  late final ExpenseCreationSuccessResult? expense;
  late final GraphQLExpenseError? error;

  ExpenseCreationResult({this.expense}) : error = null;
  ExpenseCreationResult.error({this.error}) : expense = null;

  bool get hasError => error != null;
}

class ExpenseCreationSuccessResult {
  ExpenseCreationSuccessResult(
      {required this.result_id,
      required this.result_description,
      required this.result_amount,
      required this.result_expenseDate});

  late final String result_id;
  late final String result_description;
  late final num result_amount;
  late final String result_expenseDate;
}

class GraphQLExpenseError {
  final String? message;

  GraphQLExpenseError({required this.message});
}

class Expenses {
  final String id;
  final String description;
  final num amount;
  final String expenseDate;

  Expenses(
      {required this.id,
      required this.description,
      required this.amount,
      required this.expenseDate});
}
