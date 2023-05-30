import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './update_invoices_view_model.dart';

class UpdateInvoicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateInvoicesViewModel>.reactive(
      viewModelBuilder: () => UpdateInvoicesViewModel(),
      onModelReady: (UpdateInvoicesViewModel model) async {},
      builder: (
        BuildContext context,
        UpdateInvoicesViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'UpdateInvoicesView',
            ),
          ),
        );
      },
    );
  }
}
