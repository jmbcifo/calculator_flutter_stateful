import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

String strInput = "";
final txtEntrada = TextEditingController();
final txtResultado = TextEditingController();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    txtEntrada.addListener(() {});
    txtResultado.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 20.0,
                top: 20,
              ),
              child: TextField(
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.none,
                decoration: const InputDecoration.collapsed(
                    hintText: "0",
                    hintStyle: TextStyle(
                      fontSize: 40,
                      fontFamily: 'RobotoMono',
                    )),
                style: const TextStyle(
                  fontSize: 40,
                  fontFamily: 'RobotoMono',
                ),
                textAlign: TextAlign.right,
                controller: txtEntrada,
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: const InputDecoration.collapsed(
                    hintText: "Resultado",
                    fillColor: Colors.deepPurpleAccent,
                    hintStyle: TextStyle(fontFamily: 'RobotoMono')),
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.none,
                style: const TextStyle(
                    fontSize: 42,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold
                    // color: Colors.deepPurpleAccent
                    ),
                textAlign: TextAlign.right,
                controller: txtResultado,
              )),
          GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            crossAxisCount: 4,
            children: [
              btnAC('AC', const Color(0xFFF5F7F9)),
              boton(
                '%',
                const Color(0xFFF5F7F9),
              ),
              boton(
                '/',
                const Color(0xFFF5F7F9),
              ),
              btnBorrar(),
              boton('7', Colors.white),
              boton('8', Colors.white),
              boton('9', Colors.white),
              boton(
                '*',
                const Color(0xFFF5F7F9),
              ),
              boton('4', Colors.white),
              boton('5', Colors.white),
              boton('6', Colors.white),
              boton(
                '-',
                const Color(0xFFF5F7F9),
              ),
              boton('1', Colors.white),
              boton('2', Colors.white),
              boton('3', Colors.white),
              boton('+', const Color(0xFFF5F7F9)),
              Container(),
              boton('0', Colors.white),
              boton('.', Colors.white),
              btnIgual(),
            ],
          ),
        ],
      ),
    );
  }

  Widget boton(btntxt, Color btnColor) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            btnColor,
          ),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(18.0)),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        child: Text(
          btntxt,
          style: const TextStyle(
              fontSize: 28.0, color: Colors.black, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          setState(() {
            txtEntrada.text = txtEntrada.text + btntxt;
          });
        },
      ),
    );
  }

  Widget btnAC(btntext, Color btnColor) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            btnColor,
          ),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(18.0)),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        child: Text(
          btntext,
          style: const TextStyle(
              fontSize: 28.0, color: Colors.black, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          setState(() {
            txtEntrada.text = "";
            txtResultado.text = "";
          });
        },
      ),
    );
  }

  Widget btnBorrar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFFF5F7F9)),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(18.0)),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        child: const Icon(Icons.backspace, size: 35, color: Colors.blueGrey),
        onPressed: () {
          txtEntrada.text = (txtEntrada.text.isNotEmpty)
              ? (txtEntrada.text.substring(0, txtEntrada.text.length - 1))
              : "";
        },
      ),
    );
  }

  Widget btnIgual() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(18.0)),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        child: const Text(
          '=',
          style: TextStyle(
              fontSize: 28.0, color: Colors.white, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          Parser p = Parser();
          ContextModel ctxtm = ContextModel();
          Expression exp = p.parse(txtEntrada.text);
          setState(() {
            txtResultado.text =
                exp.evaluate(EvaluationType.REAL, ctxtm).toString();
          });
        },
      ),
    );
  }
}
