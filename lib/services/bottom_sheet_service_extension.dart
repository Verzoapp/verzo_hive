import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

class BottomSheetServiceExtension extends BottomSheetService {
  Future<void> showMerchantCreationBottomSheet(
      {required Function(String) onMerchantCreated}) async {
    await showCustomSheet(
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      customData: MerchantCreationForm(onMerchantCreated: onMerchantCreated),
    );
  }
}

class MerchantCreationForm extends StatefulWidget {
  final Function(String) onMerchantCreated;

  const MerchantCreationForm({Key? key, required this.onMerchantCreated})
      : super(key: key);

  @override
  _MerchantCreationFormState createState() => _MerchantCreationFormState();
}

class _MerchantCreationFormState extends State<MerchantCreationForm> {
  final _merchantNameController = TextEditingController();

  @override
  void dispose() {
    _merchantNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _merchantNameController,
              decoration: InputDecoration(
                hintText: 'Merchant Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onMerchantCreated(_merchantNameController.text);
              },
              child: const Text('Create Merchant'),
            ),
          ],
        ),
      ),
    );
  }
}
