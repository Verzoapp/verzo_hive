// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String DescriptionValueKey = 'description';
const String ReferenceValueKey = 'reference';
const String TransactionDateValueKey = 'transactionDate';
const String MerchantIdValueKey = 'merchantId';

final Map<String, TextEditingController>
    _AddPurchaseOrderViewTextEditingControllers = {};

final Map<String, FocusNode> _AddPurchaseOrderViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _AddPurchaseOrderViewTextValidations = {
  DescriptionValueKey: null,
  ReferenceValueKey: null,
  TransactionDateValueKey: null,
  MerchantIdValueKey: null,
};

mixin $AddPurchaseOrderView on StatelessWidget {
  TextEditingController get descriptionController =>
      _getFormTextEditingController(DescriptionValueKey);
  TextEditingController get referenceController =>
      _getFormTextEditingController(ReferenceValueKey);
  TextEditingController get transactionDateController =>
      _getFormTextEditingController(TransactionDateValueKey);
  TextEditingController get merchantIdController =>
      _getFormTextEditingController(MerchantIdValueKey);
  FocusNode get descriptionFocusNode => _getFormFocusNode(DescriptionValueKey);
  FocusNode get referenceFocusNode => _getFormFocusNode(ReferenceValueKey);
  FocusNode get transactionDateFocusNode =>
      _getFormFocusNode(TransactionDateValueKey);
  FocusNode get merchantIdFocusNode => _getFormFocusNode(MerchantIdValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_AddPurchaseOrderViewTextEditingControllers.containsKey(key)) {
      return _AddPurchaseOrderViewTextEditingControllers[key]!;
    }
    _AddPurchaseOrderViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddPurchaseOrderViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddPurchaseOrderViewFocusNodes.containsKey(key)) {
      return _AddPurchaseOrderViewFocusNodes[key]!;
    }
    _AddPurchaseOrderViewFocusNodes[key] = FocusNode();
    return _AddPurchaseOrderViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    descriptionController.addListener(() => _updateFormData(model));
    referenceController.addListener(() => _updateFormData(model));
    transactionDateController.addListener(() => _updateFormData(model));
    merchantIdController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    descriptionController.addListener(() => _updateFormData(model));
    referenceController.addListener(() => _updateFormData(model));
    transactionDateController.addListener(() => _updateFormData(model));
    merchantIdController.addListener(() => _updateFormData(model));
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
          DescriptionValueKey: descriptionController.text,
          ReferenceValueKey: referenceController.text,
          TransactionDateValueKey: transactionDateController.text,
          MerchantIdValueKey: merchantIdController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        DescriptionValueKey: _getValidationMessage(DescriptionValueKey),
        ReferenceValueKey: _getValidationMessage(ReferenceValueKey),
        TransactionDateValueKey: _getValidationMessage(TransactionDateValueKey),
        MerchantIdValueKey: _getValidationMessage(MerchantIdValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _AddPurchaseOrderViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_AddPurchaseOrderViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _AddPurchaseOrderViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddPurchaseOrderViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AddPurchaseOrderViewTextEditingControllers.clear();
    _AddPurchaseOrderViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get descriptionValue =>
      this.formValueMap[DescriptionValueKey] as String?;
  String? get referenceValue => this.formValueMap[ReferenceValueKey] as String?;
  String? get transactionDateValue =>
      this.formValueMap[TransactionDateValueKey] as String?;
  String? get merchantIdValue =>
      this.formValueMap[MerchantIdValueKey] as String?;

  bool get hasDescription =>
      this.formValueMap.containsKey(DescriptionValueKey) &&
      (descriptionValue?.isNotEmpty ?? false);
  bool get hasReference =>
      this.formValueMap.containsKey(ReferenceValueKey) &&
      (referenceValue?.isNotEmpty ?? false);
  bool get hasTransactionDate =>
      this.formValueMap.containsKey(TransactionDateValueKey) &&
      (transactionDateValue?.isNotEmpty ?? false);
  bool get hasMerchantId =>
      this.formValueMap.containsKey(MerchantIdValueKey) &&
      (merchantIdValue?.isNotEmpty ?? false);

  bool get hasDescriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey]?.isNotEmpty ?? false;
  bool get hasReferenceValidationMessage =>
      this.fieldsValidationMessages[ReferenceValueKey]?.isNotEmpty ?? false;
  bool get hasTransactionDateValidationMessage =>
      this.fieldsValidationMessages[TransactionDateValueKey]?.isNotEmpty ??
      false;
  bool get hasMerchantIdValidationMessage =>
      this.fieldsValidationMessages[MerchantIdValueKey]?.isNotEmpty ?? false;

  String? get descriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey];
  String? get referenceValidationMessage =>
      this.fieldsValidationMessages[ReferenceValueKey];
  String? get transactionDateValidationMessage =>
      this.fieldsValidationMessages[TransactionDateValueKey];
  String? get merchantIdValidationMessage =>
      this.fieldsValidationMessages[MerchantIdValueKey];
}

extension Methods on FormViewModel {
  setDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DescriptionValueKey] = validationMessage;
  setReferenceValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ReferenceValueKey] = validationMessage;
  setTransactionDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TransactionDateValueKey] =
          validationMessage;
  setMerchantIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[MerchantIdValueKey] = validationMessage;
}
