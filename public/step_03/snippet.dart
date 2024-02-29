import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const Text('Nombre'),
                // TODO(): Agregar input de "Nombre"
                const SizedBox(height: 10),
                const Text('Correo electrónico'),
                // TODO(): Agregar input de "Correo electrónico"
                const SizedBox(height: 10),
                const Text('Contraseña'),
                // TODO(): Agregar input de "Contraseña"
                const SizedBox(height: 10),
                // TODO(): Agregar Checkbox de Terminos y Condiciones
                const SizedBox(height: 24),
                // TODO(): Agregar botón de registro
            ]
          ),
        ),
      ),
    );
  }
}
