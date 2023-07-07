import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InvoiceService {
  ValueNotifier<GraphQLClient> client;

//Invoice
  final MutationOptions _createCompleteInvoiceBMutation;
  final QueryOptions _getInvoiceByIdQuery;
  final MutationOptions _archiveInvoiceMutation;
  final QueryOptions _getInvoiceByBusinessMobileQuery;

//Customers
  final MutationOptions _createCustomerMutation;
  final QueryOptions _getCustomerByIdQuery;
  final MutationOptions _archiveCustomerMutation;
  final QueryOptions _getCustomerByBusinessMobileQuery;

  InvoiceService()
      : client = ValueNotifier(GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink('https://api.verzo.app/graphql'),
        )),
        _createCompleteInvoiceBMutation = MutationOptions(
          document: gql('''
        mutation CreateCompleteInvoiceB(\$input: CreateCompleteInvoiceB!) {
          createCompleteInvoiceB(input: \$input) {
            id
            customerId
          }
        }
      '''),
        ),
        _getInvoiceByIdQuery = QueryOptions(
          document: gql('''
        query GetInvoiceById(\$invoiceId: String!){
          getInvoiceById(invoiceId: \$invoiceId){
            id
            dueDate
            dateOfIssue
            customerId
            subtotal
            discount
            VAT
            totalAmount
            createdAt
            customer{
              name
            }
            }
          }
        '''),
        ),
        _getInvoiceByBusinessMobileQuery = QueryOptions(
          document: gql('''
        query GetInvoiceByBusinessMobile(\$businessId: String!, \$cursor: String, \$take: Float) {
          getInvoiceByBusinessMobile (businessId: \$businessId, cursor: \$cursor, take: \$take) {
            invoicesByBusiness{
            id
            customerId
            subtotal
            discount
            VAT
            dateOfIssue
            dueDate
            totalAmount
            createdAt
            customer{
              name
            }
            }
            cursorId
            }
          }
        '''),
        ),
        _archiveInvoiceMutation = MutationOptions(
          document: gql('''
        mutation ArchiveInvoice(\$invoiceId: String!) {
          archiveInvoice(invoiceId: \$invoiceId)
        }
      '''),
        ),
        _createCustomerMutation = MutationOptions(
          document: gql('''
        mutation CreateCustomer(\$input: CreateCustomer!) {
          createCustomer(input:\$input) {
            id
            name
            mobile
            email
            address
            businessId
          }
         }
        '''),
        ),
        _getCustomerByIdQuery = QueryOptions(
          document: gql('''
        query GetCustomerById(\$customerId: String!){
          getCustomerById(customerId: \$customerId){
            id
            name
            email
            mobile
            }
          }
        '''),
        ),
        _getCustomerByBusinessMobileQuery = QueryOptions(
          document: gql('''
        query GetCustomerByBusinessMobile(\$businessId: String!, \$cursor: String, \$take: Float) {
          getCustomerByBusinessMobile(businessId: \$businessId, cursor: \$cursor, take: \$take) {
            customerByBusiness{
            id
            name
            email
            mobile
            businessId
            }
            }
          }
        '''),
        ),
        _archiveCustomerMutation = MutationOptions(
          document: gql('''
        mutation ArchiveCustomerByBusiness(\$customerId: String!) {
          archiveCustomerByBusiness(customerId: \$customerId)
        }
      '''),
        );

