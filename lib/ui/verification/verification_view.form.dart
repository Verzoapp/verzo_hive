// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String OtpValueKey = 'otp';

final Map<String, TextEditingController>
    _VerificationViewTextEditingControllers = {};

final Map<String, FocusNode> _VerificationViewFocusNodes = {};

final Map<String, String? Function(String?)?> _VerificationViewTextValidations =
    {
  OtpValueKey: null,
};

mixin $VerificationView on StatelessWidget {
  TextEditingController get OTPController =>
      _getFormTextEditingController(OtpValueKey);
  FocusNode get OTPFocusNode => _getFormFocusNode(OtpValueKey);

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
    OTPController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    OTPController.addListener(() => _updateFormData(model));
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
          OtpValueKey: OTPController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        OtpValueKey: _getValidationMessage(OtpValueKey),
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
  String? get otpValue => this.formValueMap[OtpValueKey] as String?;

  bool get hasOtp =>
      this.formValueMap.containsKey(OtpValueKey) &&
      (otpValue?.isNotEmpty ?? false);

  bool get hasOtpValidationMessage =>
      this.fieldsValidationMessages[OtpValueKey]?.isNotEmpty ?? false;

  String? get otpValidationMessage =>
      this.fieldsValidationMessages[OtpValueKey];
}

extension Methods on FormViewModel {
  setOtpValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[OtpValueKey] = validationMessage;
}
