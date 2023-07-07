import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/helpers/balance_json.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view.dart';
import 'package:verzo_one/ui/expenses/expenses_view.dart';
import 'package:verzo_one/ui/invoicing/invoicing_view.dart';
import 'package:verzo_one/ui/sales/categories.dart';
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
    var size = MediaQuery.of(context).size;
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
                  BottomNavigationBarItem(
                      icon: Icon(Icons.sell), label: 'Sales'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: 'Expenses'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.receipt_long), label: 'Incoicing')
                ],
              ),
              // appBar: AppBar(
              //   backgroundColor: Colors.white,
              //   elevation: 0,
              //   leading: IconButton(
              //     icon: Icon(
              //       Icons.arrow_back,
              //       color: kcPrimaryColor,
              //     ),
              //     onPressed: () {},
              //   ),
              //   actions: <Widget>[
              //     IconButton(
              //       icon: Icon(
              //         Icons.search,
              //         color: kcPrimaryColor,
              //       ),
              //       onPressed: () {},
              //     ),
              //     IconButton(
              //       icon: Icon(
              //         Icons.shopping_cart,
              //         color: kcPrimaryColor,
              //       ),
              //       onPressed: () {},
              //     ),
              //     // SizedBox(width: kDefaultPaddin / 2)
              //   ],
              // ),
              // body: SingleChildScrollView(
              //   scrollDirection: Axis.vertical,
              //   child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Padding(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 20, vertical: 20),
              //           child: Text(
              //             "Women",
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .headline5!
              //                 .copyWith(fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         Categories(),
              //         rowey(),
              //         verticalSpaceTiny,
              //         rowey(),
              //         verticalSpaceTiny,
              //         rowey()
            ));
  }
}

// class rowey extends StatelessWidget {
//   const rowey({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(20),
//                 height: 180,
//                 width: 180,
//                 decoration: BoxDecoration(
//                   color: kcPrimaryColor,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: SvgPicture.asset(
//                   'assets/images/Screenshot 2023-04-16 at 10.30.01.png',
//                 ),
//               ),
//               verticalSpaceTiny,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Office Code',
//                       style: ktsBodyTextLight,
//                     ),
//                     Text(
//                       'N234000',
//                       style: ktsBodyTextBold,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(20),
//                 height: 180,
//                 width: 180,
//                 decoration: BoxDecoration(
//                   color: kcPrimaryColor,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//               verticalSpaceTiny,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Office Code',
//                       style: ktsBodyTextLight,
//                     ),
//                     Text(
//                       'N234000',
//                       style: ktsBodyTextBold,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
