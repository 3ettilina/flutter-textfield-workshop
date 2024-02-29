# Validaciones
Veamos ahora cómo se realizan validaciones de los inputs!

Dado que estamos utilizando `TextFormField`, tenemos una propiedad disponible que se llama
`validator`. La misma recibe una `función` (o `callback`) que esa función recibe el último valor disponible
en ese campo de texto, y debe retornar un texto o mensaje hacia el usuario. Si ese texto no
es nulo, entonces el input muestra un error.


## Validaciones simples
A continuación veremos un ejemplo del uso del validator con verificaciones del input del usuario utilizando
condicionales básicos de programación.

Pongamos como ejemplo iniciador el `NameInput`, nuevamente:
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
      // Aquí pueden ver la propiedad validator en acción
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingrese un nombre';
        }
        return null;
      },
    );
  }
}
````
Dentro de validator pueden agregar toda la lógica que les parezca y retornar diversos
mensajes en base al input del usuario.

## Validaciones con RegExp
RegExp es corto para Regular Expressions o Expresiones Regulares en español. Las mismas son
patrones utilizados para coincidir combinaciones de caracteres en cadenas de texto.

Son muy poderosas y nos permiten hacer validaciones o comparaciones más exhaustivas.

Veamos un ejemplo con el campo de email. Sabemos que el mismo debe tener un formato de tipo:
`xxxx@xxxx.xxx`, donde las x son letras o números sin importar su largo, pero siempre debe haber
un `@` y un `.` contenidos dentro.

````dart
// validator del EmailInput
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un email';
    }
    // Expresión regular para asegurarnos que el mail es válido.
    if (!RegExp(r"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")
        .hasMatch(value)) {
      return 'Revise que el email ingresado sea válido. Ej: john@doe.com';
    }
    return null;
  },
````

Como verás es algo bastante complicado de entender a simple vista, pero es como otro
tipo de lenguaje que se aprende. Si quieres saber más puedes utilizar [esta herramienta](https://regex101.com/)
para aprender y practicar.

## Desafío
1. Agregar validaciones a todos los campos dependiendo de su tipo.

# Onteniendo los datos de nuestro input
Todos los inputs de texto (`TextField` o `TextFormField`) utilizan por detrás un controller que
permite interactuar con los inputs y reaccionar a sus cambios. 

Cuando ese `TextEditingController` es brindado al momento de instanciar el input, podemos 
hacer cosas como:
- Indicar un valor por defecto en el input
- Conocer cuándo el usuario hizo un cambio en el valor del input y reaccionar al mismo
- Obtener el texto que el usuario ingresó al input. (Sin un controller podemos ver el texto 
y validarlo, pero no obtenerlo fuera del input)

> Nota: Cada input tendrá su propio `controller` independiente.

Veamos un ejemplo nuevamente con el `NameInput`:

Ya que nuestro NameInput se encuentra aislado en su propio widget, para más adelante poder
acceder desde afuera a su valor, vamos a solicitar al padre de ese widget que nos pase
el controller por parámetro (bear with me):

````dart
class NameInput extends StatelessWidget {
  const NameInput({
    required this.controller,
    super.key,
  });

  // Solicitaremos un TextEditingController como propiedad
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Asignamos el controller al TextFormField
      controller: controller,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingrese un nombre';
        }
        return null;
      },
    );
  }
}
````
Crearemos el controller dentro del estado del Form y lo más importante, haremos dispose del controller.
> Hacer "dispose" significa liberar recursos cuando un widget es destruido. Recordar que los widgets
> stateful tienen un ciclo de vida. 

````dart
class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameInputController = TextEditingController();

  // Esto es muy importante al crear controllers en un widget.
  @override
  void dispose() {
    _nameInputController.dispose();
    super.dispose();
  }

  // Método build...
}
````

Actualizamos la instancia del `NameInput` en el `Form`.
````dart
...
  NameInput(
    controller: _nameInputController,
  ),
...
````
Ahora vamos a actualizar el mensaje de "Bienvenido!" del Snackbar para que muestre el nombre
de la persona.

````dart
// Este widget lo dejaremos por aquí, ya que nos sirve tener el onPressed a mano.
  SizedBox(
    width: double.infinity,
    child: FilledButton(
      child: const Text('Registrarse'),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Bienvenido! ${_nameInputController.value.text}'),
              ),
            );
          }
        },
    ),
  ),
````

Al ingresar todos los datos y dar click al botón de registro, deberías observar algo como ésto.

![Mostrando Snackbar con nombre del usuario](../images/step_05_name_validation.png)

## Desafío
1. Actualizar los otros dos inputs para que reciban un controller y poder obtener más adelante
el mail y la contraseña.