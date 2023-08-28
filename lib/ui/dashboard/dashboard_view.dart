import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/helpers/balance_json.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/ui/customers/customers_view.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view_model.dart';
import 'package:verzo_one/ui/expenses/expenses_view.dart';
import 'package:verzo_one/ui/invoicing/invoicing_view.dart';
import 'package:verzo_one/ui/products_services/products_services_view.dart';
import 'package:verzo_one/ui/purchase_order/purchase_order_view.dart';
import 'package:verzo_one/ui/sales/sales_view.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedPageIndex = 0;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

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

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ViewModelBuilder<DashboardViewModel>.reactive(
        viewModelBuilder: () => DashboardViewModel(),
        onModelReady: (model) async {
          await model.loadDataOnce();
        },
        builder: (
          BuildContext context,
          DashboardViewModel model,
          Widget? child,
        ) {
          if (model.isBusy) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            key: globalKey,
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                fixedColor: kcPrimaryColor,
                iconSize: 24,
                showUnselectedLabels: true,
                unselectedItemColor: kcTextColorLight,
                currentIndex: selectedPageIndex,
                onTap: (index) {
                  if (index == 1) {
                    onSalesTapped();
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
                  BottomNavigationBarItem(
                      icon: Icon(Icons.sell), label: 'Sales'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: 'Expenses'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.receipt_long), label: 'Invoicing')
                ]),
            drawer: Drawer(
              elevation: 100,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: kcPrimaryColor,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 36,
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Tam',
                          style: ktsHeaderTextWhite,
                        ),
                        // Text(
                        //   'mem4real@gmail.com',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 24,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home,
                    ),
                    title: Text('Home'),
                    onTap: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const DashboardView(),
                    )),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.people,
                    ),
                    title: Text('Customers'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomersView(),
                    )),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.people,
                    ),
                    title: Text('Purchases'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PurchaseOrderView(),
                    )),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.assignment,
                    ),
                    title: Text('Products & Services'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductsServicesView(),
                    )),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () async {
                        model.logout();
                      }),
                ],
              ),
            ),
            body: Container(
              color: kcPrimaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceMedium,
                  IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    icon: const Icon(
                      Icons.menu,
                      size: 32,
                    ),
                    color: kcButtonTextColor,
                    onPressed: () {
                      globalKey.currentState?.openDrawer();
                    },
                  ),
                  verticalSpaceSmall,
                  Container(
                      width: double.infinity,
                      height: size.height * 0.2,
                      decoration: const BoxDecoration(color: kcPrimaryColor),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 42,
                            child: TabBar(
                              indicatorPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                  color: kcStrokeColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              tabs: const [
                                Tab(
                                  text: 'Last 7 Days',
                                ),
                                Tab(
                                  text: 'Last 30 Days',
                                ),
                              ],
                              controller: tabController,
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                                controller: tabController,
                                children: [
                                  ListView(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      children: [
                                        Displayscreen(
                                          size: size,
                                          amount: model.expenseForWeek
                                              ?.totalExpenseAmountThisWeek,
                                          percentage: model.expenseForWeek
                                              ?.percentageIncreaseInExpenseThisWeek,
                                          title: 'Expenses',
                                        ),
                                        Displayscreen(
                                          size: size,
                                          amount: model.weeklyInvoices
                                              ?.totalOverDueInvoiceAmountThisWeek,
                                          percentage: model.weeklyInvoices
                                              ?.percentageIncreaseInOverdueInvoicesThisWeek,
                                          title: 'Overdue Invoices',
                                        ),
                                        Displayscreen(
                                          size: size,
                                          amount: model.weeklyInvoices
                                              ?.totalPendingInvoiceAmountThisWeek,
                                          percentage: model.weeklyInvoices
                                              ?.percentageIncreaseInPendingInvoiceThisWeek,
                                          title: 'Outstanding Invoices',
                                        ),
                                        Displayscreen(
                                          size: size,
                                          amount: model.weeklyInvoices
                                              ?.totalInvoiceAmountForWeek,
                                          percentage: model.weeklyInvoices
                                              ?.percentageOfPaidInvoices,
                                          title: 'Revenue',
                                        ),
                                        Displayscreen(
                                          size: size,
                                          amount: model.purchaseForWeek
                                              ?.totalPurchaseAmountThisWeek,
                                          // percentage: model.weeklyInvoices
                                          //     ?.percentageOfPaidInvoices,
                                          title: 'Purchases',
                                        )
                                      ]),
                                  ListView(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      children: [
                                        Displayscreen(
                                          size: size,
                                          amount: model.expenseForMonth
                                              ?.totalExpenseAmountThisMonth,
                                          percentage: model.expenseForMonth
                                              ?.percentageIncreaseInExpenseThisMonth,
                                          title: 'Expenses',
                                        ),
                                        Displayscreen(
                                          size: size,
                                          amount: model.monthlyInvoices
                                              ?.totalOverDueInvoiceAmountThisMonth,
                                          percentage: model.monthlyInvoices
                                              ?.percentageIncreaseInOverdueInvoicesThisMonth,
                                          title: 'Overdue Invoices',
                                        ),
                                        Displayscreen(
                                          size: size,
                                          amount: model.monthlyInvoices
                                              ?.totalPendingInvoiceAmountThisMonth,
                                          percentage: model.monthlyInvoices
                                              ?.percentageIncreaseInPendingInvoiceThisMonth,
                                          title: 'Outstanding Invoices',
                                        ),
                                        Displayscreen(
                                          size: size,
                                          amount: model.monthlyInvoices
                                              ?.totalInvoiceAmountForMonth,
                                          percentage: model.monthlyInvoices
                                              ?.percentageOfPaidInvoicesForMonth,
                                          title: 'Revenue',
                                        ),
                                        Displayscreen(
                                          size: size,
                                          amount: model.purchaseForMonth
                                              ?.totalPurchaseAmountThisMonth,
                                          // percentage: model.expenseForMonth
                                          //     ?.percentageIncreaseInExpenseThisMonth,
                                          title: 'Purchases',
                                        ),
                                      ]),
                                ]),
                          )
                        ],
                      )),
                  verticalSpaceIntermitent,
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: kcButtonTextColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 25, bottom: 50, left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recent Expenses",
                                // style: TextStyle(
                                //     fontSize: 17, fontWeight: FontWeight.bold),
                                style: ktsTitleText,
                              ),
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
                                child: Builder(builder: (context) {
                                  if (model.isBusy) {
                                    return const CircularProgressIndicator(
                                      color: kcPrimaryColor,
                                    );
                                  }
                                  if (model.expenses == null) {
                                    return const Text('No Expenses');
                                  }
                                  return ListView.separated(
                                    padding: const EdgeInsets.all(12),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: model.expenses.length,
                                    itemBuilder: (context, index) {
                                      var expense = model.expenses[index];
                                      return ExpenseCard(expense: expense);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: const [
                                          verticalSpaceTiny,
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: Divider(
                                              thickness: 0.4,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                              ),
                              verticalSpaceIntermitent,
                              Text(
                                "Recent Invoices",
                                // style: TextStyle(
                                //     fontSize: 17, fontWeight: FontWeight.bold),
                                style: ktsTitleText,
                              ),
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
                                child: Builder(builder: (context) {
                                  if (model.isBusy) {
                                    return const CircularProgressIndicator(
                                      color: kcPrimaryColor,
                                    );
                                  }
                                  if (model.invoices == null) {
                                    return const Text('No Customers');
                                  }
                                  return ListView.separated(
                                    padding: const EdgeInsets.all(18),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: model.invoices.length,
                                    itemBuilder: (context, index) {
                                      var invoice = model.invoices[index];
                                      return InvoiceCard(invoice: invoice);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: const [
                                          verticalSpaceTiny,
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: Divider(
                                              thickness: 0.4,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                              ),
                              verticalSpaceIntermitent,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Recent Customers",
                                    style: ktsTitleText,
                                    // style: TextStyle(
                                    //     fontSize: 17,
                                    //     fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              verticalSpaceSmall,
                              Builder(builder: (context) {
                                if (model.isBusy) {
                                  return const CircularProgressIndicator(
                                    color: kcPrimaryColor,
                                  );
                                }
                                if (model.customers == null) {
                                  return const Text('No Customers');
                                }
                                return SizedBox(
                                  height: 160,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: model.customers.length,
                                    itemBuilder: (context, index) {
                                      var customer = model.customers[index];
                                      return CustomerCard(customer: customer);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: const [
                                          horizontalSpaceTiny,
                                        ],
                                      );
                                    },
                                  ),
                                );
                              }),
                              verticalSpaceIntermitent,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Overdue Invoices",
                                    style: ktsTitleText,
                                    // style: TextStyle(
                                    //     fontSize: 17,
                                    //     fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              verticalSpaceSmall,
                              Builder(builder: (context) {
                                if (model.isBusy) {
                                  return const CircularProgressIndicator(
                                    color: kcPrimaryColor,
                                  );
                                }
                                if (model.overdueInvoices == null) {
                                  return const Text('No Overdue Invoices');
                                }
                                return SizedBox(
                                  height: 160,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: model.overdueInvoices.length,
                                    itemBuilder: (context, index) {
                                      var overdueInvoice =
                                          model.overdueInvoices[index];
                                      return OverdueInvoiceCard(
                                          overdueInvoice: overdueInvoice);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: const [
                                          horizontalSpaceTiny,
                                        ],
                                      );
                                    },
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class Displayscreen extends StatelessWidget {
  const Displayscreen({
    Key? key,
    required this.size,
    this.amount,
    required this.title,
    this.percentage,
  }) : super(key: key);

  final Size size;
  final num? amount;
  final String title;
  final num? percentage;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: Platform.localeName,
      name: 'NGN',
      symbol: '₦',
    );
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        width: size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${percentage ?? 0}%',
                  style: ktsBodyText2,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  '${currency.format(amount ?? 0)}',
                  style: ktsHeroTextWhite,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: kcButtonTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceCard extends StatelessWidget {
  InvoiceCard({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final navigationService = locator<NavigationService>();
  final Invoices invoice;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationService.navigateToViewInvoiceRoute(selectedInvoice: invoice);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice!.customerName,
                    style: ktsBodyTextBoldOpaque,
                  ),
                  // verticalSpaceMinute,
                  Text(
                    invoice!.dateOfIssue,
                    style: ktsBodyTextLight,
                  ),
                ],
              )
            ],
          ),
          Text(
            NumberFormat.currency(locale: 'en', symbol: 'N')
                .format(invoice!.totalAmount),
            style: ktsBodyTextBoldOpaque,
          ),
        ],
      ),
    );
  }
}

class ExpenseCard extends StatelessWidget {
  ExpenseCard({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final navigationService = locator<NavigationService>();

  final Expenses expense;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationService.navigateToViewExpenseRoute(selectedExpense: expense);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.description,
                    style: ktsBodyTextBoldOpaque,
                  ),
                  // verticalSpaceMinute,
                  Text(
                    expense.expenseDate,
                    style: ktsBodyTextLight,
                  ),
                ],
              )
            ],
          ),
          Text(
            NumberFormat.currency(locale: 'en', symbol: 'N')
                .format(expense!.amount),
            style: ktsBodyTextBoldOpaque,
          ),
        ],
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  const CustomerCard({
    Key? key,
    required this.customer,
  }) : super(key: key);

  final Customers? customer;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kcStrokeColor, width: 0)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customer!.name,
                style: ktsBodyTextBoldOpaque,
                // overflow: TextOverflow.ellipsis,
                // maxLines: 1,
              ),
              Spacer(),
              Text(
                'N12,660.00',
                style: ktsBodyTextx,
              ),
              Spacer(),
              Text(
                customer!.email,
                style: ktsSmallBodyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OverdueInvoiceCard extends StatelessWidget {
  const OverdueInvoiceCard({Key? key, required this.overdueInvoice})
      : super(key: key);

  final Invoices? overdueInvoice;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kcStrokeColor, width: 0)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overdueInvoice!.customerName,
                style: ktsBodyTextBoldOpaque,
              ),
              Spacer(),
              Text(
                overdueInvoice!.dueDate,
                style: ktsBodyTextx,
              ),
              Text(
                'Due Date',
                style: ktsSmallBodyText,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: kcButtonTextColor,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: Colors.redAccent.withOpacity(0.6),
                              width: 1)),
                      width: 70,
                      height: 24,
                      child: Text(
                        'Over 24hrs',
                        style: ktsSmallBodyText,
                      )),
                  // PhosphorIcon(
                  //   PhosphorIcons.thin.arrowCircleRight,
                  //   color: kcTextColorLight,
                  // )
                  // Icon(
                  //   Icons.arrow_circle_right_outlined,
                  //   color: kcTextColorLight,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//  Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Recent Customers",
//                                 style: TextStyle(
//                                     fontSize: 17, fontWeight: FontWeight.bold),
//                               ),
//                               // Container(
//                               //   width: 120,
//                               //   height: 22,
//                               //   decoration: BoxDecoration(
//                               //       color: kcButtonTextColor.withOpacity(0.5),
//                               //       borderRadius: BorderRadius.circular(8)),
//                               //   child: Row(
//                               //     mainAxisAlignment: MainAxisAlignment.center,
//                               //     children: [
//                               //       Icon(
//                               //         Icons.add,
//                               //         size: 16,
//                               //         color: kcPrimaryColor,
//                               //       ),
//                               //       Text(
//                               //         "ADD CUSTOMER",
//                               //         style: TextStyle(
//                               //             fontSize: 11,
//                               //             fontWeight: FontWeight.w600,
//                               //             color: kcPrimaryColor),
//                               //       )
//                               //     ],
//                               //   ),
//                               // )
//                             ],
//                           ),