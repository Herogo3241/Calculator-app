import 'package:calculator_app/pages/history_operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff618264)),
        useMaterial3: true,
      ),
      home: const HomePage(
        title: 'Calculator',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> operationsHistory = [];

  void navigateToHistoryPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryPage(operationsHistory: operationsHistory),
      ),
    );
  }

  String output = "0";

  String _output = "0";

  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == 'x' ||
        buttonText == '/') {
      num1 = double.parse(output);

      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      bool flag = false;

      if (operand == "+") {
        _output = (num1 + num2).toString();
        flag = true;
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
        flag = true;
      }
      if (operand == "x") {
        _output = (num1 * num2).toString();
        flag = true;
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
        flag = true;
      }

      if (flag) {
        String operation = '$num1 $operand $num2 = $_output';
        operationsHistory.add(operation);
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlinedButton(
          //padding:  EdgeInsets.all(24.0),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xffB0D9B1)), // Outline color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // BorderRadius
            ),
            splashFactory: InkRipple.splashFactory,
            padding: const EdgeInsets.all(15.0), // Padding
          ),

          onPressed: () => {
            buttonPressed(buttonText),
            HapticFeedback.vibrate(),
          },
          //padding:  EdgeInsets.all(24.0),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: Column(
          children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
              alignment: Alignment.centerRight,
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(output,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ))),
        ),
        const Expanded(
          child: Divider(),
        ),
        Column(children: [
          Row(children: [
            buildButton("7"),
            buildButton("8"),
            buildButton("9"),
            buildButton("/")
          ]),
          Row(children: [
            buildButton("4"),
            buildButton("5"),
            buildButton("6"),
            buildButton("x")
          ]),
          Row(children: [
            buildButton("1"),
            buildButton("2"),
            buildButton("3"),
            buildButton("-")
          ]),
          Row(children: [
            buildButton("."),
            buildButton("0"),
            buildButton("00"),
            buildButton("+")
          ]),
          Row(children: [
            buildButton("CLEAR"),
            buildButton("="),
          ])
        ])
          ],
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xff79AC78),
        ),
      ),
      elevation: 4.0,
      shadowColor: Colors.black,
      leading: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          'assets/icons/Calculator.svg',
          colorFilter: const ColorFilter.mode(Color(0xff79AC78), BlendMode.srcIn),
          height: 30,
          width: 30,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            navigateToHistoryPage();
            HapticFeedback.vibrate();
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/icons/Clock.svg',
              colorFilter: const ColorFilter.mode(Color(0xff79AC78), BlendMode.srcIn),
              height: 30,
              width: 30,
            ),
          ),
        ),
      ],
    );
  }
}
