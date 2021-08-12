import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum ColorEvent { Red, Pink, Blue }

class ColorBLoc extends Bloc<ColorEvent, Color> {
  ColorBLoc(Color initialState) : super(initialState);

  Color get initialStae => Colors.pink;

  @override
  Stream<Color> mapEventToState(ColorEvent event) async* {
    yield (event == ColorEvent.Pink)
        ? Colors.pink
        : (event == ColorEvent.Blue)
            ? Colors.blue
            : Colors.red;
  }
}
