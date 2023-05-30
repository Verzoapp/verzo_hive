import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view.dart';
import 'package:verzo_one/ui/expenses/expenses_view.dart';
import 'package:verzo_one/ui/invoicing/invoicing_view.dart';
import 'package:verzo_one/ui/sales/sales_view_model.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

class SalesView extends StatefulWidget {
  const SalesView({
    Key? key,
  }) : super(key: key);

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  int selectedPageIndex = 1;
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
      MaterialPageRoute(builder: (context) => const InvoicesView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesViewModel>.reactive(
      viewModelBuilder: () => SalesViewModel(),
      onModelReady: (model) => () {},
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kcPrimaryColor,
          onPressed: () {},
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
            } else if (index == 2) {
              onExpensesTapped();
            } else if (index == 3) {
              onInvoicingTapped();
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
                    'Recent Sales',
                    style: ktsHeaderText,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcButtonTextColor,
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
                      color: kcButtonTextColor,
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
                      color: kcButtonTextColor,
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
