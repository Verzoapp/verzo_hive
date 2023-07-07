import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/invoices_service.dart';

class UpdateInvoicesViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _invoiceService = locator<InvoiceService>();

  List<Customers> customerList = [];
  String selectedCustomerName = '';

  late Invoices invoice; // Add selectedExpense variable
  late String invoiceId;

  UpdateInvoicesViewModel({required Invoices passinvoice}) {
    invoice = passinvoice;
  }

  void setSelectedInvoice() {
    invoiceId = invoice.id;
    // Set the form field values based on the selected expense properties
    updateDueDateController.text = invoice.dueDate;

    updateDateOfIssueController.text = invoice.dateOfIssue;
    updateCustomerIdController.text = invoice.customerId;
    selectedCustomerName = invoice.customerName;
    updateDiscountController.text = invoice.discount.toString();
    updateVATController.text = invoice.VAT.toString();
    notifyListeners();
  }

  TextEditingController updateDueDateController = TextEditingController();
  TextEditingController updateDateOfIssueController = TextEditingController();
  TextEditingController updateCustomerIdController = TextEditingController();
  TextEditingController updateDiscountController = TextEditingController();
  TextEditingController updateSelectedCustomerName = TextEditingController();
  TextEditingController updateVATController = TextEditingController();

  Future<List<Customers>> getCustomersByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing customers
    final customers = await _invoiceService.getCustomerByBusiness(
        businessId: businessIdValue);
    customerList = customers;
    // filteredCustomerList = customers;
    notifyListeners();

    return customers;
  }

  void navigateBack() => navigationService.back();

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  void addNewCustomer(List<Customers> customer) {
    if (customer.isNotEmpty) {
      customerList.addAll(customer);
    }
    notifyListeners();
  }
}
