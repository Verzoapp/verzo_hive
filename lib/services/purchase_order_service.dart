import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PurchaseService {
  ValueNotifier<GraphQLClient> client;

//Expense
  final MutationOptions _createPurchaseEntryMutation;
  // final QueryOptions _getExpenseByIdQuery;
  final MutationOptions _updatePurchaseEntryMutation;
  final MutationOptions _archivePurchaseMutation;
  final MutationOptions _deletePurchaseMutation;
  final MutationOptions _markPurchaseItemAsReceivedMutation;
  final MutationOptions _makePurchasePaymentMutation;
  final MutationOptions _uploadMerchantInvoiceToPurchaseMutation;
  final MutationOptions _sendPurchaseMutation;
  final QueryOptions _getPurchaseByBusinessQuery;

  // final QueryOptions _getProductByBusinessQuery;

//Expensecategory
// final MutationOptions _createExpenseCategoryMutation;
  final QueryOptions _getExpenseCategoryWithSetsQuery;

  PurchaseService()
      : client = ValueNotifier(GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink('https://api.verzo.app/graphql'),
        )),
        _createPurchaseEntryMutation = MutationOptions(
          document: gql('''
        mutation CreatePurchaseEntry(\$input: CreatePurchase!) {
          createPurchaseEntry(input: \$input) {
            id
            description
            transactionDate
          }
        }
      '''),
        ),
        // _getExpenseByIdQuery = QueryOptions(
        //   document: gql('''
        // query GetExpenseById(\$expenseId: String!){
        //   getExpenseById(expenseId: \$expenseId){
        //     id
        //     amount
        //     description
        //     expenseDate
        //     merchant{
        //       name
        //     }
        //     merchantId
        //     expenseCategory{
        //       name
        //     }
        //     expenseCategoryId
        //     }
        //   }
        // '''),
        // ),
        _updatePurchaseEntryMutation = MutationOptions(
          document: gql('''
            mutation UpdatePurchaseEntry(\$purchaseId: String!, \$input: UpdatePurchase!) {
              updatePurchaseEntry(purchaseId: \$purchaseId, input: \$input) {
                id
                total
                description
               merchantId
              }
            }
          '''),
        ),
        _markPurchaseItemAsReceivedMutation = MutationOptions(
          document: gql('''
            mutation MarkPurchaseItemAsReceived(\$purchaseItemId: String!, \$input: PurchaseItemReceived!) {
              markPurchaseItemAsReceived(purchaseItemId: \$purchaseItemId, input: \$input)
              }
          '''),
        ),
        _makePurchasePaymentMutation = MutationOptions(
          document: gql('''
        mutation MakePurchasePayment(\$input: PurchasePaymentEntry!) {
          makePurchasePayment(input: \$input)
        }
      '''),
        ),
        _uploadMerchantInvoiceToPurchaseMutation = MutationOptions(
          document: gql('''
        mutation UploadMerchantInvoiceToPurchase(\$input: UploadMerchantInvoiceToPurchase!) {
          uploadMerchantInvoiceToPurchase(input: \$input)
        }
      '''),
        ),
        _sendPurchaseMutation = MutationOptions(
          document: gql('''
        mutation SendPurchase(\$purchaseId: String!, \$copy: Boolean) {
          sendPurchase(purchaseId: \$purchaseId, copy: \$copy)
        }
      '''),
        ),
        _getPurchaseByBusinessQuery = QueryOptions(
          document: gql('''
        query GetPurchaseByBusinessMobile(\$businessId: String!) {
          getPurchaseByBusinessMobile(businessId: \$businessId) {
            purchaseByBusiness{
            id
           transactionDate
           description
           reference
           total
           purchaseStatusId
           paid
           merchantId
           merchant{
            name
            email
           }
           purchaseItems{
        id
        productId
        index
        description
        quantity
        unitPrice 
        quantityReceived
        product{
          id
        }
      }
            }
            }
          }
        '''),
        ),
        _archivePurchaseMutation = MutationOptions(
          document: gql('''
        mutation ArchivePurchase(\$purchaseId: String!) {
          archivePurchase(purchaseId: \$purchaseId)
        }
      '''),
        ),
        _deletePurchaseMutation = MutationOptions(
          document: gql('''
        mutation DeletePurchase(\$purchaseId: String!) {
          deletePurchase(purchaseId: \$purchaseId)
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
        // _getProductByBusinessQuery = QueryOptions(
        //   document: gql('''
        // query GetProductByBusiness(\$businessId: String!) {
        //   getProductByBusiness(businessId: \$businessId) {
        //     productByBusiness{
        //     id
        //     productName
        //     }
        //     cursorId
        //     }
        //   }
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

  Future<PurchaseCreationResult> createPurchaseEntry(
      {required List<PurchaseItemDetail> purchaseItems,
      required String description,
      required String businessId,
      String? reference,
      required String merchantId,
      // bool? reccuring,
      required String transactionDate}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      return PurchaseCreationResult.error(
        error: GraphQLPurchaseError(
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
      document: _createPurchaseEntryMutation.document,
      variables: {
        'input': {
          'description': description,
          'businessId': businessId,
          'merchantId': merchantId,
          'transactionDate': transactionDate,
          'reference': reference,
          'purchaseItem': purchaseItems
              .map((purchaseItemDetail) => {
                    'productId': purchaseItemDetail.productId,
                    'itemDescription': purchaseItemDetail.itemDescription,
                    'unitPrice': purchaseItemDetail.unitPrice,
                    'quantity': purchaseItemDetail.quantity,
                    'index': purchaseItemDetail.index,
                  })
              .toList(),
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      return PurchaseCreationResult.error(
        error: GraphQLPurchaseError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    if (result.data == null || result.data!['createPurchaseEntry'] == null) {
      return PurchaseCreationResult.error(
        error: GraphQLPurchaseError(
          message: "Error parsing response data",
        ),
      );
    }

    var resultpurchase_id = result.data?['createPurchaseEntry']['id'];
    var result_description = result.data?['createPurchaseEntry']['description'];
    var result_transactionDate =
        result.data?['createPurchaseEntry']['transactionDate'];
    // var result_expenseCategoryId =
    //     result.data?['createExpense']['expenseCategoryId'];
    // var result_merchantId = result.data?['createExpense']['merchantId'];
    // var result_recurring = result.data?['createExpense']['recurring'];

    var purchase = PurchaseCreationSuccessResult(
        result_id: resultpurchase_id,
        result_description: result_description,
        result_transactionDate: result_transactionDate);

    return PurchaseCreationResult(purchase: purchase);
  }

  // Future<Expenses> getExpenseById({required String expenseId}) async {
  //   final QueryOptions options = QueryOptions(
  //     document: _getExpenseByIdQuery.document,
  //     variables: {'expenseId': expenseId},
  //   );

  //   final QueryResult expenseByIdResult = await client.value.query(options);

  //   if (expenseByIdResult.hasException) {
  //     throw GraphQLExpenseError(
  //       message:
  //           expenseByIdResult.exception?.graphqlErrors.first.message.toString(),
  //     );
  //   }

  //   final expenseByIdData = expenseByIdResult.data?['getExpenseById'] ?? [];

  //   final Expenses expenseById = Expenses(
  //       id: expenseByIdData['id'],
  //       description: expenseByIdData['description'],
  //       expenseCategoryId: expenseByIdData['expenseCategoryId'],
  //       expenseCategoryName: expenseByIdData['expenseCategory']['name'],
  //       expenseDate: expenseByIdData['expenseDate'],
  //       merchantId: expenseByIdData['merchantId'],
  //       // merchantName: expenseByIdData['merchant']['name'],
  //       amount: expenseByIdData['amount']);

  //   return expenseById;
  // }

  Future<bool> archivePurchase({required String purchaseId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLPurchaseError(
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
      document: _archivePurchaseMutation.document,
      variables: {
        'purchaseId': purchaseId,
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    bool isArchived = result.data?['archivePurchase'] ?? false;

    return isArchived;
  }

  Future<bool> deletePurchase({required String purchaseId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLPurchaseError(
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
      document: _deletePurchaseMutation.document,
      variables: {
        'purchaseId': purchaseId,
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    bool isDeleted = result.data?['deletePurchase'] ?? false;

    return isDeleted;
  }

  Future<bool> makePurchasePayment(
      {required String purchaseId,
      required String businessId,
      required String transactionDate,
      required String description,
      required num total,
      String? reference,
      String? file}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      throw GraphQLPurchaseError(
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
      document: _makePurchasePaymentMutation.document,
      variables: {
        'input': {
          'purchaseId': purchaseId,
          'businessId': businessId,
          'transactionDate': transactionDate,
          'description': description,
          'total': total,
          'reference': reference,
          'file': file
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    bool isPaid = result.data?['makePurchasePayment'];

    return isPaid;
  }

  Future<bool> uploadMerchantInvoiceToPurchase({
    required String purchaseId,
    required String businessId,
    required String invoiceDate,
    required bool match,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      throw GraphQLPurchaseError(
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
      document: _uploadMerchantInvoiceToPurchaseMutation.document,
      variables: {
        'input': {
          'purchaseId': purchaseId,
          'businessId': businessId,
          'invoiceDate': invoiceDate,
          'match': match,
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    bool isuploaded = result.data?['uploadMerchantInvoiceToPurchase'];

    return isuploaded;
  }

  Future<bool> markPurchaseItemAsReceived(
      {required String purchaseItemId,
      required String businessId,
      required String transactionDate,
      required num quantityRecieved}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLPurchaseError(
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
      document: _markPurchaseItemAsReceivedMutation.document,
      variables: {
        'purchaseItemId': purchaseItemId,
        'input': {
          'businessId': businessId,
          'quantity': quantityRecieved,
          'transactionDate': transactionDate,
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    bool isRecieved = result.data?['markPurchaseItemAsReceived'] ?? false;

    return isRecieved;
  }

  Future<bool> sendPurchase({
    required String purchaseId,
    bool? copy,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      throw GraphQLPurchaseError(
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
      document: _sendPurchaseMutation.document,
      variables: {
        'purchaseId': purchaseId,
        'copy': copy,
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    bool isSent = result.data?['sendPurchase'];

    return isSent;
  }

  Future<PurchaseUpdateResult> updatePurchases({
    required String purchaseId,
    String? description,
    String? reference,
    String? merchantId,
    String? transactionDate,
    List<PurchaseItemDetail>? purchaseItems,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      return PurchaseUpdateResult.error(
        error: GraphQLPurchaseError(
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
      document: _updatePurchaseEntryMutation.document,
      variables: {
        'purchaseId': purchaseId,
        'input': {
          'reference': reference,
          'description': description,
          'transactionDate': transactionDate,
          'merchantId': merchantId,
          'purchaseItem': purchaseItems
              ?.map((purchaseItemDetail) => {
                    'productId': purchaseItemDetail.productId,
                    'itemDescription': purchaseItemDetail.itemDescription,
                    'unitPrice': purchaseItemDetail.unitPrice,
                    'quantity': purchaseItemDetail.quantity,
                    'index': purchaseItemDetail.index,
                  })
              .toList(),
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      return PurchaseUpdateResult.error(
        error: GraphQLPurchaseError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    if (result.data == null || result.data!['updatePurchaseEntry'] == null) {
      return PurchaseUpdateResult.error(
        error: GraphQLPurchaseError(
          message: "Error parsing response data",
        ),
      );
    }

    var resultpurchase_id = result.data?['updatePurchaseEntry']['id'];
    var result_description = result.data?['updatePurchaseEntry']['description'];

    var purchase = PurchaseUpdateSuccessResult(
      result_id: resultpurchase_id,
      result_description: result_description,
    );

    return PurchaseUpdateResult(purchase: purchase);
  }

  Future<List<Purchases>> getPurchaseByBusiness(
      {required String businessId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLPurchaseError(
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
      document: _getPurchaseByBusinessQuery.document,
      variables: {'businessId': businessId},
    );

    final QueryResult purchaseByBusinessResult = await newClient.query(options);

    // if (purchaseByBusinessResult.hasException) {
    //   throw GraphQLPurchaseError(
    //     message: purchaseByBusinessResult.exception?.graphqlErrors.first.message
    //         .toString(),
    //   );
    // }

    final List purchaseData = purchaseByBusinessResult
            .data?['getPurchaseByBusinessMobile']['purchaseByBusiness'] ??
        [];

    final List<Purchases> purchases = purchaseData.map((data) {
      final List<dynamic> purchaseItemsData = data['purchaseItems'] ?? [];

      final List<PurchaseItemDetail> purchaseItems =
          purchaseItemsData.map((itemData) {
        return PurchaseItemDetail(
            id: itemData['id'],
            productId: itemData['product']['id'],
            itemDescription: itemData['description'],
            index: itemData['index'],
            unitPrice: itemData['unitPrice'],
            quantity: itemData['quantity'],
            quantityRecieved: itemData['quantityReceived']);
      }).toList();
      return Purchases(
          id: data['id'],
          description: data['description'],
          transactionDate: data['transactionDate'],
          reference: data['reference'],
          merchantId: data['merchantId'],
          merchantName: data['merchant']['name'],
          // merchantName:
          //     data['merchant'] != null ? data['merchant']['name'] : null,
          merchantEmail: data['merchant']['email'],
          purchaseItems: purchaseItems,
          total: data['total'],
          purchaseStatusId: data['purchaseStatusId'],
          paid: data['paid']);
    }).toList();

    return purchases;
  }
}

class Purchases {
  final String id;
  String transactionDate;
  final String description;
  final String? reference;
  final String merchantId;
  final String merchantName;
  final String merchantEmail;
  bool? paid;
  final num total;
  final List<PurchaseItemDetail> purchaseItems;
  num purchaseStatusId;

  Purchases(
      {required this.id,
      required this.description,
      required this.transactionDate,
      this.reference,
      required this.merchantId,
      required this.merchantName,
      required this.merchantEmail,
      this.paid,
      required this.total,
      required this.purchaseItems,
      required this.purchaseStatusId});
}

class PurchaseUpdateResult {
  late final PurchaseUpdateSuccessResult? purchase;
  late final GraphQLPurchaseError? error;

  PurchaseUpdateResult({this.purchase}) : error = null;
  PurchaseUpdateResult.error({this.error}) : purchase = null;

  bool get hasError => error != null;
}

class PurchaseUpdateSuccessResult {
  PurchaseUpdateSuccessResult({
    required this.result_id,
    required this.result_description,
  });

  late final String result_id;
  late final String result_description;
}

class PurchaseCreationResult {
  late final PurchaseCreationSuccessResult? purchase;
  late final GraphQLPurchaseError? error;

  PurchaseCreationResult({this.purchase}) : error = null;
  PurchaseCreationResult.error({this.error}) : purchase = null;

  bool get hasError => error != null;
}

class PurchaseCreationSuccessResult {
  PurchaseCreationSuccessResult({
    required this.result_id,
    required this.result_transactionDate,
    required this.result_description,
  });

  late final String result_id;
  late final String result_transactionDate;
  late final String result_description;
}

class GraphQLPurchaseError {
  final String? message;

  GraphQLPurchaseError({required this.message});
}

class PurchaseItemDetail {
  String id;
  final String productId;
  final String itemDescription;
  final num index;
  num unitPrice;
  num quantity;
  num? quantityRecieved;

  PurchaseItemDetail(
      {required this.id,
      required this.productId,
      required this.itemDescription,
      required this.index,
      required this.unitPrice,
      required this.quantity,
      this.quantityRecieved});
}
