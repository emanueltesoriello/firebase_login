// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on _FormStore, Store {
  Computed<bool> _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??=
          Computed<bool>(() => super.canLogin, name: '_FormStore.canLogin'))
      .value;
  Computed<bool> _$canSendEmailValidationComputed;

  @override
  bool get canSendEmailValidation => (_$canSendEmailValidationComputed ??=
          Computed<bool>(() => super.canSendEmailValidation,
              name: '_FormStore.canSendEmailValidation'))
      .value;
  Computed<bool> _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_FormStore.canRegister'))
          .value;
  Computed<bool> _$canForgetPasswordComputed;

  @override
  bool get canForgetPassword => (_$canForgetPasswordComputed ??= Computed<bool>(
          () => super.canForgetPassword,
          name: '_FormStore.canForgetPassword'))
      .value;
  Computed<bool> _$canAddCompanyComputed;

  @override
  bool get canAddCompany =>
      (_$canAddCompanyComputed ??= Computed<bool>(() => super.canAddCompany,
              name: '_FormStore.canAddCompany'))
          .value;
  Computed<bool> _$canInsertMagicCodeComputed;

  @override
  bool get canInsertMagicCode => (_$canInsertMagicCodeComputed ??=
          Computed<bool>(() => super.canInsertMagicCode,
              name: '_FormStore.canInsertMagicCode'))
      .value;

  final _$userEmailAtom = Atom(name: '_FormStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$userNameAtom = Atom(name: '_FormStore.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$passwordAtom = Atom(name: '_FormStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$confirmPasswordAtom = Atom(name: '_FormStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$chamberOfCommerceAtom = Atom(name: '_FormStore.chamberOfCommerce');

  @override
  String get chamberOfCommerce {
    _$chamberOfCommerceAtom.reportRead();
    return super.chamberOfCommerce;
  }

  @override
  set chamberOfCommerce(String value) {
    _$chamberOfCommerceAtom.reportWrite(value, super.chamberOfCommerce, () {
      super.chamberOfCommerce = value;
    });
  }

  final _$companyNameAtom = Atom(name: '_FormStore.companyName');

  @override
  String get companyName {
    _$companyNameAtom.reportRead();
    return super.companyName;
  }

  @override
  set companyName(String value) {
    _$companyNameAtom.reportWrite(value, super.companyName, () {
      super.companyName = value;
    });
  }

  final _$magicCodeAtom = Atom(name: '_FormStore.magicCode');

  @override
  String get magicCode {
    _$magicCodeAtom.reportRead();
    return super.magicCode;
  }

  @override
  set magicCode(String value) {
    _$magicCodeAtom.reportWrite(value, super.magicCode, () {
      super.magicCode = value;
    });
  }

  final _$successAtom = Atom(name: '_FormStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$loadingAtom = Atom(name: '_FormStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$acceptPrivacySwitchAtom =
      Atom(name: '_FormStore.acceptPrivacySwitch');

  @override
  bool get acceptPrivacySwitch {
    _$acceptPrivacySwitchAtom.reportRead();
    return super.acceptPrivacySwitch;
  }

  @override
  set acceptPrivacySwitch(bool value) {
    _$acceptPrivacySwitchAtom.reportWrite(value, super.acceptPrivacySwitch, () {
      super.acceptPrivacySwitch = value;
    });
  }

  final _$_FormStoreActionController = ActionController(name: '_FormStore');

  @override
  void setUserId(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setUserId');
    try {
      return super.setUserId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChamberOfCommerce(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setChamberOfCommerce');
    try {
      return super.setChamberOfCommerce(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCompanyName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setCompanyName');
    try {
      return super.setCompanyName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setUserName');
    try {
      return super.setUserName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMagicCode(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setMagicCode');
    try {
      return super.setMagicCode(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAcceptPrivacySwitch(bool value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setAcceptPrivacySwitch');
    try {
      return super.setAcceptPrivacySwitch(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateUserEmail');
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateUserName');
    try {
      return super.validateUserName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConfirmPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConfirmPassword');
    try {
      return super.validateConfirmPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateChamberOfCommerce(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateChamberOfCommerce');
    try {
      return super.validateChamberOfCommerce(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCompanyName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateCompanyName');
    try {
      return super.validateCompanyName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateMagicCode(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateMagicCode');
    try {
      return super.validateMagicCode(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userEmail: ${userEmail},
userName: ${userName},
password: ${password},
confirmPassword: ${confirmPassword},
chamberOfCommerce: ${chamberOfCommerce},
companyName: ${companyName},
magicCode: ${magicCode},
success: ${success},
loading: ${loading},
acceptPrivacySwitch: ${acceptPrivacySwitch},
canLogin: ${canLogin},
canSendEmailValidation: ${canSendEmailValidation},
canRegister: ${canRegister},
canForgetPassword: ${canForgetPassword},
canAddCompany: ${canAddCompany},
canInsertMagicCode: ${canInsertMagicCode}
    ''';
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool> _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??= Computed<bool>(
          () => super.hasErrorsInLogin,
          name: '_FormErrorStore.hasErrorsInLogin'))
      .value;
  Computed<bool> _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister,
              name: '_FormErrorStore.hasErrorsInRegister'))
      .value;
  Computed<bool> _$hasErrorInForgotPasswordComputed;

  @override
  bool get hasErrorInForgotPassword => (_$hasErrorInForgotPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInForgotPassword,
              name: '_FormErrorStore.hasErrorInForgotPassword'))
      .value;
  Computed<bool> _$hasErrorInSendEmailValidationComputed;

  @override
  bool get hasErrorInSendEmailValidation =>
      (_$hasErrorInSendEmailValidationComputed ??= Computed<bool>(
              () => super.hasErrorInSendEmailValidation,
              name: '_FormErrorStore.hasErrorInSendEmailValidation'))
          .value;
  Computed<bool> _$hasErrorsInAddCompanyComputed;

  @override
  bool get hasErrorsInAddCompany => (_$hasErrorsInAddCompanyComputed ??=
          Computed<bool>(() => super.hasErrorsInAddCompany,
              name: '_FormErrorStore.hasErrorsInAddCompany'))
      .value;
  Computed<bool> _$hasErrorsInInsertMagicCodeComputed;

  @override
  bool get hasErrorsInInsertMagicCode =>
      (_$hasErrorsInInsertMagicCodeComputed ??= Computed<bool>(
              () => super.hasErrorsInInsertMagicCode,
              name: '_FormErrorStore.hasErrorsInInsertMagicCode'))
          .value;

  final _$userEmailAtom = Atom(name: '_FormErrorStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$magicCodeAtom = Atom(name: '_FormErrorStore.magicCode');

  @override
  String get magicCode {
    _$magicCodeAtom.reportRead();
    return super.magicCode;
  }

  @override
  set magicCode(String value) {
    _$magicCodeAtom.reportWrite(value, super.magicCode, () {
      super.magicCode = value;
    });
  }

  final _$userNameAtom = Atom(name: '_FormErrorStore.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$passwordAtom = Atom(name: '_FormErrorStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$confirmPasswordAtom = Atom(name: '_FormErrorStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$chamberOfCommerceAtom =
      Atom(name: '_FormErrorStore.chamberOfCommerce');

  @override
  String get chamberOfCommerce {
    _$chamberOfCommerceAtom.reportRead();
    return super.chamberOfCommerce;
  }

  @override
  set chamberOfCommerce(String value) {
    _$chamberOfCommerceAtom.reportWrite(value, super.chamberOfCommerce, () {
      super.chamberOfCommerce = value;
    });
  }

  final _$companyNameAtom = Atom(name: '_FormErrorStore.companyName');

  @override
  String get companyName {
    _$companyNameAtom.reportRead();
    return super.companyName;
  }

  @override
  set companyName(String value) {
    _$companyNameAtom.reportWrite(value, super.companyName, () {
      super.companyName = value;
    });
  }

  @override
  String toString() {
    return '''
userEmail: ${userEmail},
magicCode: ${magicCode},
userName: ${userName},
password: ${password},
confirmPassword: ${confirmPassword},
chamberOfCommerce: ${chamberOfCommerce},
companyName: ${companyName},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsInRegister: ${hasErrorsInRegister},
hasErrorInForgotPassword: ${hasErrorInForgotPassword},
hasErrorInSendEmailValidation: ${hasErrorInSendEmailValidation},
hasErrorsInAddCompany: ${hasErrorsInAddCompany},
hasErrorsInInsertMagicCode: ${hasErrorsInInsertMagicCode}
    ''';
  }
}
