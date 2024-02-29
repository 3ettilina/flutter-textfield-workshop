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
          // TODO(): Mover esta Column a un  StatefulWidget individual. Hacer wrap con Form y agregar el GlobalKey.
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nombre'),
                // TODO(): Mover este TextFormField a un widget individual
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Color(0xFFB08ED2),
                    border: OutlineInputBorder(),
                    hintText: 'John Doe',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFB08ED2),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Correo electrónico'),
                // TODO(): Mover este TextFormField a un widget individual
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Color(0xFFB08ED2),
                    border: OutlineInputBorder(),
                    hintText: 'john@doe.com',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFB08ED2),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Contraseña'),

                // TODO(): Mover este Stack a un widget individual
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        prefixIconColor: Color(0xFFB08ED2),
                        border: OutlineInputBorder(),
                        hintText: 'contraseña',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFB08ED2),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility_outlined),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 10),

                // TODO(): Mover esta Row a un widget individual
                const Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.grey,
                      splashRadius: 0,
                      fillColor:
                      MaterialStateProperty.resolveWith((states) => Colors.white),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(color: Colors.blueGrey)),
                      value: true,
                      onChanged: (bool? value) {},
                    ),
                    const SizedBox(width: 4),
                    const Text('Estoy de acuerdo con los términos y condiciones'),
                  ],
                ),
                const SizedBox(height: 24),
                // Este widget lo dejaremos por aquí, ya que nos sirve tener el onPressed a mano.
                const SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    child: const Text('Registrarse'),
                    // TODO(): Agregar validación de formulario
                    onPressed: () {},
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
