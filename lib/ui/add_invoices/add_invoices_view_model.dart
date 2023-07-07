import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/services/product&services_service.dart';
import 'package:verzo_one/ui/add_invoices/add_invoices_view.form.dart';
import 'package:verzo_one/ui/shared/styles.dart';

class AddInvoicesViewModel extends FormViewModel with Initialisable {
  final navigationService = locator<NavigationService>();
  final _invoiceService = locator<InvoiceService>();

  List<Customers> customerList = [];
  String selectedCustomerName = '';
  List<Customers> newCustomer = [];
  List<Customers> filteredCustomerList = [];

  List<Items> selectedItems = [];
  List<Items> newlySelectedItems = [];
  double subtotal = 0.00;
  double total = 0.00;

  TextEditingController discountController;
  TextEditingController VATController;
  AddInvoicesViewModel({
    required this.discountController,
    required this.VATController,
  });

  List<ItemDetail> convertItemsToItemDetails(List<Items> items) {
    List<ItemDetail> itemDetails = [];

    for (int i = 0; i < items.length; i++) {
      Items item = items[i];
      ItemDetail itemDetail = ItemDetail(
          id: item.id,
          type: item.type,
          price: item.price,
          index: i + 1,
          quantity: item.quantity);
      itemDetails.add(itemDetail);
    }

    return itemDetails;
  }

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

  void addselectedItems(List<Items> items) {
    if (items.isNotEmpty) {
      selectedItems.addAll(items);
    }
    calculateSubtotal();
    notifyListeners();
  }

  void removeSelectedItem(Items items) {
    selectedItems.remove(items);
    calculateSubtotal();
    notifyListeners();
  }

  void calculateSubtotal() {
    subtotal = selectedItems.fold(0.00, (sum, item) {
      if (item.type == 'P') {
        return sum + (item.price * (item.quantity ?? 1));
      } else {
        return sum + item.price;
      }
    });
  }

  void calculateTotal() {
    double discountPercentage = discountController.text.isNotEmpty
        ? double.parse(discountController.text)
        : 0;
    double vatPercentage =
        VATController.text.isNotEmpty ? double.parse(VATController.text) : 0;

    double discountAmount = subtotal * (discountPercentage / 100);
    double vatAmount = subtotal * (vatPercentage / 100);

    total = subtotal - discountAmount + vatAmount;
  }

  Future<List<Customers>> getCustomersByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing customers
    final customers = await _invoiceService.getCustomerByBusiness(
        businessId: businessIdValue);
    customerList = customers;
    filteredCustomerList = customers;
    notifyListeners();

    return customers;
  }

  void performSearch(String query) {
    // Implement search functionality here
    // You can update the customer list based on the search query
    // For example, filter the customerList based on the name containing the query
    List<Customers> filteredList = customerList
        .where((customer) =>
            customer.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Update the UI with the filtered list
    // You can create a new list variable in the ViewModel to hold the filtered list
    // and update the UI using that list
    filteredCustomerList = filteredList;

    // Call notifyListeners() if necessary to update the UI
    notifyListeners();
  }

  Future<InvoiceCreationResult> runInvoiceCreation() async {
    final prefs = await SharedPreferences.getInstance();
    final businessIdValue = prefs.getString('businessId');
    return _invoiceService.createInvoices(
        customerId: customerIdValue ?? '',
        businessId: businessIdValue ?? '',
        item: convertItemsToItemDetails(selectedItems),
        dueDate: dueDateValue ?? '',
        dateOfIssue: dateOfIssueValue ?? '',
        vat: double.parse(vatValue ?? ''),
        discount: double.parse(discountValue ?? ''));
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

  @override
  Future<void> initialise() async {
    await getCustomersByBusiness();
  }

  void openEditBottomSheet(Items item) {
    bool hasQuantityField = item.type == 'P';

    showModalBottomSheet(
      context: navigationService.navigatorKey!.currentContext!,
      builder: (BuildContext context) {
        num quantity = 1;
        return ListView(shrinkWrap: true, children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Edit Item', style: ktsHeaderText),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  initialValue: item.price.toString(),
                  // Handle price input
                  onChanged: (value) {
                    // Update the item price
                    num newPrice = num.tryParse(value) ?? 0;
                    item.price = newPrice;
                  },
                ),
                if (hasQuantityField)
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                    ),
                    initialValue: quantity
                        .toString(), // Set the initial value to quantity
                    // Handle quantity input
                    onChanged: (value) {
                      // Update the item quantity
                      num newQuantity = num.tryParse(value) ?? 1;
                      item.quantity = newQuantity;
                    },
                  ),
                ElevatedButton(
                  onPressed: () {
                    // Save the changes and close the bottom sheet
                    calculateSubtotal();
                    notifyListeners();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style: ktsButtonText,
                  ),
                ),
              ],
            ),
          ),
        ]);
      },
    );
  }

//   void openEditBottomSheet(Items item) {
//   bool hasQuantityField = item.type == 'P';

//   showModalBottomSheet(
//     context: navigationService.navigatorKey.currentContext!,
//     builder: (BuildContext context) {
//       return Container(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Edit Item',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Price',
//               ),
//               initialValue: item.price.toString(),
//               // Handle price input
//               onChanged: (value) {
//                 // Update the item price
//                 double newPrice = double.tryParse(value) ?? 0.0;
//                 item.price = newPrice;
//               },
//             ),
//             if (hasQuantityField)
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Quantity',
//                 ),
//                 initialValue: item.quantity.toString(),
//                 // Handle quantity input
//                 onChanged: (value) {
//                   // Update the item quantity
//                   int newQuantity = int.tryParse(value) ?? 0;
//                   item.quantity = newQuantity;
//                 },
//               ),
//             ElevatedButton(
//               onPressed: () {
//                 // Save the changes and close the bottom sheet
//                 calculateSubtotal();
//                 notifyListeners();
//                 Navigator.pop(context);
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
  //       SizedBox(
  //   width: 60,
  //   child: Expanded(
  //     child: TextFormField(
  //       decoration: const InputDecoration(
  //           prefixText: '+', suffixText: '%'),
  //       controller: VATController,
  //       keyboardType:
  //           const TextInputType.numberWithOptions(
  //               decimal: true),
  //       textAlign: TextAlign.right,
  //       inputFormatters: [
  //         FilteringTextInputFormatter.allow(
  //             RegExp(r'^\d+\.?\d{0,2}')),
  //       ],
  //       style: ktsBodyTextLight,
  //     ),
  //   ),
  // ),
}
