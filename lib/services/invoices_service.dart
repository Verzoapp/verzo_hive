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
  final QueryOptions _getInvoiceByBusinessQuery;

//Customers
  final MutationOptions _createCustomerMutation;
  final QueryOptions _getCustomerByBusinessQuery;

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
        _getInvoiceByBusinessQuery = QueryOptions(
          document: gql('''
        query GetInvoiceByBusiness(\$input: String!) {
          getInvoiceByBusiness(businessId: \$input) {
            invoicesByBusiness{
            id
            totalAmount
            createdAt
            customer{
              name
            }
            }
            }
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
        _getCustomerByBusinessQuery = QueryOptions(
          document: gql('''
        query GetCustomerByBusiness(\$input: String!) {
          getCustomerByBusiness(businessId: \$input) {
            customerByBusiness{
            id
            name
            email
            businessId
            }
            }
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
      required String dueDate}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('id');

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

  Future<List<Invoices>> getInvoiceByBusiness({
    required String businessId,
  }) async {
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
      document: _getInvoiceByBusinessQuery.document,
      variables: {'input': businessId},
    );

    final QueryResult invoiceByBusinessResult = await newClient.query(options);

    if (invoiceByBusinessResult.hasException) {
      throw GraphQLInvoiceError(
        message: invoiceByBusinessResult.exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List invoicesData = invoiceByBusinessResult
            .data?['getInvoiceByBusiness']['invoicesByBusiness'] ??
        [];

    final List<Invoices> invoices = invoicesData.map((data) {
      return Invoices(
        id: data['id'],
        customerName: data['customer']['name'],
        totalAmount: data['totalAmount'],
        createdAt: data['createdAt'],
      );
    }).toList();

    return invoices;
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
    final businessId = prefs.getString('id');

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

  Future<List<Customers>> getCustomerByBusiness(
      {required String businessId}) async {
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
      document: _getCustomerByBusinessQuery.document,
      variables: {'input': businessId},
    );

    final QueryResult customerByBusinessResult = await newClient.query(options);

    if (customerByBusinessResult.hasException) {
      throw GraphQLInvoiceError(
        message: customerByBusinessResult.exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List customersData = customerByBusinessResult
            .data?['getCustomerByBusiness']['customerByBusiness'] ??
        [];

    final List<Customers> customers = customersData.map((data) {
      return Customers(
          id: data['id'],
          name: data['name'],
          email: data['email'],
          businessId: data['businessId']);
    }).toList();

    return customers;
  }
}

class Customers {
  final String id;
  final String name;
  final String email;
  final String businessId;

  Customers(
      {required this.id,
      required this.name,
      required this.email,
      required this.businessId});
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
  final num totalAmount;
  final String createdAt;

  Invoices(
      {required this.id,
      required this.customerName,
      required this.totalAmount,
      required this.createdAt});
}

class ItemDetail {
  final String id;
  final String type;
  final num price;
  final num? quantity;
  final num index;

  ItemDetail({
    required this.id,
    required this.type,
    required this.price,
    this.quantity,
    required this.index,
  });
}
