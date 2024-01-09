import 'package:flutter/material.dart';
import 'package:flutter_bloc/my_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  MyBloc myBloc = MyBloc();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<MyState>(
                // use Stream builder to watch data changes in the stream
                stream: myBloc.stateStream, // defining the stream
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    MyState? state = snapshot.data;
                    if (state is IncrementState) {
                      _counter = state.value;
                      return Text(
                        'Incremented: $_counter',
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    } else if (state is DecrementState) {
                      _counter = state.value;
                      return Text(
                        'Decremented: $_counter',
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    } else
                      return Container();
                  } else {
                    return Text("0",
                        style: Theme.of(context).textTheme.headlineMedium);
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                myBloc.eventStreamSink.add(IncrementEvent(
                    value: _counter)); // pushing data to the sink
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                myBloc.eventStreamSink.add(DecrementEvent(
                    value: _counter)); // pushing data to the sink
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
