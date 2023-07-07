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
  final QueryOptions _getExpenseByIdQuery;
  final MutationOptions _updateExpenseMutation;
  final MutationOptions _archiveExpenseMutation;
  final QueryOptions _getExpenseByBusinessMobileQuery;

//Expensecategory
// final MutationOptions _createExpenseCategoryMutation;
  final QueryOptions _getExpenseCategoryWithSetsQuery;

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
            expenseCategoryId
            merchantId
            recurring
          }
        }
      '''),
        ),
        _getExpenseByIdQuery = QueryOptions(
          document: gql('''
        query GetExpenseById(\$expenseId: String!){
          getExpenseById(expenseId: \$expenseId){
            id
            amount
            description
            expenseDate
            merchant{
              name
            }
            merchantId
            expenseCategory{
              name
            }
            expenseCategoryId
            }
          }
        '''),
        ),
        _updateExpenseMutation = MutationOptions(
          document: gql('''
            mutation UpdateExpense(\$expenseId: String!, \$input: UpdateExpense) {
              updateExpense(expenseId: \$expenseId, input: \$input) {
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
        query GetExpenseByBusinessMobile(\$businessId: String!,\$cursor: String, \$take: Float ) {
          getExpenseByBusinessMobile(businessId: \$businessId, cursor: \$cursor, take: \$take) {
            expenseByBusiness{
            id
            description
            amount
            expenseDate
            expenseCategory{
              name
            }
            expenseCategoryId
            merchantId
            merchant{
              name
            }
            }
            cursorId
            }
          }
        '''),
        ),
        _archiveExpenseMutation = MutationOptions(
          document: gql('''
        mutation ArchiveExpense(\$expenseId: String!) {
          archiveExpense(expenseId: \$expenseId)
        }
      '''),
        ),
        // _createExpenseCategoryMutation = MutationOptions(
        //   document: gql('''
        // mutation CreateExpenseCategory(\$input: CreateExpenseCategory!) {
        //   createExpenseCategory(input:\$input) {
        //     id
        //     name
        //     businessId
        //   }
        //  }
        // '''),
        // ),
        _getExpenseCategoryWithSetsQuery = QueryOptions(
          document: gql('''
        query GetExpenseCategoryWithSets{
          getExpenseCategoryWithSets{
            expenseCategories{
            id
            name
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
      bool? reccuring,
      required String expenseDate}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

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
          'expenseDate': expenseDate,
          'recurring': reccuring
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

    var resultexpense_id = result.data?['createExpense']['id'];
    var result_description = result.data?['createExpense']['description'];
    var result_amount = result.data?['createExpense']['amount'];
    var result_expenseDate = result.data?['createExpense']['expenseDate'];
    // var result_expenseCategoryId =
    //     result.data?['createExpense']['expenseCategoryId'];
    // var result_merchantId = result.data?['createExpense']['merchantId'];
    // var result_recurring = result.data?['createExpense']['recurring'];

    var expense = ExpenseCreationSuccessResult(
        result_id: resultexpense_id,
        result_amount: result_amount,
        result_description: result_description,
        result_expenseDate: result_expenseDate);

    return ExpenseCreationResult(expense: expense);
  }

  Future<Expenses> getExpenseById({required String expenseId}) async {
    final QueryOptions options = QueryOptions(
      document: _getExpenseByIdQuery.document,
      variables: {'expenseId': expenseId},
    );

    final QueryResult expenseByIdResult = await client.value.query(options);

    if (expenseByIdResult.hasException) {
      throw GraphQLExpenseError(
        message:
            expenseByIdResult.exception?.graphqlErrors.first.message.toString(),
      );
    }

    final expenseByIdData = expenseByIdResult.data?['getExpenseById'] ?? [];

    final Expenses expenseById = Expenses(
        id: expenseByIdData['id'],
        description: expenseByIdData['description'],
        expenseCategoryId: expenseByIdData['expenseCategoryId'],
        expenseCategoryName: expenseByIdData['expenseCategory']['name'],
        expenseDate: expenseByIdData['expenseDate'],
        merchantId: expenseByIdData['merchantId'],
        // merchantName: expenseByIdData['merchant']['name'],
        amount: expenseByIdData['amount']);

    return expenseById;
  }

  Future<ExpenseUpdateResult> updateExpenses(
      {required String expenseId,
      double? amount,
      String? description,
      String? expenseCategoryId,
      String? merchantId,
      String? expenseDate,
      bool? reccuring}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      return ExpenseUpdateResult.error(
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
      document: _updateExpenseMutation.document,
      variables: {
        'expenseId': expenseId,
        'input': {
          'amount': amount,
          'description': description,
          'expenseCategoryId': expenseCategoryId,
          'expenseDate': expenseDate,
          'merchantId': merchantId,
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      return ExpenseUpdateResult.error(
        error: GraphQLExpenseError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    if (result.data == null || result.data!['updateExpense'] == null) {
      return ExpenseUpdateResult.error(
        error: GraphQLExpenseError(
          message: "Error parsing response data",
        ),
      );
    }

    var resultexpense_id = result.data?['updateExpense']['id'];
    var result_description = result.data?['updateExpense']['description'];
    var result_amount = result.data?['updateExpense']['amount'];

    var expense = ExpenseUpdateSuccessResult(
      result_id: resultexpense_id,
      result_amount: result_amount,
      result_description: result_description,
    );

    return ExpenseUpdateResult(expense: expense);
  }

  Future<List<Expenses>> getExpenseByBusiness(
      {required String businessId, num? take, String? cursor}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLExpenseError(
        message: "Access token not found",
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
    final QueryOptions options = QueryOptions(
      document: _getExpenseByBusinessMobileQuery.document,
      variables: {'businessId': businessId, 'take': take, 'cursor': cursor},
    );

    final QueryResult expenseByBusinessResult = await newClient.query(options);

    if (expenseByBusinessResult.hasException) {
      throw GraphQLExpenseError(
        message: expenseByBusinessResult.exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List expensesData = expenseByBusinessResult
            .data?['getExpenseByBusinessMobile']['expenseByBusiness'] ??
        [];

    final String cursorId = expenseByBusinessResult
            .data?['getExpenseByBusinessMobile']['cursorId'] ??
        '';

    // prefs.setString('cursorId', cursorId);

    final List<Expenses> expenses = expensesData.map((data) {
      return Expenses(
          id: data['id'],
          description: data['description'],
          amount: data['amount'],
          expenseDate: data['expenseDate'],
          merchantId: data['merchantId'],
          // merchantName: data['merchant']['name'] ?? 'Unknown Merchant',
          expenseCategoryName: data['expenseCategory']['name'],
          expenseCategoryId: data['expenseCategoryId'],
          recurring: data['recurring']);
    }).toList();

    return expenses;
  }

  Future<bool> archiveExpense({required String expenseId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLExpenseError(
        message: "Access token not found",
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
      document: _archiveExpenseMutation.document,
      variables: {
        'expenseId': expenseId,
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    bool isArchived = result.data?['archiveExpense'] ?? false;

    return isArchived;
  }

// ExpenseCategory
//   Future<ExpenseCategoryCreationResult> createExpenseCategory(
//       {required String name, required String businessId}) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('access_token');
//     final businessId = prefs.getString('id');

//     if (token == null) {
//       return ExpenseCategoryCreationResult.error(
//         error: GraphQLExpenseError(
//           message: "Access token not found",
//         ),
//       );
//     }

//     // Use the token to create an authlink
//     final authLink = AuthLink(
//       getToken: () => 'Bearer $token',
//     );

//     // Create a new GraphQLClient with the authlink
//     final newClient = GraphQLClient(
//       cache: GraphQLCache(),
//       link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
//     );

//     final MutationOptions options = MutationOptions(
//       document: _createExpenseCategoryMutation.document,
//       variables: {
//         'input': {
//           'name': name,
//           'businessId': businessId,
//         },
//       },
//     );

//     final QueryResult result = await newClient.mutate(options);

//     var expenseCategory_id = result.data?['createExpenseCategory']['id'];
//     var expenseCategory_name = result.data?['createExpenseCategory']['name'];
//     var expenseCategory_businessId =
//         result.data?['createExpenseCategory']['businessId'];

//     if (result.hasException) {
//       return ExpenseCategoryCreationResult.error(
//         error: GraphQLExpenseError(
//           message: result.exception?.graphqlErrors.first.message.toString(),
//         ),
//       );
//     }

//     if (result.data == null || result.data!['createExpenseCategory'] == null) {
//       return ExpenseCategoryCreationResult.error(
//         error: GraphQLExpenseError(
//           message: "Error parsing response data",
//         ),
//       );
//     }

//     var expenseCategory = ExpenseCategoryCreationSuccessResult(
//         id: expenseCategory_id,
//         name: expenseCategory_name,
//         businessId: expenseCategory_businessId);

//     return ExpenseCategoryCreationResult(expenseCategory: expenseCategory);
//   }

  Future<List<ExpenseCategory>> getExpenseCategoryWithSets() async {
    final QueryOptions options = QueryOptions(
      document: _getExpenseCategoryWithSetsQuery.document,
    );

    final QueryResult expenseCategoryWithSetsResult =
        await client.value.query(options);

    if (expenseCategoryWithSetsResult.hasException) {
      throw GraphQLExpenseError(
        message: expenseCategoryWithSetsResult
            .exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List expenseCategoriesData = expenseCategoryWithSetsResult
            .data?['getExpenseCategoryWithSets']['expenseCategories'] ??
        [];

    final List<ExpenseCategory> expenseCategories =
        expenseCategoriesData.map((data) {
      return ExpenseCategory(id: data['id'], name: data['name']);
    }).toList();

    return expenseCategories;
  }
}

class ExpenseCategory {
  final String id;
  final String name;

  ExpenseCategory({required this.id, required this.name});
}

// class ExpenseCategoryCreationResult {
//   late final ExpenseCategoryCreationSuccessResult? expenseCategory;
//   late final GraphQLExpenseError? error;

//   ExpenseCategoryCreationResult({this.expenseCategory}) : error = null;
//   ExpenseCategoryCreationResult.error({this.error}) : expenseCategory = null;

//   bool get hasError => error != null;
// }

// class ExpenseCategoryCreationSuccessResult {
//   final String id;
//   final String name;
//   final String businessId;

//   ExpenseCategoryCreationSuccessResult(
//       {required this.id, required this.name, required this.businessId});
// }

class ExpenseUpdateResult {
  late final ExpenseUpdateSuccessResult? expense;
  late final GraphQLExpenseError? error;

  ExpenseUpdateResult({this.expense}) : error = null;
  ExpenseUpdateResult.error({this.error}) : expense = null;

  bool get hasError => error != null;
}

class ExpenseUpdateSuccessResult {
  ExpenseUpdateSuccessResult({
    required this.result_id,
    required this.result_description,
    required this.result_amount,
  });

  late final String result_id;
  late final String result_description;
  late final num result_amount;
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
  final String expenseCategoryId;
  final String expenseCategoryName;
  String? merchantId;
  String? merchantName;
  bool? recurring;

  Expenses(
      {required this.id,
      required this.description,
      required this.amount,
      required this.expenseDate,
      required this.expenseCategoryId,
      required this.expenseCategoryName,
      this.merchantId,
      this.merchantName,
      this.recurring});
}
