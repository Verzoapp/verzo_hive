import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view_model.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      onModelReady: (model) => () {},
      builder: (context, model, child) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: kcPrimaryColor,
            iconSize: 24,
            showUnselectedLabels: true,
            unselectedItemColor: kcTextColorLight,
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
            ]),
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
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            color: kcTextColorLight,
                            borderRadius: defaultCarouselBorderRadius),
                        width: 240,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.sell,
                                  size: 16,
                                ),
                                horizontalSpaceTiny,
                                Text(style: ktsBodyText2, 'Sales'),
                              ],
                            ),
                            verticalSpaceIntermitent,
                            Text(
                              'N500,000',
                              style: ktsHeroText,
                            ),
                            LineChart(LineChartData(
                                borderData: FlBorderData(show: false),
                                gridData: FlGridData(
                                    show: false,
                                    drawVerticalLine: false,
                                    horizontalInterval: 2))),
                          ],
                        ),
                      ),
                    ),
                    horizontalSpaceSmall,
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            color: kcTextColorLight,
                            borderRadius: defaultCarouselBorderRadius),
                        width: 240,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.shopping_cart,
                                  size: 16,
                                ),
                                horizontalSpaceTiny,
                                Text(style: ktsBodyText2, 'Expenses'),
                              ],
                            ),
                            verticalSpaceIntermitent,
                            Text(
                              'N500,000',
                              style: ktsHeroText,
                            ),
                          ],
                        ),
                      ),
                    ),
                    horizontalSpaceSmall,
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            color: kcTextColorLight,
                            borderRadius: defaultCarouselBorderRadius),
                        width: 240,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.receipt_long,
                                  size: 16,
                                ),
                                horizontalSpaceTiny,
                                Text(style: ktsBodyText2, 'Invoices'),
                              ],
                            ),
                            verticalSpaceIntermitent,
                            Text(
                              'N500,000',
                              style: ktsHeroText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpaceLarge,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest Activity',
                    style: ktsHeaderText,
                  ),
                  SizedBox(
                    width: 500,
                    child: DataTable(columnSpacing: 10, columns: const [
                      DataColumn(
                        label: Text("s/n"),
                      ),
                      DataColumn(
                        label: Text("File Name"),
                      ),
                      DataColumn(
                        label: Text("Date"),
                      ),
                      DataColumn(
                        label: Text("Size"),
                      ),
                    ], rows: const [
                      DataRow(
                        cells: [
                          DataCell(
                            Icon(
                              Icons.receipt_long,
                              size: 16,
                            ),
                          ),
                          DataCell(
                            Text('Verzo One'),
                          ),
                          DataCell(
                            Text('N35,000'),
                          ),
                          DataCell(Text('11 Sep 2022')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Icon(
                              Icons.receipt_long,
                              size: 16,
                            ),
                          ),
                          DataCell(Text('Verzo One')),
                          DataCell(
                            Text('N35,000'),
                          ),
                          DataCell(Text('11 Sep 2022')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Icon(
                              Icons.receipt_long,
                              size: 16,
                            ),
                          ),
                          DataCell(Text('Verzo One')),
                          DataCell(
                            Text('N35,000'),
                          ),
                          DataCell(Text('11 Sep 2022')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Icon(
                              Icons.receipt_long,
                              size: 16,
                            ),
                          ),
                          DataCell(Text('Verzo One')),
                          DataCell(
                            Text('N35,000'),
                          ),
                          DataCell(Text('11 Sep 2022')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Icon(
                              Icons.receipt_long,
                              size: 16,
                            ),
                          ),
                          DataCell(Text('Verzo One')),
                          DataCell(
                            Text('N35,000'),
                          ),
                          DataCell(Text('11 Sep 2022')),
                        ],
                      ),
                    ]),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



/////
//BarChart(BarChartData(
//                  alignment: BarChartAlignment.center,
//                  maxY: 20,
//                  minY: 5,
  //                baselineY: 0,
    //              groupsSpace: 12,
      //            barTouchData: BarTouchData(enabled: true),
        //          titlesData: FlTitlesData(
          //          bottomTitles: AxisTitles(
            //          sideTitles: SideTitles(
              //          reservedSize: 6,
                //        showTitles: true,
                  //      getTitlesWidget: (double value, TitleMeta meta) {
                    //      switch (value.toInt()) {
                      //      case 0:
                        //      return Text('MON');
                          //  case 1:
                            //  return Text('TUE');
 //                           case 2:
   //                           return Text('WED');
     //                       case 3:
       //                       return Text('THUR');
//                            case 4:
  //                            return Text('FRI');
    //                        case 5:
      //                        return Text('SAT');
        //                    case 6:
          //                    return Text('SUN');
            //                default:
              //                return Text('');
                //          }
                  //      },
                    //  ),
//                    ),
  //                ),
    //              barGroups: [
      //              BarChartGroupData(x: 0, barRods: [
        //              BarChartRodData(toY: 20, color: kcPrimaryColor)
          //          ]),
            //        BarChartGroupData(x: 1, barRods: [
              //        BarChartRodData(toY: 7, color: kcPrimaryColor)
                //    ]),
                  //  BarChartGroupData(x: 2, barRods: [
                    //  BarChartRodData(toY: 15, color: kcPrimaryColor)
 //                   ]),
   //                 BarChartGroupData(x: 3, barRods: [
     //                 BarChartRodData(toY: 2, color: kcPrimaryColor)
       //             ]),
         //           BarChartGroupData(x: 4, barRods: [
           //           BarChartRodData(toY: 2, color: kcPrimaryColor)
             //       ]),
               //     BarChartGroupData(x: 5, barRods: [
                 //     BarChartRodData(toY: 17, color: kcPrimaryColor)
                   // ]),
   //                 BarChartGroupData(x: 6, barRods: [
 //                     BarChartRodData(toY: 12, color: kcPrimaryColor)
     //               ]),
   //               ])),
