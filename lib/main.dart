import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark, // Use dark mode
      debugShowCheckedModeBanner: false,
      // Light theme (if needed)
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      // Dark theme setup
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueGrey, // Text color in dark theme
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[900],
        ),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0"; // Displayed on the screen
  String _output = "0"; // For internal use
  double num1 = 0; // First operand
  double num2 = 0; // Second operand
  String operand = ""; // Stores the selected operator
  bool decimalUsed = false; // Tracks if a decimal point has been used

  // Button press handler
  void buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
      decimalUsed = false; // Reset decimal tracking
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
      decimalUsed = false; // Allow decimal in the next number
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "/" && num2 == 0) {
        // Division by zero check
        _output = "Error";
      } else {
        switch (operand) {
          case "+":
            _output = (num1 + num2).toString();
            break;
          case "-":
            _output = (num1 - num2).toString();
            break;
          case "*":
            _output = (num1 * num2).toString();
            break;
          case "/":
            _output = (num1 / num2).toString();
            break;
        }
      }
      num1 = 0;
      num2 = 0;
      operand = "";
      decimalUsed = false; // Allow decimal in the next calculation
    } else if (buttonText == ".") {
      // Handle decimal point input
      if (!decimalUsed) {
        _output += ".";
        decimalUsed = true; // Mark that a decimal point has been used
      }
    } else {
      if (_output == "0" || _output == "Error") {
        _output = buttonText; // Start fresh if "Error" is displayed
      } else {
        _output += buttonText;
      }
    }

    setState(() {
      output = _output; // Directly update the output
    });
  }

  // Widget for creating buttons
  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(24.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple Calculator")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(output, style: TextStyle(fontSize: 48.0)),
          ),
          Expanded(child: Divider()), // Divider for display and buttons
          Column(
            children: [
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
                buildButton("*")
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
              Row(children: [buildButton("CLEAR"), buildButton("=")]),
            ],
          ),
          // Card for displaying name and Panther ID
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Name: Abhiram Gelle",
                        style: TextStyle(fontSize: 16.0)),
                    Text("Panther ID: 002850818",
                        style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
