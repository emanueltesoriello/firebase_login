// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QueryStore on _QueryStore, Store {
  final _$userAtom = Atom(name: '_QueryStore.user');

  @override
  ObservableFuture<mv.User> get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(ObservableFuture<mv.User> value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
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

  final _$checkMagicCodeAsyncAction = AsyncAction('_QueryStore.checkMagicCode');

  @override
  Future<dynamic> checkMagicCode(String magicCode) {
    return _$checkMagicCodeAsyncAction
        .run(() => super.checkMagicCode(magicCode));
  }

  @override
  String toString() {
    return '''
user: ${user},
loading: ${loading}
    ''';
  }
}
