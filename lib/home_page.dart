import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String result = '';
  // Gustavo de Deus Conceicao  RA = 1431432312013
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Altura (cm)'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Peso (kg)'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text('Resultado: $result'),
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    try {
      double height = double.parse(heightController.text);
      double weight = double.parse(weightController.text);

      if (height <= 0 || weight <= 0) {
        showErrorDialog('Altura e peso devem ser valores positivos.');
        return;
      }

      double bmi = weight / ((height / 100) * (height / 100));

      String category;
      if (bmi < 18.5) {
        category = 'Abaixo do peso';
      } else if (bmi < 24.9) {
        category = 'Peso normal';
      } else if (bmi < 29.9) {
        category = 'Sobrepeso';
      } else {
        category = 'Obesidade';
      }

      setState(() {
        result = 'Seu IMC é ${bmi.toStringAsFixed(2)}\nCategoria: $category';
      });
    } catch (e) {
      showErrorDialog('Por favor, insira valores válidos para altura e peso.');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
