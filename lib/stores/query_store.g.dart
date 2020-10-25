// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QueryStore on _QueryStore, Store {
  final _$_userAtom = Atom(name: '_QueryStore._user');

  @override
  ObservableFuture<mv.User> get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(ObservableFuture<mv.User> value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  final _$loadingAtom = Atom(name: '_QueryStore.loading');

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

  final _$fetchTheUserAsyncAction = AsyncAction('_QueryStore.fetchTheUser');

  @override
  Future<dynamic> fetchTheUser() {
    return _$fetchTheUserAsyncAction.run(() => super.fetchTheUser());
  }

  final _$addNewCompanyAsyncAction = AsyncAction('_QueryStore.addNewCompany');

  @override
  Future<dynamic> addNewCompany(
      String chamberOfCommerceNo, String companyName) {
    return _$addNewCompanyAsyncAction
        .run(() => super.addNewCompany(chamberOfCommerceNo, companyName));
  }

  final _$insertMagicCodeAsyncAction =
      AsyncAction('_QueryStore.insertMagicCode');

  @override
  Future<dynamic> insertMagicCode(String magicCode) {
    return _$insertMagicCodeAsyncAction
        .run(() => super.insertMagicCode(magicCode));
  }

  @override
  String toString() {
    return '''
loading: ${loading}
    ''';
  }
}
