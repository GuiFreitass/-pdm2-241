import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation GUILHERME';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  // Funções de validação
  String? validarData(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe uma data';
    }
    RegExp dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
    if (!dateRegex.hasMatch(value)) {
      return 'Formato de data inválido. Use dd-mm-aaaa';
    }
    try {
      List<String> parts = value.split('-');
      DateTime data = DateTime(
          int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      return null; // Data válida
    } catch (e) {
      return 'Data inválida';
    }
  }

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe um email';
    }
    RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Formato de email inválido';
    }
    return null;
  }

  String? validarCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe um CPF';
    }
    String cpf = value.replaceAll(RegExp(r'[\.\-]'), '');

    if (cpf.length != 11 || RegExp(r'(\d)\1{10}').hasMatch(cpf)) {
      return 'CPF inválido';
    }

    List<int> numbers = cpf.split('').map(int.parse).toList();
    int soma1 = 0, soma2 = 0;
    for (int i = 0; i < 9; i++) {
      soma1 += numbers[i] * (10 - i);
      soma2 += numbers[i] * (11 - i);
    }
    int digito1 = (soma1 * 10) % 11 % 10;
    int digito2 = ((soma2 + digito1 * 2) * 10) % 11 % 10;

    if (digito1 == numbers[9] && digito2 == numbers[10]) {
      return null;
    } else {
      return 'CPF inválido';
    }
  }

  String? validarValor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe um valor';
    }
    RegExp valorRegex = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!valorRegex.hasMatch(value)) {
      return 'Valor inválido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campo de data
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Data (dd-mm-aaaa)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: validarData,
            ),
          ),
          // Campo de email
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: validarEmail,
            ),
          ),
          // Campo de CPF
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'CPF',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: validarCPF,
            ),
          ),
          // Campo de valor
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: validarValor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Dados processados com sucesso')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