//Invoice

  Future<InvoiceCreationResult> createInvoices(
      {required String customerId,
      required String businessId,
      required List<ItemDetail> item,
      required double vat,
      double? discount,
      required String dueDate,
      required String dateOfIssue}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      return InvoiceCreationResult.error(
        error: GraphQLInvoiceError(
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
      document: _createCompleteInvoiceBMutation.document,
      variables: {
        'input': {
          'customerId': customerId,
          'businessId': businessId,
          'dueDate': dueDate,
          'discount': discount,
          'dateOfIssue': dateOfIssue,
          'VAT': vat,
          'item': item
              .map((itemDetail) => {
                    'id': itemDetail.id,
                    'type': itemDetail.type,
                    'price': itemDetail.price,
                    'quantity': itemDetail.quantity,
                    'index': itemDetail.index,
                  })
              .toList(),
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      return InvoiceCreationResult.error(
        error: GraphQLInvoiceError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    if (result.data == null || result.data!['createCompleteInvoiceB'] == null) {
      return InvoiceCreationResult.error(
        error: GraphQLInvoiceError(
          message: "Error parsing response data",
        ),
      );
    }

    var result_id = result.data?['createCompleteInvoiceB']['id'];
    var result_customerId =
        result.data?['createCompleteInvoiceB']['customerId'];

    var invoice = InvoiceCreationSuccessResult(
        result_id: result_id, result_customerId: customerId);

    return InvoiceCreationResult(invoice: invoice);
  }

  Future<Invoices> getInvoiceById({required String invoiceId}) async {
    final QueryOptions options = QueryOptions(
      document: _getInvoiceByIdQuery.document,
    );

    final QueryResult invoiceByIdResult = await client.value.query(options);

    if (invoiceByIdResult.hasException) {
      throw GraphQLInvoiceError(
        message:
            invoiceByIdResult.exception?.graphqlErrors.first.message.toString(),
      );
    }

    final invoiceByIdData = invoiceByIdResult.data?['getInvoiceById'] ?? [];

    final Invoices invoiceById = invoiceByIdData.map((data) {
      return Invoices(
          id: data['id'],
          customerId: data['customerId'],
          dateOfIssue: data['dateOfIssue'],
          dueDate: data['dueDate'],
          discount: data['discount'],
          VAT: data['VAT'],
          createdAt: data['createdAt'],
          customerName: data['customer']['name']);
    });

    return invoiceById;
  }

  Future<List<Invoices>> getInvoiceByBusiness(
      {required String businessId, num? take, String? cursor}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLInvoiceError(
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
      document: _getInvoiceByBusinessMobileQuery.document,
      variables: {'businessId': businessId, 'take': take, 'cursor': cursor},
    );

    final QueryResult invoiceByBusinessResult = await newClient.query(options);

    if (invoiceByBusinessResult.hasException) {
      throw GraphQLInvoiceError(
        message: invoiceByBusinessResult.exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List invoicesData = invoiceByBusinessResult
            .data?['getInvoiceByBusinessMobile']['invoicesByBusiness'] ??
        [];

    final String cursorId = invoiceByBusinessResult
            .data?['getInvoiceByBusinessMobile']['cursorId'] ??
        '';

    final List<Invoices> invoices = invoicesData.map((data) {
      return Invoices(
        id: data['id'],
        dueDate: data['dueDate'],
        dateOfIssue: data['dateOfIssue'],
        customerId: data['customerId'],
        discount: data['discount'],
        subtotal: data['subtotal'],
        VAT: data['VAT'],
        customerName: data['customer']['name'],
        totalAmount: data['totalAmount'],
        createdAt: data['createdAt'],
      );
    }).toList();

    return invoices;
  }

  Future<bool> archiveInvoice({required String invoiceId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLInvoiceError(
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
      document: _archiveInvoiceMutation.document,
      variables: {
        'invoiceId': invoiceId,
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    bool isArchived = result.data?['archiveInvoice'] ?? false;

    return isArchived;
  }

//CreateCustomer
  Future<CustomerCreationResult> createCustomer(
      {required String name,
      required String mobile,
      required String email,
      String? address,
      required String businessId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

    if (token == null) {
      return CustomerCreationResult.error(
        error: GraphQLInvoiceError(
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
      document: _createCustomerMutation.document,
      variables: {
        'input': {
          'name': name,
          'mobile': mobile,
          'email': email,
          'address': address,
          'businessId': businessId,
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    var customer_id = result.data?['createCustomer']['id'];
    var customer_name = result.data?['createCustomer']['name'];
    var customer_address = result.data?['createCustomer']['address'];
    var customer_mobile = result.data?['createCustomer']['mobile'];
    var customer_email = result.data?['createCustomer']['email'];
    var customer_businessId = result.data?['createCustomer']['businessId'];

    if (result.hasException) {
      return CustomerCreationResult.error(
        error: GraphQLInvoiceError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    if (result.data == null || result.data!['createCustomer'] == null) {
      return CustomerCreationResult.error(
        error: GraphQLInvoiceError(
          message: "Error parsing response data",
        ),
      );
    }

    var customer = CustomerCreationSuccessResult(
        id: customer_id,
        name: customer_name,
        address: customer_address,
        mobile: customer_mobile,
        email: customer_email,
        businessId: customer_businessId);

    return CustomerCreationResult(customer: customer);
  }

  Future<Customers> getCustomerById({required String customerId}) async {
    final QueryOptions options = QueryOptions(
      document: _getCustomerByIdQuery.document,
    );

    final QueryResult customerByIdResult = await client.value.query(options);

    if (customerByIdResult.hasException) {
      throw GraphQLInvoiceError(
        message: customerByIdResult.exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final customerByIdData = customerByIdResult.data?['getCustomerById'] ?? [];

    final Customers customerById = customerByIdData.map((data) {
      return Customers(
          id: data['id'],
          email: data['email'],
          name: data['name'],
          mobile: data['mobile']);
    });

    return customerById;
  }

  Future<bool> archiveCustomer({required String customerId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLInvoiceError(
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
      document: _archiveCustomerMutation.document,
      variables: {
        'customerId': customerId,
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    bool isArchived = result.data?['archiveCustomerByBusiness'] ?? false;

    return isArchived;
  }

  Future<List<Customers>> getCustomerByBusiness(
      {required String businessId, num? take, String? cursor}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLInvoiceError(
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
      document: _getCustomerByBusinessMobileQuery.document,
      variables: {'businessId': businessId, 'take': take, 'cursor': cursor},
    );

    final QueryResult customerByBusinessResult = await newClient.query(options);

    if (customerByBusinessResult.hasException) {
      throw GraphQLInvoiceError(
        message: customerByBusinessResult.exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List customersData = customerByBusinessResult
            .data?['getCustomerByBusinessMobile']['customerByBusiness'] ??
        [];

    final String cursorId = customerByBusinessResult
            .data?['getCustomerByBusinessMobile']['cursorId'] ??
        '';

    final List<Customers> customers = customersData.map((data) {
      return Customers(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        mobile: data['mobile'],
        // invoiceCreatedAt: data['invoices']['createdAt'] ?? '',
        // invoiceTotalAmount: data['invoices']['totalAmount']);
      );
    }).toList();

    return customers;
  }
}

class Customers {
  final String id;
  final String name;
  final String email;
  final String mobile;
  num? invoiceTotalAmount;
  String? invoiceCreatedAt;

  Customers(
      {required this.id,
      required this.name,
      required this.email,
      required this.mobile,
      this.invoiceCreatedAt,
      this.invoiceTotalAmount});
}

class CustomerCreationResult {
  late final CustomerCreationSuccessResult? customer;
  late final GraphQLInvoiceError? error;

  CustomerCreationResult({this.customer}) : error = null;
  CustomerCreationResult.error({this.error}) : customer = null;

  bool get hasError => error != null;
}

class CustomerCreationSuccessResult {
  final String id;
  final String name;
  final String mobile;
  final String email;
  final String? address;
  final String businessId;

  CustomerCreationSuccessResult(
      {required this.id,
      required this.name,
      required this.mobile,
      required this.email,
      this.address,
      required this.businessId});
}

class InvoiceCreationResult {
  late final InvoiceCreationSuccessResult? invoice;
  late final GraphQLInvoiceError? error;

  InvoiceCreationResult({this.invoice}) : error = null;
  InvoiceCreationResult.error({this.error}) : invoice = null;

  bool get hasError => error != null;
}

class InvoiceCreationSuccessResult {
  InvoiceCreationSuccessResult({
    required this.result_id,
    required this.result_customerId,
  });

  late final String result_id;
  late final String result_customerId;
}

class GraphQLInvoiceError {
  final String? message;

  GraphQLInvoiceError({required this.message});
}

class Invoices {
  final String id;
  final String customerName;
  final num? subtotal;
  final num? totalAmount;
  final num? discount;
  final num VAT;
  final String createdAt;
  final String dueDate;
  final String dateOfIssue;
  final String customerId;

  Invoices({
    required this.id,
    required this.customerName,
    this.subtotal,
    this.totalAmount,
    this.discount,
    required this.VAT,
    required this.createdAt,
    required this.dueDate,
    required this.dateOfIssue,
    required this.customerId,
  });
}

class ItemDetail {
  final String id;
  final String type;
  final num index;
  final num price;
  final num quantity;

  ItemDetail({
    required this.id,
    required this.type,
    required this.index,
    required this.price,
    required this.quantity,
  });
}
