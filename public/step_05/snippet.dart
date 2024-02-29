import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          child: SignUpForm(),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<StatefulWidget> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nombre'),
          NameInput(),
          SizedBox(height: 10),
          Text('Correo electrónico'),
          EmailInput(),
          SizedBox(height: 10),
          Text('Contraseña'),
          PasswordInput(),
          SizedBox(height: 10),
          TermsCheck(),
          SizedBox(height: 24),
          // Este widget lo dejaremos por aquí, ya que nos sirve tener el onPressed a mano.
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              child: const Text('Registrarse'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bienvenido!'),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
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
    );
  }
}

class TermsCheck extends StatelessWidget {
  const TermsCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}