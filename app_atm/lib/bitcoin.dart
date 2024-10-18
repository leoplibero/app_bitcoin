import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Bitcoin extends StatefulWidget {
  const Bitcoin({Key? key}) : super(key: key);

  @override
  _BitcoinState createState() => _BitcoinState();
}

class _BitcoinState extends State<Bitcoin> {
  var preco = 0; 

  Future<void> recuperarPreco() async {
    var response = await http.get(Uri.parse((
        'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=brl')
    ));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var bitcoinPrice = data['bitcoin']['brl'];
      setState(() {
        preco = bitcoinPrice;
      });
    } else {
      print('Erro ao recuperar o preço do Bitcoin.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/bitcoin.png"),
            Text("R\$ $preco", style: TextStyle(fontSize: 35)), // Exibe o preço atualizado

            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.orange),
              ),
              onPressed: recuperarPreco,
              child: Text(
                "Atualizar",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
