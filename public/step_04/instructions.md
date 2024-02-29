# Utilizando Form
En este paso englobaremos todos los inputs que creamos anteriormente dentro de un Form para poder realizar validaciones.

> 💡 Antes de crear el Form, veamos un nuevo concepto.

## GlobalKey
Es una key o llave que es única dentro de toda la aplicación y permite poder identificar
un elemento de nuestra app. Cuando se utiliza en StatefulWidgets permite acceder fácilmente
al estado (State) del mismo, desde cualquier sub-árbol (widget hijo).

> ❓ ¿Para qué nos va a a servir la GlobalKey? Para poder acceder a nuestro formulario y conocer
si todos los campos son válidos.

## Creando nuestro StatefulWidget para el form
El widget de form es muy simple de crear, pero vamos a precisar hacer unos ajustes en nuestro código
primero, para que sea más sencillo de trabajar.

Si no lo hiciste antes, sería ideal comenzar a organizar el código un poco. Te explico cómo.

1. Convierte cada input de los que tenemos en la `Column`, en su propio widget class. Por ejemplo:
````dart
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
````
2. Una vez hecho eso con todos, actualiza la `Column` para utilizar esos widgets, de esta manera:
````dart
Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Nombre'),
      NameInput(),
      const SizedBox(height: 10),
      const Text('Correo electrónico'),
      EmailInput(),
      const SizedBox(height: 10),
      const Text('Contraseña'),
      PasswordInput(),
      const SizedBox(height: 10),
      const TermsCheck(),
      const SizedBox(height: 24),
      const RegisterButton(),
    ],
  ),
````
3. Ahora vamos a crear un widget individual para todo nuestro formulario, será un `StatefulWidget`
y dentro de él colocaremos esa `Column` con todos los elementos, así:
````dart
class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<StatefulWidget> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return const Column(
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
        RegisterButton(),
      ],
    );
  }
}
````

Hecho este cambio, nuestra `MyApp` quedaría así:
````dart
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
````

## Agregando nuestro Form y GlobalKey
Al `SignUpFormState` que tenemos creado, le agregaremos un `GlobalKey` que llamaremos `_formKey`,
y lo pasaremos por parámetro al widget `Form` con el cual englobaremos la `Column` que ya tenemos.
De esta manera:

````dart
class SignUpFormState extends State<SignUpForm> {

  // Creamos el GlobalKey para este form, que lleva el tipo FormState.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Agregamos el Form y le asignamos la key
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nombre'),
          // ... otros widgets
        ],
      ),
    );
  }
}
````

# Validando nuestro Form
Aún nos falta agregar la lógica de validación para cada input, pero para ir haciendo camino,
hagamos la "llamada validadora" en el botón de Registro, de esta manera:

````dart
// Este widget lo dejaremos por aquí, ya que nos sirve tener el onPressed a mano.
  const SizedBox(
    width: double.infinity,
    child: FilledButton(
      child: const Text('Registrarse'),
        onPressed: () {
         // Lógica para ver si el formulario es válido
          if (_formKey.currentState?.validate() ?? false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Bienvenido!'),
              ),
            );
          }
        },
    ),
  ),
````
Si todo está correcto en el formulario, se mostrará un mensaje de "Bienvenido!".

> 💡 Para poder visualizar el resultado final, haz click en "Solución"