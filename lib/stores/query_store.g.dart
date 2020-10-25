// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QueryStore on _QueryStore, Store {
  final _$_testFutureAtom = Atom(name: '_QueryStore._testFuture');

  @override
  ObservableFuture<String> get _testFuture {
    _$_testFutureAtom.reportRead();
    return super._testFuture;
  }

  @override
  set _testFuture(ObservableFuture<String> value) {
    _$_testFutureAtom.reportWrite(value, super._testFuture, () {
      super._testFuture = value;
    });
  }

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

  final _$fetchTestsAsyncAction = AsyncAction('_QueryStore.fetchTests');

  @override
  Future<dynamic> fetchTests() {
    return _$fetchTestsAsyncAction.run(() => super.fetchTests());
  }

  final _$fetchTheUserAsyncAction = AsyncAction('_QueryStore.fetchTheUser');

  @override
  Future<dynamic> fetchTheUser() {
    return _$fetchTheUserAsyncAction.run(() => super.fetchTheUser());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
