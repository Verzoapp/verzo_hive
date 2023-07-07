import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/invoices_service.dart';

import 'package:verzo_one/ui/add_invoices/add_invoices_view.form.dart';
import 'package:verzo_one/ui/add_invoices/add_invoices_view_model.dart';
import 'package:verzo_one/ui/create_customer/create_customer_view.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/setup_bottom_sheet_ui.dart';

import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'customerId'),
  FormTextField(name: 'dueDate'),
  FormTextField(name: 'dateOfIssue'),
  FormTextField(name: 'VAT', initialValue: '0.00'),
  FormTextField(name: 'discount', initialValue: '0.00')
])
class AddInvoicesView extends StatelessWidget with $AddInvoicesView {
  AddInvoicesView({
    Key? key,
  }) : super(key: key);

  final navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddInvoicesViewModel>.reactive(
      viewModelBuilder: () => AddInvoicesViewModel(
          VATController: VATController, discountController: discountController),
      onModelReady: (model) async {
        model.getCustomersByBusiness();
        model.newlySelectedItems;
        model.addNewCustomer;
        listenToFormUpdated(model);
      },
      builder: (context, model, child) => Scaffold(
        body: AuthenticationLayout(
          busy: model.isBusy,
          onBackPressed: model.navigateBack,
          onMainButtonTapped: () => model.saveInvoiceData(),
          title: 'Add Invoice',
          subtitle: 'Please fill the form below to create an invoice',
          mainButtonTitle: 'Add',
          form: Column(
            children: [
              TextFormField(
                controller: dueDateController,
                decoration: InputDecoration(
                    labelText: 'Due Date',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 5),
                    lastDate: DateTime(DateTime.now().year + 5),
                  );
                  if (pickeddate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickeddate);
                    dueDateController.text = formattedDate;
                  }
                },
              ),
              verticalSpaceTiny,
              TextFormField(
                controller: dateOfIssueController,
                decoration: InputDecoration(
                    labelText: 'Date Of Issue',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 5),
                    lastDate: DateTime(DateTime.now().year + 5),
                  );
                  if (pickeddate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickeddate);
                    dateOfIssueController.text = formattedDate;
                  }
                },
              ),
              verticalSpaceTiny,
              Card(
                child: ListTile(
                  title: Text('Customer', style: ktsBodyTextBold),
                  subtitle: Text(
                    customerIdController.text.isEmpty
                        ? 'Select a customer'
                        : model.selectedCustomerName,
                    style: ktsBodyText,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        color: kcTextColor,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return CreateCustomerView();
                            },
                          ).whenComplete(() async {
                            await model
                                .getCustomersByBusiness(); // reset the `_isCreatingMerchant` flag when the bottom sheet is closed
                          });
                        },
                      ),
                      IconButton(
                        color: kcTextColor,
                        icon: const Icon(Icons.search),
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              color: kcButtonTextColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: defaultBorderRadius,
                                        color: kcStrokeColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: TextField(
                                          onChanged: (value) {
                                            // Implement search functionality here
                                            model.performSearch(value);
                                          },
                                          decoration: const InputDecoration(
                                            hintText: 'Search',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    verticalSpaceSmall,
                                    Expanded(
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            verticalSpaceSmall,
                                        shrinkWrap: true,
                                        itemCount: model.customerList.length,
                                        itemBuilder: (context, index) {
                                          final customer =
                                              model.customerList[index];
                                          return GestureDetector(
                                            onTap: () {
                                              // Set the selected customer item to customerIdController
                                              customerIdController.text =
                                                  customer.id;
                                              model.selectedCustomerName =
                                                  customer.name;
                                              Navigator.pop(
                                                  context); // Close the bottom sheet
                                            },
                                            child: Text(
                                              customer.name,
                                              style: ktsFormText,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpaceTiny,
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Items',
                              style: ktsBodyTextBold,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () async {
                                model.newlySelectedItems =
                                    await navigationService
                                        .navigateTo(Routes.chooseItemRoute);
                                // Receive the selected items from ChooseItemView
                                model
                                    .addselectedItems(model.newlySelectedItems);
                              },
                            ),
                          ],
                        ),
                        verticalSpaceTiny,
                        if (model.selectedItems.isNotEmpty)
                          ...model.selectedItems.map((item) => ListTile(
                                title: Text(item.title),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'en', symbol: '\N')
                                          .format(item.price),
                                      style: ktsBodyText,
                                    ),
                                    horizontalSpaceSmall,
                                    if (item.type == 'P')
                                      Text('Qty: ${item.quantity}'),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        model.openEditBottomSheet(item);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        model.removeSelectedItem(item);
                                      },
                                    ),
                                  ],
                                ),
                              )),
                      ]),
                ),
              ),
              verticalSpaceTiny,
              Card(
                margin: const EdgeInsets.all(6),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SubTotal',
                            style: ktsBodyTextLight,
                          ),
                          Text(
                            'N${model.subtotal.toStringAsFixed(2)}',
                            style: ktsBodyTextLight,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount (Optional)',
                            style: ktsBodyTextLight,
                          ),
                          SizedBox(
                            width: 65,
                            child: Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    prefixText: '-', suffixText: '%'),
                                controller: discountController,
                                onChanged: (value) {
                                  model.calculateTotal();
                                  model.notifyListeners();
                                },
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                textAlign: TextAlign.right,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^\d{4,}|\.\d{3,}$')),
                                ],
                                style: ktsBodyTextLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tax',
                            style: ktsBodyTextLight,
                          ),
                          SizedBox(
                            width: 65,
                            child: Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    prefixText: '+', suffixText: '%'),
                                controller: VATController,
                                onChanged: (value) {
                                  model.calculateTotal();
                                  model.notifyListeners();
                                },
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                textAlign: TextAlign.right,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^\d{4,}|\.\d{3,}$')),
                                ],
                                style: ktsBodyTextLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: ktsHeaderText,
                          ),
                          Text(
                            'N${model.total.toStringAsFixed(2)}',
                            style: ktsHeaderText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // DropdownButtonFormField(
              //   decoration: InputDecoration(
              //       labelText: ' Customer',
              //       labelStyle: ktsHeaderText,
              //       border: defaultFormBorder),
              //   items: model.customerdropdownItems,
              //   value: customerIdController.text.isEmpty
              //       ? null
              //       : customerIdController.text,
              //   onChanged: (value) {
              //     if (value == 'new_category') {
              //       showModalBottomSheet(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return CreateCustomerView();
              //         },
              //       ).whenComplete(() {
              //         // reset the `_isCreatingMerchant` flag when the bottom sheet is closed
              //       });
              //     } else {
              //       customerIdController.text = value.toString();
              //     }
              //   },
              // ),
              //   ),
              // ),
              // verticalSpaceSmall,
              // TextFormField(
              //   maxLengthEnforcement: MaxLengthEnforcement.enforced,
              //   maxLines: 3,
              //   decoration: InputDecoration(
              //       labelText: 'Items',
              //       labelStyle: ktsFormText,
              //       border: defaultFormBorder),
              //   keyboardType: TextInputType.name,
              // ),
              // verticalSpaceSmall,
              // DropdownButtonFormField(
              //   decoration: InputDecoration(
              //       labelText: 'Item',
              //       labelStyle: ktsFormText,
              //       border: defaultFormBorder),
              //   items: model.productorservicedropdownItems,
              //   value: itemController.text.isEmpty ? null : itemController.text,
              //   onChanged: (value) {
              //     itemController.text = value.toString();
              //   },
              // ),
            ],
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //     type: BottomNavigationBarType.fixed,
        //     fixedColor: kcPrimaryColor,
        //     iconSize: 24,
        //     showUnselectedLabels: true,
        //     unselectedItemColor: kcTextColorLight,
        //     currentIndex: 3,
        //     items: const <BottomNavigationBarItem>[
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.home),
        //         label: 'Home',
        //       ),
        //       BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Sales'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.shopping_cart), label: 'Expenses'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.receipt_long), label: 'Invoicing')
        //     ]),
      ),
    );
  }
}


// subtitle: Row(
                                //   children: [
                                //     SizedBox(
                                //       height: 30,
                                //       // decoration: BoxDecoration(
                                //       //     borderRadius: BorderRadius.circular(8.0),
                                //       //     border: Border.all(
                                //       //       color: Colors.grey,
                                //       //       width: 0.5,
                                //       //     )),
                                //       child: TextFormField(
                                //         decoration: InputDecoration(
                                //           prefixText: NumberFormat.currency(
                                //             locale: 'en',
                                //             symbol: '\N',
                                //           ).currencySymbol,
                                //           hintText: 'Price',
                                //           border: InputBorder.none,
                                //         ),
                                //         style: ktsBodyText,
                                //       ),
                                //     ),
                                //     horizontalSpaceSmall,
                                //     TextFormField(
                                //         decoration: InputDecoration(
                                //       prefixText: NumberFormat.currency(
                                //         locale: 'en',
                                //         symbol: '\N',
                                //       ).currencySymbol,
                                //     ))
                                //   ],
                                // )
                                