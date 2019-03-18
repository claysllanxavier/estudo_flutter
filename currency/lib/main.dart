import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    'https://api.hgbrasil.com/finance/quotations?format=json&key=0e1e9a5d';

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
  ));
}

Future<Map> _getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _realController =TextEditingController();
  final TextEditingController _dolarController =TextEditingController();
  final TextEditingController _euroController =TextEditingController();

  double _dolar;
  double _euro;

  void _realChanged(String text){
    double real = double.parse(text);
    _dolarController.text = (real/_dolar).toStringAsFixed(2);
    _euroController.text = (real/_euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text){
    double dolar = double.parse(text);
    _realController.text =  (dolar * _dolar).toStringAsFixed(2);
    _euroController.text =  (dolar * _dolar / _euro).toStringAsFixed(2);
  }
  
  void _euroChanged(String text){
    double euro = double.parse(text);
    _realController.text =  (euro * _euro).toStringAsFixed(2);
    _dolarController.text =  (euro * _euro / _dolar).toStringAsFixed(2);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('\$ Conversor de Moedas \$'),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder<Map>(
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text('Carregando Dados...',
                        style: TextStyle(color: Colors.amber, fontSize: 25.0)));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text('Erro a Carregar Dados :(',
                          style:
                              TextStyle(color: Colors.amber, fontSize: 25.0)));
                } else {
                  _dolar = snapshot.data['results']['currencies']['USD']['buy'];
                  _euro = snapshot.data['results']['currencies']['EUR']['buy'];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber,
                        ),
                        buildTextField('Reais', 'R\$', _realController, _realChanged),
                        Divider(),
                        buildTextField('Dólares', 'US\$', _dolarController, _dolarChanged),
                        Divider(),
                        buildTextField('Euros', '€', _euroController, _euroChanged)
                      ],
                    ),
                  );
                }
            }
          },
          future: _getData(),
        ),
      ),
    );
  }
}

Widget buildTextField(String label, String prefix, TextEditingController controller, Function func) {
  return TextField(
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    controller: controller,
    onChanged: func,
    keyboardType: TextInputType.number,
  );
}
