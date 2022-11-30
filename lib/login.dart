import 'dart:async';
import 'package:dolist/dolist/main.dart';
import 'dolist/main.dart'; //referencia para cambio de pagina
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //quitar la bandera roja
      debugShowCheckedModeBanner: false,
      //correr la clase login
      home: _login(),
    );
  }
}

//crea el login
class _login extends StatefulWidget {
  @override
  State<_login> createState() => __loginState();
}

//login donde empezamos a diseñar y construir el login
class __loginState extends State<_login> {
  //su finalidad era recopilar los datos del usuario
  TextEditingController Usuario = new TextEditingController();
  TextEditingController Contrasena = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //fondo externo
      backgroundColor: Color.fromARGB(255, 26, 250, 250),
      body: Container(
        decoration: BoxDecoration(
            boxShadow: [
              //sombreado en los costados del container  y bordes
              BoxShadow(
                  color: Color.fromARGB(146, 0, 0, 0),
                  blurRadius: 25.0,
                  spreadRadius: 5.0,
                  offset: Offset(15.0, 15.0))
            ],
            //fonde interno
            color: Color.fromARGB(255, 46, 170, 168),
            borderRadius:
                BorderRadius.circular(20) //borde del container interno
            ),

        //separar las cajas de texto de los margenes
        margin: EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 50),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Center(
          //mostrar un icono hasta arriba
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/saludos.png",
              height: 160,
            ),
            //caja de texto para el usuario
            TextField(
              controller: Usuario,
              decoration: InputDecoration(
                hintText: "Ejemplo: Equipo1-DVM",
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            //un separador entre ambas cajas
            SizedBox(
              height: 10,
            ),
            //caja de texto para la constraseña junto el diseño
            TextField(
              controller: Contrasena,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Contraseña",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            //container, diseño y funcionalidad del boton
            Container(
              margin: EdgeInsets.only(top: 70),
              width: 200,
              decoration: BoxDecoration(
                  color: Color.fromARGB(209, 22, 223, 122),
                  borderRadius: BorderRadius.circular(10)),
              child: FloatingActionButton(
                child: Text(
                  "Ingresar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  //if (Usuario=="Equipo"&&Contrasena=="ANIMO") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Home(),
                    ),
                  );
                  /*} else {
                    AlertDialog(
                      title: Text("Alerta"),
                      content: Text("Usuario o Contraseña incorrectos"),
                    );
                  }*/
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}

/* INTENTO DE LLAMADA  PARA GUARDAR LOS CAMBIOS EN EL CONTROLLER
void _printLatestValue() {
    print('Second text field: ${Usuario.text}');
  }*/
