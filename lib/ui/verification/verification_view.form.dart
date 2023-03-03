// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String Otp1ValueKey = 'otp1';
const String Otp2ValueKey = 'otp2';
const String Otp3ValueKey = 'otp3';
const String Otp4ValueKey = 'otp4';

final Map<String, TextEditingController>
    _VerificationViewTextEditingControllers = {};

final Map<String, FocusNode> _VerificationViewFocusNodes = {};

final Map<String, String? Function(String?)?> _VerificationViewTextValidations =
    {
  Otp1ValueKey: null,
  Otp2ValueKey: null,
  Otp3ValueKey: null,
  Otp4ValueKey: null,
};

mixin $VerificationView on StatelessWidget {
  TextEditingController get otp1Controller =>
      _getFormTextEditingController(Otp1ValueKey);
  TextEditingController get otp2Controller =>
      _getFormTextEditingController(Otp2ValueKey);
  TextEditingController get otp3Controller =>
      _getFormTextEditingController(Otp3ValueKey);
  TextEditingController get otp4Controller =>
      _getFormTextEditingController(Otp4ValueKey);
  FocusNode get otp1FocusNode => _getFormFocusNode(Otp1ValueKey);
  FocusNode get otp2FocusNode => _getFormFocusNode(Otp2ValueKey);
  FocusNode get otp3FocusNode => _getFormFocusNode(Otp3ValueKey);
  FocusNode get otp4FocusNode => _getFormFocusNode(Otp4ValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_VerificationViewTextEditingControllers.containsKey(key)) {
      return _VerificationViewTextEditingControllers[key]!;
    }
    _VerificationViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _VerificationViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_VerificationViewFocusNodes.containsKey(key)) {
      return _VerificationViewFocusNodes[key]!;
    }
    _VerificationViewFocusNodes[key] = FocusNode();
    return _VerificationViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    otp1Controller.addListener(() => _updateFormData(model));
    otp2Controller.addListener(() => _updateFormData(model));
    otp3Controller.addListener(() => _updateFormData(model));
    otp4Controller.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    otp1Controller.addListener(() => _updateFormData(model));
    otp2Controller.addListener(() => _updateFormData(model));
    otp3Controller.addListener(() => _updateFormData(model));
    otp4Controller.addListener(() => _updateFormData(model));
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
          Otp1ValueKey: otp1Controller.text,
          Otp2ValueKey: otp2Controller.text,
          Otp3ValueKey: otp3Controller.text,
          Otp4ValueKey: otp4Controller.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        Otp1ValueKey: _getValidationMessage(Otp1ValueKey),
        Otp2ValueKey: _getValidationMessage(Otp2ValueKey),
        Otp3ValueKey: _getValidationMessage(Otp3ValueKey),
        Otp4ValueKey: _getValidationMessage(Otp4ValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _VerificationViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_VerificationViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _VerificationViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _VerificationViewFocusNodes.values) {
      focusNode.dispose();
    }

    _VerificationViewTextEditingControllers.clear();
    _VerificationViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get otp1Value => this.formValueMap[Otp1ValueKey] as String?;
  String? get otp2Value => this.formValueMap[Otp2ValueKey] as String?;
  String? get otp3Value => this.formValueMap[Otp3ValueKey] as String?;
  String? get otp4Value => this.formValueMap[Otp4ValueKey] as String?;

  bool get hasOtp1 =>
      this.formValueMap.containsKey(Otp1ValueKey) &&
      (otp1Value?.isNotEmpty ?? false);
  bool get hasOtp2 =>
      this.formValueMap.containsKey(Otp2ValueKey) &&
      (otp2Value?.isNotEmpty ?? false);
  bool get hasOtp3 =>
      this.formValueMap.containsKey(Otp3ValueKey) &&
      (otp3Value?.isNotEmpty ?? false);
  bool get hasOtp4 =>
      this.formValueMap.containsKey(Otp4ValueKey) &&
      (otp4Value?.isNotEmpty ?? false);

  bool get hasOtp1ValidationMessage =>
      this.fieldsValidationMessages[Otp1ValueKey]?.isNotEmpty ?? false;
  bool get hasOtp2ValidationMessage =>
      this.fieldsValidationMessages[Otp2ValueKey]?.isNotEmpty ?? false;
  bool get hasOtp3ValidationMessage =>
      this.fieldsValidationMessages[Otp3ValueKey]?.isNotEmpty ?? false;
  bool get hasOtp4ValidationMessage =>
      this.fieldsValidationMessages[Otp4ValueKey]?.isNotEmpty ?? false;

  String? get otp1ValidationMessage =>
      this.fieldsValidationMessages[Otp1ValueKey];
  String? get otp2ValidationMessage =>
      this.fieldsValidationMessages[Otp2ValueKey];
  String? get otp3ValidationMessage =>
      this.fieldsValidationMessages[Otp3ValueKey];
  String? get otp4ValidationMessage =>
      this.fieldsValidationMessages[Otp4ValueKey];
}

extension Methods on FormViewModel {
  setOtp1ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Otp1ValueKey] = validationMessage;
  setOtp2ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Otp2ValueKey] = validationMessage;
  setOtp3ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Otp3ValueKey] = validationMessage;
  setOtp4ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Otp4ValueKey] = validationMessage;
}
