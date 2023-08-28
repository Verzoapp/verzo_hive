// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String QuantityReceivedValueKey = 'quantityReceived';
const String DateReceivedValueKey = 'dateReceived';

final Map<String, TextEditingController>
    _MarkPurchaseItemAsRecievedViewTextEditingControllers = {};

final Map<String, FocusNode> _MarkPurchaseItemAsRecievedViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _MarkPurchaseItemAsRecievedViewTextValidations = {
  QuantityReceivedValueKey: null,
  DateReceivedValueKey: null,
};

mixin $MarkPurchaseItemAsRecievedView on StatelessWidget {
  TextEditingController get quantityReceivedController =>
      _getFormTextEditingController(QuantityReceivedValueKey);
  TextEditingController get dateReceivedController =>
      _getFormTextEditingController(DateReceivedValueKey);
  FocusNode get quantityReceivedFocusNode =>
      _getFormFocusNode(QuantityReceivedValueKey);
  FocusNode get dateReceivedFocusNode =>
      _getFormFocusNode(DateReceivedValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_MarkPurchaseItemAsRecievedViewTextEditingControllers.containsKey(
        key)) {
      return _MarkPurchaseItemAsRecievedViewTextEditingControllers[key]!;
    }
    _MarkPurchaseItemAsRecievedViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _MarkPurchaseItemAsRecievedViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_MarkPurchaseItemAsRecievedViewFocusNodes.containsKey(key)) {
      return _MarkPurchaseItemAsRecievedViewFocusNodes[key]!;
    }
    _MarkPurchaseItemAsRecievedViewFocusNodes[key] = FocusNode();
    return _MarkPurchaseItemAsRecievedViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    quantityReceivedController.addListener(() => _updateFormData(model));
    dateReceivedController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    quantityReceivedController.addListener(() => _updateFormData(model));
    dateReceivedController.addListener(() => _updateFormData(model));
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
          QuantityReceivedValueKey: quantityReceivedController.text,
          DateReceivedValueKey: dateReceivedController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        QuantityReceivedValueKey:
            _getValidationMessage(QuantityReceivedValueKey),
        DateReceivedValueKey: _getValidationMessage(DateReceivedValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _MarkPurchaseItemAsRecievedViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey = validatorForKey(
        _MarkPurchaseItemAsRecievedViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller
        in _MarkPurchaseItemAsRecievedViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _MarkPurchaseItemAsRecievedViewFocusNodes.values) {
      focusNode.dispose();
    }

    _MarkPurchaseItemAsRecievedViewTextEditingControllers.clear();
    _MarkPurchaseItemAsRecievedViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get quantityReceivedValue =>
      this.formValueMap[QuantityReceivedValueKey] as String?;
  String? get dateReceivedValue =>
      this.formValueMap[DateReceivedValueKey] as String?;

  bool get hasQuantityReceived =>
      this.formValueMap.containsKey(QuantityReceivedValueKey) &&
      (quantityReceivedValue?.isNotEmpty ?? false);
  bool get hasDateReceived =>
      this.formValueMap.containsKey(DateReceivedValueKey) &&
      (dateReceivedValue?.isNotEmpty ?? false);

  bool get hasQuantityReceivedValidationMessage =>
      this.fieldsValidationMessages[QuantityReceivedValueKey]?.isNotEmpty ??
      false;
  bool get hasDateReceivedValidationMessage =>
      this.fieldsValidationMessages[DateReceivedValueKey]?.isNotEmpty ?? false;

  String? get quantityReceivedValidationMessage =>
      this.fieldsValidationMessages[QuantityReceivedValueKey];
  String? get dateReceivedValidationMessage =>
      this.fieldsValidationMessages[DateReceivedValueKey];
}

extension Methods on FormViewModel {
  setQuantityReceivedValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[QuantityReceivedValueKey] =
          validationMessage;
  setDateReceivedValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DateReceivedValueKey] = validationMessage;
}
