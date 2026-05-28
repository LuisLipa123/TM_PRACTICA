import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalculadoraEdad(),
    );
  }
}

class CalculadoraEdad extends StatefulWidget {
  const CalculadoraEdad({super.key});

  @override
  State<CalculadoraEdad> createState() => _CalculadoraEdadState();
}

class _CalculadoraEdadState extends State<CalculadoraEdad> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  int? _edad;
  final int _anioActual = DateTime.now().year;

  void _calcularEdad() {
    setState(() {
      final int? anioNacimiento = int.tryParse(_controller.text);

      if (anioNacimiento == null || anioNacimiento < 1900 || anioNacimiento > _anioActual) {
        _errorText = "Ingrese un año válido (1900 - $_anioActual)";
        _edad = null;
      } else {
        _errorText = null;
        _edad = _anioActual - anioNacimiento;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Edad'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Año de nacimiento',
                border: const OutlineInputBorder(),
                errorText: _errorText, // Validación visual
                prefixIcon: const Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _calcularEdad,
              child: const Text('Calcular Edad'),
            ),
            const SizedBox(height: 30),
            if (_edad != null)
              Card(
                elevation: 4,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      const Text('Tu edad actual es:', style: TextStyle(fontSize: 18)),
                      Text(
                        '$_edad años',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
