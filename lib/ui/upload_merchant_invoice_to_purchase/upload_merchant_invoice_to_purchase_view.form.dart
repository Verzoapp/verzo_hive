// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String InvoiceDateValueKey = 'invoiceDate';

final Map<String, TextEditingController>
    _UploadMerchantInvoiceToPurchaseViewTextEditingControllers = {};

final Map<String, FocusNode> _UploadMerchantInvoiceToPurchaseViewFocusNodes =
    {};

final Map<String, String? Function(String?)?>
    _UploadMerchantInvoiceToPurchaseViewTextValidations = {
  InvoiceDateValueKey: null,
};

mixin $UploadMerchantInvoiceToPurchaseView on StatelessWidget {
  TextEditingController get invoiceDateController =>
      _getFormTextEditingController(InvoiceDateValueKey);
  FocusNode get invoiceDateFocusNode => _getFormFocusNode(InvoiceDateValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_UploadMerchantInvoiceToPurchaseViewTextEditingControllers.containsKey(
        key)) {
      return _UploadMerchantInvoiceToPurchaseViewTextEditingControllers[key]!;
    }
    _UploadMerchantInvoiceToPurchaseViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _UploadMerchantInvoiceToPurchaseViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_UploadMerchantInvoiceToPurchaseViewFocusNodes.containsKey(key)) {
      return _UploadMerchantInvoiceToPurchaseViewFocusNodes[key]!;
    }
    _UploadMerchantInvoiceToPurchaseViewFocusNodes[key] = FocusNode();
    return _UploadMerchantInvoiceToPurchaseViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    invoiceDateController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    invoiceDateController.addListener(() => _updateFormData(model));
  }

  final bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          InvoiceDateValueKey: invoiceDateController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        InvoiceDateValueKey: _getValidationMessage(InvoiceDateValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey =
        _UploadMerchantInvoiceToPurchaseViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey = validatorForKey(
        _UploadMerchantInvoiceToPurchaseViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller
        in _UploadMerchantInvoiceToPurchaseViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode
        in _UploadMerchantInvoiceToPurchaseViewFocusNodes.values) {
      focusNode.dispose();
    }

    _UploadMerchantInvoiceToPurchaseViewTextEditingControllers.clear();
    _UploadMerchantInvoiceToPurchaseViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get invoiceDateValue =>
      this.formValueMap[InvoiceDateValueKey] as String?;

  bool get hasInvoiceDate =>
      this.formValueMap.containsKey(InvoiceDateValueKey) &&
      (invoiceDateValue?.isNotEmpty ?? false);

  bool get hasInvoiceDateValidationMessage =>
      this.fieldsValidationMessages[InvoiceDateValueKey]?.isNotEmpty ?? false;

  String? get invoiceDateValidationMessage =>
      this.fieldsValidationMessages[InvoiceDateValueKey];
}

extension Methods on FormViewModel {
  setInvoiceDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[InvoiceDateValueKey] = validationMessage;
}
