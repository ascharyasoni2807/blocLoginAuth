import 'dart:async';

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterAction { INCREMENT, DECREMENT, RESET }

class CounterBloc extends Bloc<CounterAction, int> {
  CounterBloc(int initialState) : super(initialState);

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterAction event) async* {
    switch (event) {
      case CounterAction.INCREMENT:
        yield state + 1;
        break;
      case CounterAction.DECREMENT:
        yield state - 1;
        break;
      case CounterAction.RESET:
        yield state * 0;
        break;
    }
  }
}
