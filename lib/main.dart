import 'package:bloclogin/colorChangeBloc.dart';
import 'package:bloclogin/counterBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(0),
        ),
        BlocProvider<ColorBLoc>(create: (context) => ColorBLoc(Colors.pink))
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    ColorBLoc colorbloc = BlocProvider.of<ColorBLoc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Counter Value is:',
              ),
              BlocBuilder<CounterBloc, int>(builder: (context, state) {
                return Text(
                  '$state',
                  style: TextStyle(fontSize: 25),
                );
              }),
              BlocBuilder<ColorBLoc, Color>(
                builder: (context, color) {
                  return Container(
                    height: 150,
                    width: 150,
                    color: color,
                  );
                },
              ),
              RaisedButton(
                onPressed: () {
                  colorbloc.add(ColorEvent.Pink);
                },
                child: Text('Pink'),
              ),
              RaisedButton(
                onPressed: () {
                  colorbloc.add(ColorEvent.Blue);
                },
                child: Text('Blue'),
              ),
              RaisedButton(
                onPressed: () {
                  colorbloc.add(ColorEvent.Red);
                },
                child: Text('Red'),
              )
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                counterBloc.add(CounterAction.INCREMENT);
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                counterBloc.add(CounterAction.DECREMENT);
              },
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
            FloatingActionButton(
                onPressed: () {
                  counterBloc.add(CounterAction.RESET);
                },
                tooltip: 'Reset',
                child: Icon(Icons.restart_alt)),
          ],
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
