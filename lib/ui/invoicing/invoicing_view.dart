import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view.dart';
import 'package:verzo_one/ui/expenses/expenses_view.dart';
import 'package:verzo_one/ui/invoicing/invoicing_view_model.dart';
import 'package:verzo_one/ui/sales/sales_view.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

class InvoicingView extends StatefulWidget {
  const InvoicingView({
    Key? key,
  }) : super(key: key);

  @override
  State<InvoicingView> createState() => _InvoicingViewState();
}

class _InvoicingViewState extends State<InvoicingView> {
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
      MaterialPageRoute(builder: (context) => const ExpensesView()),
    );
  }

  void onInvoicingTapped() {
    setState(() {
      selectedPageIndex = 3;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InvoicingView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InvoicingViewModel>.reactive(
      viewModelBuilder: () => InvoicingViewModel(),
      onModelReady: (model) => () {},
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kcPrimaryColor,
          onPressed: () {
            navigationService.replaceWith(Routes.addInvoiceRoute);
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: ListView(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Invoicing',
                    style: ktsHeaderText,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcStrokeColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '+N200,000',
                              style: ktsBodyText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcStrokeColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '+N200,000',
                              style: ktsBodyText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcStrokeColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '+N200,000',
                              style: ktsBodyText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcStrokeColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '+N200,000',
                              style: ktsBodyText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcStrokeColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '+N200,000',
                              style: ktsBodyText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcStrokeColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '+N200,000',
                              style: ktsBodyText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
