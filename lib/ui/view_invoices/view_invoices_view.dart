import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';
// import 'package:pdf/widgets.dart' as pw;

import './view_invoices_view_model.dart';

class ViewInvoicesView extends StatelessWidget {
  final Invoices selectedInvoice;

  ViewInvoicesView({Key? key, required this.selectedInvoice});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewInvoicesViewModel>.reactive(
      viewModelBuilder: () => ViewInvoicesViewModel(invoice: selectedInvoice),
      onModelReady: (ViewInvoicesViewModel model) async {
        // await model.generateInvoicePdf(selectedInvoice);
      },
      builder: (
        BuildContext context,
        ViewInvoicesViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            body: AuthenticationLayout(
                busy: model.isBusy,
                title: 'View Invoice',
                subtitle:
                    'This information will be displayed publicly so be careful what you share.',
                mainButtonTitle: 'Done',
                onMainButtonTapped: model.navigateBack,
                secondaryButtonTitle: 'Send',
                onSecondaryButtonTapped: () {},
                form: Column(
                  children: [
                    // Use the printout view created in the ViewModel
                    RepaintBoundary(
                      child: model.buildPrintableView(),
                    ),
                    // Add buttons for saving to PDF and sending if needed
                  ],
                )

                // Column(
                //   children: [
                //     TextFormField(
                //       readOnly: true,
                //       decoration: InputDecoration(
                //           labelText: 'Due Date',
                //           labelStyle: ktsFormText,
                //           border: defaultFormBorder),
                //       keyboardType: TextInputType.datetime,
                //       initialValue: selectedInvoice.dueDate,
                //     ),
                //     verticalSpaceSmall,
                //     TextFormField(
                //       readOnly: true,
                //       decoration: InputDecoration(
                //           labelText: 'Date Of Issue',
                //           labelStyle: ktsFormText,
                //           border: defaultFormBorder),
                //       keyboardType: TextInputType.datetime,
                //       initialValue: model.invoice.dateOfIssue,
                //     ),
                //     verticalSpaceTiny,
                //     Card(
                //         child: ListTile(
                //       title: Text('Customer', style: ktsBodyTextBold),
                //       subtitle: Text(
                //         model.invoice.customerName,
                //         style: ktsBodyText,
                //       ),
                //     )),
                //     verticalSpaceTiny,
                //     Card(
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 16),
                //         child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.stretch,
                //             children: [
                //               Text(
                //                 'Items',
                //                 style: ktsBodyTextBold,
                //               ),
                //               verticalSpaceTiny,
                //               // if (model.selectedItems.isNotEmpty)
                //               //   ...model.selectedItems.map((item) => ListTile(
                //               //         title: Text(item.title),
                //               //         subtitle: Row(
                //               //           mainAxisAlignment: MainAxisAlignment.start,
                //               //           children: [
                //               //             Text(
                //               //               NumberFormat.currency(
                //               //                       locale: 'en', symbol: '\N')
                //               //                   .format(item.price),
                //               //               style: ktsBodyText,
                //               //             ),
                //               //             horizontalSpaceSmall,
                //               //             if (item.type == 'P')
                //               //               Text('Qty: ${item.quantity}'),
                //               //           ],
                //               //         ),
                //               //         trailing: Row(
                //               //           mainAxisSize: MainAxisSize.min,
                //               //           children: [
                //               //             IconButton(
                //               //               icon: const Icon(Icons.edit),
                //               //               onPressed: () {
                //               //                 model.openEditBottomSheet(item);
                //               //               },
                //               //             ),
                //               //             IconButton(
                //               //               icon: const Icon(Icons.delete),
                //               //               onPressed: () {
                //               //                 model.removeSelectedItem(item);
                //               //               },
                //               //             ),
                //               //           ],
                //               //         ),
                //               //       )),
                //             ]),
                //       ),
                //     ),
                //     verticalSpaceTiny,
                //     Card(
                //       margin: const EdgeInsets.all(6),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.stretch,
                //           children: [
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text(
                //                   'SubTotal',
                //                   style: ktsBodyTextLight,
                //                 ),
                //                 Text(
                //                   'N${model.invoice.subtotal.toStringAsFixed(2)}',
                //                   style: ktsBodyTextLight,
                //                 ),
                //               ],
                //             ),
                //             verticalSpaceTiny,
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text(
                //                   'Discount (Optional)',
                //                   style: ktsBodyTextLight,
                //                 ),
                //                 SizedBox(
                //                   width: 65,
                //                   child: Expanded(
                //                     child: TextFormField(
                //                       readOnly: true,
                //                       decoration: const InputDecoration(
                //                           prefixText: '-', suffixText: '%'),
                //                       initialValue: model.invoice.discount.toString(),
                //                       keyboardType:
                //                           const TextInputType.numberWithOptions(
                //                               decimal: true),
                //                       textAlign: TextAlign.right,
                //                       style: ktsBodyTextLight,
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             verticalSpaceTiny,
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text(
                //                   'Tax',
                //                   style: ktsBodyTextLight,
                //                 ),
                //                 SizedBox(
                //                   width: 65,
                //                   child: Expanded(
                //                     child: TextFormField(
                //                       readOnly: true,
                //                       decoration: const InputDecoration(
                //                           prefixText: '+', suffixText: '%'),
                //                       initialValue: selectedInvoice.VAT.toString(),
                //                       keyboardType:
                //                           const TextInputType.numberWithOptions(
                //                               decimal: true),
                //                       textAlign: TextAlign.right,
                //                       style: ktsBodyTextLight,
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             Divider(),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text(
                //                   'Total',
                //                   style: ktsHeaderText,
                //                 ),
                //                 Text(
                //                   'N${model.invoice.totalAmount.toStringAsFixed(2)}',
                //                   style: ktsHeaderText,
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                ));
      },
    );
  }
}
