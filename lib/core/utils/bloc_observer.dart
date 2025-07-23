import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('onChange: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onClose(BlocBase bloc) {
    log('onClose: ${bloc.runtimeType}');
  }

  @override
  void onCreate(BlocBase bloc) {
    log('onCreate: ${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('onTransition: ${bloc.runtimeType}, transition: $transition');
  }
}
