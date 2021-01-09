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
      reaction((_) => magicCode, validateMagicCode),
      reaction((_) => address, validateAddress),
      reaction((_) => postalCode, validatePostalCode),
      reaction((_) => city, validateCity),
      reaction((_) => phoneNumber, validatePhoneNumber)
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
  String address = '';

  @observable
  String postalCode = '';

  @observable
  String city = '';

  @observable
  String phoneNumber = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  bool acceptPrivacySwitch = false;

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
      confirmPassword.isNotEmpty &&
      acceptPrivacySwitch;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  @computed
  bool get canSendNewEmail =>
      !formErrorStore.hasErrorInCanChangeEmail &&
      userEmail.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canAddCompany =>
      !formErrorStore.hasErrorsInAddCompany &&
      chamberOfCommerce.isNotEmpty &&
      companyName.isNotEmpty;

  @computed
  bool get canInsertMagicCode =>
      !formErrorStore.hasErrorsInInsertMagicCode && magicCode.isNotEmpty;

  @computed
  bool get canUpdateEmail =>
      userEmail.isNotEmpty && !formErrorStore.hasErrorInUpdateEmail;

  @computed
  bool get canUpdateUsername =>
      userName.isNotEmpty && !formErrorStore.hasErrorInUpdateUserName;

  @computed
  bool get canUpdateAddress =>
      address.isNotEmpty && !formErrorStore.hasErrorInUpdateAddress;

  @computed
  bool get canUpdatePostalCode =>
      postalCode.isNotEmpty && !formErrorStore.hasErrorInUpdatePostalCode;

  @computed
  bool get canUpdateCity =>
      city.isNotEmpty && !formErrorStore.hasErrorInUpdateCity;

  @computed
  bool get canUpdatePhoneNumber =>
      phoneNumber.isNotEmpty && !formErrorStore.hasErrorInUpdatePhoneNumber;

  /*@computed
  bool get canUpdateProfile =>
      userName.isNotEmpty &&
      userEmail.isNotEmpty &&
      chamberOfCommerce.isNotEmpty;*/

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
  void setAddress(String value) {
    address = value;
  }

  @action
  void setPostalCode(String value) {
    postalCode = value;
  }

  @action
  void setCity(String value) {
    city = value;
  }

  @action
  void setPhoneNumber(String value) {
    phoneNumber = value;
  }

  @action
  void setAcceptPrivacySwitch(bool value) {
    acceptPrivacySwitch = value;
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
      formErrorStore.password = "Password must be at-least 6 characters long";
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

  @action
  void validatePostalCode(String value) {
    if (value.isEmpty) {
      formErrorStore.postalCode = "Postal Code can't be empty";
    } else if (value.length < 3) {
      formErrorStore.postalCode = 'Please enter a valid Postal Code';
    } else {
      formErrorStore.postalCode = null;
    }
  }

  @action
  void validateAddress(String value) {
    print(value);
    if (value.isEmpty) {
      formErrorStore.address = "Address can't be empty";
    } else if (value.length < 3) {
      formErrorStore.address = 'Please enter a valid Address';
    } else {
      formErrorStore.address = null;
    }
  }

  @action
  void validateCity(String value) {
    if (value.isEmpty) {
      formErrorStore.city = "City can't be empty";
    } else if (value.length < 3) {
      formErrorStore.city = 'Please enter a valid City';
    } else {
      formErrorStore.city = null;
    }
  }

  @action
  void validatePhoneNumber(String value) {
    formErrorStore.phoneNumber = null;
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
    address = '';
    postalCode = '';
    city = '';
    success = false;
    loading = false;
  }

  void validateAll() {
    validatePassword(password);
    //validateUserEmail(userEmail);
    validateUserName(userName);
    validateCity(city);
    validateAddress(address);
    validatePostalCode(postalCode);
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

  @observable
  String postalCode;

  @observable
  String address;

  @observable
  String city;

  @observable
  String phoneNumber;

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
  bool get hasErrorInCanChangeEmail => password != null;

  @computed
  bool get hasErrorInSendEmailValidation =>
      userEmail != null || password != null;

  @computed
  bool get hasErrorsInAddCompany =>
      chamberOfCommerce != null || companyName != null;

  @computed
  bool get hasErrorsInInsertMagicCode => magicCode != null;

  @computed
  bool get hasErrorInUpdateEmail => userEmail != null;

  @computed
  bool get hasErrorInUpdateUserName => userName != null;

  @computed
  bool get hasErrorInUpdateAddress => address != null;

  @computed
  bool get hasErrorInUpdatePostalCode => postalCode != null;

  @computed
  bool get hasErrorInUpdateCity => city != null;

  @computed
  bool get hasErrorInUpdatePhoneNumber => phoneNumber != null;
}
