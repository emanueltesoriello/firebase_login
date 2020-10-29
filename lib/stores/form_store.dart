import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // constructor:---------------------------------------------------------------
  _FormStore() {
    _setupValidations();
  }

  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => userName, validateUserName),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword),
      reaction((_) => chamberOfCommerce, validateChamberOfCommerce),
      reaction((_) => companyName, validateCompanyName),
      reaction((_) => magicCode, validateMagicCode)
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String userEmail = '';

  @observable
  String userName = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  String chamberOfCommerce = '';

  @observable
  String companyName = '';

  @observable
  String magicCode = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      userEmail.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canSendEmailValidation =>
      !formErrorStore.hasErrorInSendEmailValidation &&
      userEmail.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      userEmail.isNotEmpty &&
      userName.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  @computed
  bool get canAddCompany =>
      !formErrorStore.hasErrorsInAddCompany &&
      chamberOfCommerce.isNotEmpty &&
      companyName.isNotEmpty;

  @computed
  bool get canInsertMagicCode =>
      !formErrorStore.hasErrorsInInsertMagicCode && magicCode.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setChamberOfCommerce(String value) {
    chamberOfCommerce = value;
  }

  @action
  void setCompanyName(String value) {
    companyName = value;
  }

  @action
  void setUserName(String value) {
    userName = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void setMagicCode(String value) {
    magicCode = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      formErrorStore.userEmail = null;
    }
  }

  @action
  void validateUserName(String value) {
    if (value.isEmpty) {
      formErrorStore.userName = "Username can't be empty";
    } else if (value.length < 3) {
      formErrorStore.userName = 'Please enter a valid Username';
    } else {
      formErrorStore.userName = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "Password can't be empty";
    } else if (value.length < 6) {
      formErrorStore.password = "Password must be at-least 3 characters long";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      formErrorStore.confirmPassword = "Password doen't match";
    } else {
      formErrorStore.confirmPassword = null;
    }
  }

  @action
  void validateChamberOfCommerce(String value) {
    if (value.isEmpty) {
      formErrorStore.chamberOfCommerce =
          "Chamber of Commerce no. can't be empty";
    } else if (value.length < 3) {
      formErrorStore.chamberOfCommerce =
          'Please enter a valid Chamber of Commerce no.';
    } else {
      formErrorStore.chamberOfCommerce = null;
    }
  }

  @action
  void validateCompanyName(String value) {
    if (value.isEmpty) {
      formErrorStore.companyName = "Company name can't be empty";
    } else if (value.length < 3) {
      formErrorStore.companyName = 'Please enter a valid company name';
    } else {
      formErrorStore.companyName = null;
    }
  }

  @action
  void validateMagicCode(String value) {
    if (value.isEmpty) {
      formErrorStore.magicCode = "Magic Code can't be empty";
    } else if (value.length < 3) {
      formErrorStore.magicCode = 'Please enter a valid Magic Code';
    } else {
      formErrorStore.magicCode = null;
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void reset() {
    userEmail = '';
    userName = '';
    password = '';
    confirmPassword = '';
    chamberOfCommerce = '';
    companyName = '';
    magicCode = '';
    success = false;
    loading = false;
  }

  void validateAll() {
    validatePassword(password);
    //validateUserEmail(userEmail);
    validateUserName(userName);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String userEmail;

  @observable
  String magicCode;

  @observable
  String userName;

  @observable
  String password;

  @observable
  String confirmPassword;

  @observable
  String chamberOfCommerce;

  @observable
  String companyName;

  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      userName != null ||
      userEmail != null ||
      password != null ||
      confirmPassword != null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;

  @computed
  bool get hasErrorInSendEmailValidation =>
      userEmail != null || password != null;

  @computed
  bool get hasErrorsInAddCompany =>
      chamberOfCommerce != null || companyName != null;

  @computed
  bool get hasErrorsInInsertMagicCode => magicCode != null;
}
