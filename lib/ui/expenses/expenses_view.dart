import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view.dart';
import 'package:verzo_one/ui/expenses/expenses_view_model.dart';
import 'package:verzo_one/ui/invoicing/invoicing_view.dart';
import 'package:verzo_one/ui/sales/sales_view.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  final navigationService = locator<NavigationService>();

  int selectedPageIndex = 2;
  void onHomeTapped() {
    setState(() {
      selectedPageIndex = 0;
    });
    navigationService.replaceWith(Routes.dashboardRoute);
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
    return ViewModelBuilder<ExpensesViewModel>.reactive(
        viewModelBuilder: () => ExpensesViewModel(),
        onModelReady: (model) async {
          model.addNewExpense;
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
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: kcPrimaryColor,
              onPressed: () {
                navigationService.navigateTo(Routes.addExpenseRoute);
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
                      icon: Icon(Icons.receipt_long), label: 'Incoicing')
                ]),
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
                        'Recent Expenses',
                        style: ktsHeaderText,
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  if (model.expenses.isEmpty)
                    const Text('No Expense')
                  else
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: true,
                      shrinkWrap: true,
                      itemCount: model.expenses.length + (model.isBusy ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == model.expenses.length) {
                          return const CircularProgressIndicator();
                        } else {
                          return ExpenseCard(expenses: model.expenses[index]!);
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return verticalSpaceTiny;
                      },
                    ),
                  // PagedListView<int, Expenses>(
                  //   shrinkWrap: true,
                  //   primary: false,
                  //   pagingController: model.data!,
                  //   builderDelegate: PagedChildBuilderDelegate<Expenses>(
                  //     itemBuilder: (context, expenses, index) {
                  //       return ExpenseCard(expenses: expenses);
                  //     },
                  //     firstPageProgressIndicatorBuilder: (context) {
                  //       return const CircularProgressIndicator();
                  //     },
                  //     newPageProgressIndicatorBuilder: (context) {
                  //       return const CircularProgressIndicator();
                  //     },
                  //     noItemsFoundIndicatorBuilder: (context) {
                  //       return const Text('No Expense');
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }
}

class ExpenseCard extends StatelessWidget {
  ExpenseCard({Key? key, required this.expenses}) : super(key: key);
  final navigationService = locator<NavigationService>();

  final Expenses expenses;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: defaultTagBorderRadius),
      tileColor: kcStrokeColor,
      title: Text(
        expenses.description,
        style: ktsBodyText,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        expenses.expenseDate,
        style: ktsBodyTextLight,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            NumberFormat.currency(locale: 'en', symbol: '\N')
                .format(expenses.amount),
            style: ktsBodyText,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              navigationService.navigateTo(Routes.updateExpenseRoute);
            },
          ),
        ],
      ),
    );
  }
}






// Text(
//                     expenses.description,
//                     style: ktsBodyText,
//                   ),
//                   Text(
//                     'expenses.createdAt',
//                     style: ktsBodyTextLight,
//                   ),
//                 ],
//               ),
//               Text(
//                 NumberFormat.currency(locale: 'en_NG', symbol: '\$')
//                     .format(expenses.amount),
//                 style: ktsBodyText,
//               )