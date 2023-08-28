// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String PaymentDescriptionValueKey = 'paymentDescription';
const String PaymentReferenceValueKey = 'paymentReference';
const String PaymentTransactionDateValueKey = 'paymentTransactionDate';
const String PaymentTotalValueKey = 'paymentTotal';

final Map<String, TextEditingController>
    _MakePurchasePaymentViewTextEditingControllers = {};

final Map<String, FocusNode> _MakePurchasePaymentViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _MakePurchasePaymentViewTextValidations = {
  PaymentDescriptionValueKey: null,
  PaymentReferenceValueKey: null,
  PaymentTransactionDateValueKey: null,
  PaymentTotalValueKey: null,
};

mixin $MakePurchasePaymentView on StatelessWidget {
  TextEditingController get paymentDescriptionController =>
      _getFormTextEditingController(PaymentDescriptionValueKey);
  TextEditingController get paymentReferenceController =>
      _getFormTextEditingController(PaymentReferenceValueKey);
  TextEditingController get paymentTransactionDateController =>
      _getFormTextEditingController(PaymentTransactionDateValueKey);
  TextEditingController get paymentTotalController =>
      _getFormTextEditingController(PaymentTotalValueKey);
  FocusNode get paymentDescriptionFocusNode =>
      _getFormFocusNode(PaymentDescriptionValueKey);
  FocusNode get paymentReferenceFocusNode =>
      _getFormFocusNode(PaymentReferenceValueKey);
  FocusNode get paymentTransactionDateFocusNode =>
      _getFormFocusNode(PaymentTransactionDateValueKey);
  FocusNode get paymentTotalFocusNode =>
      _getFormFocusNode(PaymentTotalValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_MakePurchasePaymentViewTextEditingControllers.containsKey(key)) {
      return _MakePurchasePaymentViewTextEditingControllers[key]!;
    }
    _MakePurchasePaymentViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _MakePurchasePaymentViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_MakePurchasePaymentViewFocusNodes.containsKey(key)) {
      return _MakePurchasePaymentViewFocusNodes[key]!;
    }
    _MakePurchasePaymentViewFocusNodes[key] = FocusNode();
    return _MakePurchasePaymentViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    paymentDescriptionController.addListener(() => _updateFormData(model));
    paymentReferenceController.addListener(() => _updateFormData(model));
    paymentTransactionDateController.addListener(() => _updateFormData(model));
    paymentTotalController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    paymentDescriptionController.addListener(() => _updateFormData(model));
    paymentReferenceController.addListener(() => _updateFormData(model));
    paymentTransactionDateController.addListener(() => _updateFormData(model));
    paymentTotalController.addListener(() => _updateFormData(model));
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
          PaymentDescriptionValueKey: paymentDescriptionController.text,
          PaymentReferenceValueKey: paymentReferenceController.text,
          PaymentTransactionDateValueKey: paymentTransactionDateController.text,
          PaymentTotalValueKey: paymentTotalController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        PaymentDescriptionValueKey:
            _getValidationMessage(PaymentDescriptionValueKey),
        PaymentReferenceValueKey:
            _getValidationMessage(PaymentReferenceValueKey),
        PaymentTransactionDateValueKey:
            _getValidationMessage(PaymentTransactionDateValueKey),
        PaymentTotalValueKey: _getValidationMessage(PaymentTotalValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _MakePurchasePaymentViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey = validatorForKey(
        _MakePurchasePaymentViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller
        in _MakePurchasePaymentViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _MakePurchasePaymentViewFocusNodes.values) {
      focusNode.dispose();
    }

    _MakePurchasePaymentViewTextEditingControllers.clear();
    _MakePurchasePaymentViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get paymentDescriptionValue =>
      this.formValueMap[PaymentDescriptionValueKey] as String?;
  String? get paymentReferenceValue =>
      this.formValueMap[PaymentReferenceValueKey] as String?;
  String? get paymentTransactionDateValue =>
      this.formValueMap[PaymentTransactionDateValueKey] as String?;
  String? get paymentTotalValue =>
      this.formValueMap[PaymentTotalValueKey] as String?;

  bool get hasPaymentDescription =>
      this.formValueMap.containsKey(PaymentDescriptionValueKey) &&
      (paymentDescriptionValue?.isNotEmpty ?? false);
  bool get hasPaymentReference =>
      this.formValueMap.containsKey(PaymentReferenceValueKey) &&
      (paymentReferenceValue?.isNotEmpty ?? false);
  bool get hasPaymentTransactionDate =>
      this.formValueMap.containsKey(PaymentTransactionDateValueKey) &&
      (paymentTransactionDateValue?.isNotEmpty ?? false);
  bool get hasPaymentTotal =>
      this.formValueMap.containsKey(PaymentTotalValueKey) &&
      (paymentTotalValue?.isNotEmpty ?? false);

  bool get hasPaymentDescriptionValidationMessage =>
      this.fieldsValidationMessages[PaymentDescriptionValueKey]?.isNotEmpty ??
      false;
  bool get hasPaymentReferenceValidationMessage =>
      this.fieldsValidationMessages[PaymentReferenceValueKey]?.isNotEmpty ??
      false;
  bool get hasPaymentTransactionDateValidationMessage =>
      this
          .fieldsValidationMessages[PaymentTransactionDateValueKey]
          ?.isNotEmpty ??
      false;
  bool get hasPaymentTotalValidationMessage =>
      this.fieldsValidationMessages[PaymentTotalValueKey]?.isNotEmpty ?? false;

  String? get paymentDescriptionValidationMessage =>
      this.fieldsValidationMessages[PaymentDescriptionValueKey];
  String? get paymentReferenceValidationMessage =>
      this.fieldsValidationMessages[PaymentReferenceValueKey];
  String? get paymentTransactionDateValidationMessage =>
      this.fieldsValidationMessages[PaymentTransactionDateValueKey];
  String? get paymentTotalValidationMessage =>
      this.fieldsValidationMessages[PaymentTotalValueKey];
}

extension Methods on FormViewModel {
  setPaymentDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PaymentDescriptionValueKey] =
          validationMessage;
  setPaymentReferenceValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PaymentReferenceValueKey] =
          validationMessage;
  setPaymentTransactionDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PaymentTransactionDateValueKey] =
          validationMessage;
  setPaymentTotalValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PaymentTotalValueKey] = validationMessage;
}
