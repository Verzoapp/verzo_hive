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
          model.addNewInvoice;
        },
        builder: (context, model, child) {
          if (model.isBusy) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: [
                  verticalSpaceTiny,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/images/verzo_logo.svg',
                        width: 102,
                        height: 21,
                      ),
                      const CircleAvatar(
                        backgroundColor: kcTextColorLight,
                        foregroundColor: kcButtonTextColor,
                        radius: 16,
                        child: Text('V'),
                      ),
                    ],
                  ),
                  verticalSpaceRegular,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Invoices',
                        style: ktsHeaderText,
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  if (model.data == null)
                    Text('No Invoice')
                  else
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: true,
                      shrinkWrap: true,
                      itemCount: model.data!.length,
                      itemBuilder: (context, index) {
                        return InvoiceCard(invoices: model.data![index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return verticalSpaceTiny;
                      },
                    ),
                ],
              ),
            ),
          );
        });
  }
}

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({Key? key, required this.invoices}) : super(key: key);

  final Invoices invoices;
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
      trailing: Text(
        NumberFormat.currency(locale: 'en', symbol: '\N')
            .format(invoices.totalAmount),
        style: ktsBodyText,
      ),
    );
  }
}
