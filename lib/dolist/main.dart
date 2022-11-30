import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'addnote.dart';

void main() async {
  //Este es el pegamento que une el marco al motor de Flutter.
  WidgetsFlutterBinding.ensureInitialized();
  //inicializa la base de datos en firebase
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  //Crea el estado mutable para este widget en una ubicación dada en el árbol.
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //nombre del MaterialApp
      title: "DoList",
      theme: ThemeData(
        primaryColor: Colors.greenAccent[700],
      ),
      //ejecutamos la clase home
      home: Home(),
      //quitamos la cinta del programa
      debugShowCheckedModeBanner: false,
    );
  }
}

//clase home manda a llamar a _HomeState
class Home extends StatefulWidget {
  @override
  //manda a llamar su class
  _HomeState createState() => _HomeState();
}

//se muestran las tareas, opcion de eliminar y el boton de agregar
class _HomeState extends State<Home> {
  //guardamos en una variable la llamada a la base de datos
  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    // "todos" es el identificador del registro en la base de datos que manda a llamar lo que contiene
    final ref = fb.ref().child('todos');
    return Scaffold(
      //diseño y llamada de la interfaz de las notas agregadas en la base de datos
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => addnote(),
            ),
          );
        },
        //agrega el icono de agregar
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          //nombre del titulo de la app
          'DoList',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.indigo[900],
      ),
      //diseño para mostrar las cajas de texto traidas del Firebase
      body: FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.indigo[100],
                  leading: IconButton(
                      icon: Icon(
                        Icons.check_box_outline_blank_sharp,
                        color: Color(0xFF5F52EE),
                      ),
                      //funcionalidad para que se marque como checado, terminado
                      onPressed: () {}),
                  trailing: IconButton(
                    //icono de borrar y diseño
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[900],
                    ),
                    onPressed: () {
                      ref.child(snapshot.key!).remove();
                    },
                  ),
                  title: Text(
                    snapshot.value.toString(),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//tratando de que funcione el check button mediante un estado, no supimos vincular
void _handleToDoChange(todo) {}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.purple;
      //decoration:TextDecoration.lineThrough;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
