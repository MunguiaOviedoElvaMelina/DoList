import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main.dart';

//class para agregar una nota
class addnote extends StatelessWidget {
  TextEditingController title = TextEditingController();
  //guardamos en una variable la llamada a la base de datos
  final fb = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    // "todos" es el identificador del registro en la base de datos
    final ref = fb.ref().child('todos');

    return Scaffold(
      appBar: AppBar(
        //titulo de la nueva pagina junto el color donde aparece
        title: Text("Nueva Tarea"),
        backgroundColor: Colors.indigo[900],
      ),
      //contenedor del SizedBox
      body: Container(
        child: Column(
          children: [
            //caja donde tiene la informacion a añadir
            SizedBox(
              height: 30,
            ),
            //decoracion de la caja
            Container(
              margin: EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 50),
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'Escribe tu Actividad Pendiente',
                ),
              ),
            ),
            //contenedor del boton
            SizedBox(
              height: 80,
            ),
            //boton
            MaterialButton(
              color: Colors.indigo[900],
              //agrega a la bd el texto
              onPressed: () {
                ref
                    .push()
                    .set(
                      title.text,
                    )
                    //me regresa  la pagina principal
                    .asStream();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              },
              //diseño del texto dentro
              child: Text(
                "Guardar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
