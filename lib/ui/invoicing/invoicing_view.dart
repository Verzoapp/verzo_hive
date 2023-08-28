import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view.dart';
import 'package:verzo_one/ui/expenses/expenses_view.dart';
import 'package:verzo_one/ui/invoicing/invoicing_view_model.dart';
import 'package:verzo_one/ui/sales/sales_view.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';
import 'package:verzo_one/ui/view_invoices/view_invoices_view_model.dart';

class InvoicesView extends StatefulWidget {
  const InvoicesView({
    Key? key,
  }) : super(key: key);

  @override
  State<InvoicesView> createState() => _InvoicesViewState();
}

class _InvoicesViewState extends State<InvoicesView> {
  final navigationService = locator<NavigationService>();

  int selectedPageIndex = 3;
  void onHomeTapped() {
    setState(() {
      selectedPageIndex = 0;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DashboardView()),
    );
  }

  void onSalesTapped() {
    setState(() {
      selectedPageIndex = 1;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SalesView()),
    );
  }

  void onExpensesTapped() {
    setState(() {
      selectedPageIndex = 2;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpensesView()),
    );
  }

  void onInvoicingTapped() {
    setState(() {
      selectedPageIndex = 3;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InvoicesView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InvoicesViewModel>.reactive(
        viewModelBuilder: () => InvoicesViewModel(),
        onModelReady: (model) async {
          // model.addNewInvoice;
          model.archiveInvoice;
        },
        builder: (context, model, child) {
          // if (model.isBusy) {
          //   return const Scaffold(
          //     body: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   );
          // }
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: kcPrimaryColor,
              onPressed: () {
                navigationService.navigateTo(Routes.addInvoiceRoute);
              },
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              fixedColor: kcPrimaryColor,
              iconSize: 24,
              showUnselectedLabels: true,
              unselectedItemColor: kcTextColorLight,
              currentIndex: selectedPageIndex,
              onTap: (index) {
                if (index == 0) {
                  onHomeTapped();
                } else if (index == 1) {
                  onSalesTapped();
                } else if (index == 2) {
                  onExpensesTapped();
                }
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Sales'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'Expenses'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.receipt_long), label: 'Incoicing')
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceTiny,
                  SvgPicture.asset(
                    'assets/images/verzo_logo.svg',
                    width: 110,
                    height: 30,
                  ),
                  verticalSpaceIntermitent,
                  // Text(
                  //   'Recent Invoices',
                  //   style: ktsHeaderText,
                  // ),
                  verticalSpaceSmall,
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kcButtonTextColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: kcTextColorLight.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          // onChanged: (value) =>
                          // model.runFilter(value),
                          decoration: InputDecoration(
                            labelText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            labelStyle: ktsFormText,
                            border: defaultFormBorder,
                          ),
                        ),
                        verticalSpaceTiny,
                        Builder(builder: (context) {
                          if (model.isBusy) {
                            return const CircularProgressIndicator(
                              color: kcPrimaryColor,
                            );
                          }
                          if (model.data == null) {
                            return const Text('No Invoice');
                          }
                          return ListView.separated(
                            padding: const EdgeInsets.all(2),
                            physics: const NeverScrollableScrollPhysics(),
                            primary: true,
                            shrinkWrap: true,
                            itemCount: model.data!.length,
                            itemBuilder: (context, index) {
                              var invoice = model.data![index];
                              return InvoiceCard(
                                invoices: invoice,
                                // model.data![index],
                                archiveInvoice: () {
                                  model.archiveInvoice(invoice.id);
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return verticalSpaceTiny;
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class InvoiceCard extends StatelessWidget {
  InvoiceCard({Key? key, required this.invoices, required this.archiveInvoice})
      : super(key: key);
  final navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final Invoices invoices;
  final Function archiveInvoice;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: defaultTagBorderRadius),
      tileColor: kcStrokeColor,
      title: Text(
        invoices.customerName,
        style: ktsBodyText,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        invoices.createdAt,
        style: ktsBodyTextLight,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            NumberFormat.currency(locale: 'en', symbol: 'N')
                .format(invoices.totalAmount),
            style: ktsBodyText,
          ),
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: (() async {
              navigationService.navigateToViewInvoiceRoute(
                  selectedInvoice: invoices);
            }),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: (() {
              navigationService.navigateToUpdateInvoiceRoute(
                  selectedInvoice: invoices);
            }),
          ),
          IconButton(
              onPressed: () async {
                final DialogResponse? response =
                    await _dialogService.showConfirmationDialog(
                        dialogPlatform: DialogPlatform.Cupertino,
                        title: 'Archive Invoice',
                        description:
                            'Are you sure you want to archive this invoice?',
                        barrierDismissible: true,
                        cancelTitle: 'Cancel',
                        confirmationTitle: 'Ok');
                if (response?.confirmed == true) {
// Call the archiveExpense function
                  archiveInvoice();
                }
              },
              icon: const Icon(Icons.archive))
        ],
      ),
    );
  }
}
