import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/ui/add_invoices/add_invoices_view.form.dart';

class AddInvoicesViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _invoiceService = locator<InvoiceService>();

  List<DropdownMenuItem<String>> customerdropdownItems = [];
  List<DropdownMenuItem<String>> productorservicedropdownItems = [];

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  Future<ProductOrService> getProductOrServiceByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('id') ?? '';

    // Retrieve existing products/services
    final productsorservices = await _invoiceService
        .getProductOrServiceByBusiness(businessId: businessIdValue);
    productorservicedropdownItems = productsorservices.map((productorservice) {
      return DropdownMenuItem<String>(
        value: productorservice.id.toString(),
        child: Text(productorservice.title),
      );
    }).toList();

    return productsorservices.first;
  }

  Future<Customers> getCustomersByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('id') ?? '';

    // Retrieve existing customers
    final customers = await _invoiceService.getCustomerByBusiness(
        businessId: businessIdValue);
    customerdropdownItems = customers.map((customer) {
      return DropdownMenuItem<String>(
        value: customer.id.toString(),
        child: Text(customer.name),
      );
    }).toList();

    // Add "create new category" dropdown item
    productorservicedropdownItems.add(const DropdownMenuItem<String>(
      value: 'new_category',
      child: Text(' + Create New Customer'),
    ));

    return customers.first;
  }

  Future<InvoiceCreationResult> runInvoiceCreation() async {
    final prefs = await SharedPreferences.getInstance();
    final businessIdValue = prefs.getString('id');
    return _invoiceService.createInvoices(
        customerId: customerIdValue ?? '', businessId: businessIdValue ?? '');
  }

  Future saveInvoiceData() async {
    final result = await runBusyFuture(runInvoiceCreation());

    if (result.invoice != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.invoicingRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  void navigateBack() => navigationService.back();
}
