import 'package:flutter/material.dart';
import 'package:pruebatecnicaapp/models/preguntaModel.dart';
import 'package:pruebatecnicaapp/providers/generalesProvider.dart';
import 'package:pruebatecnicaapp/providers/preguntasProvider.dart';

class DetailPage extends StatefulWidget {
  final titulo;
  final contenido;
  final id;
  DetailPage({this.titulo,this.contenido,this.id});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  final preguntasProvider = PreguntasProvider();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Respuestas'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () {
            _mostrarDialogo(context);
          
          },
        ),
      body: Container(
        child: Column(children: [
        SizedBox(height: 20),
        Center(child: Text(this.widget.titulo,style: TextStyle(fontSize: 20),)),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(this.widget.contenido),
        ),
        Container(
          padding: EdgeInsets.all(12),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Escribir Respuesta'
            ),
            
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: (){},
            color: Colors.blue,
            minWidth: double.infinity,
            child: Text('Enviar',style: TextStyle(color:Colors.white),),
          ),
        )
        ],),
      ),
    );
  }

   _mostrarDialogo(BuildContext contexto) {
    final titulo = TextEditingController();
    final contenido = TextEditingController();
    final generalProvider = GeneralesProvider();
    showDialog(
        context: context,
        builder: (context) {
          titulo.text = this.widget.titulo;
          contenido.text = this.widget.contenido;
          return AlertDialog(
            title: Text('Editar Pregunta'),
            content: Container(
                child: Wrap(
              children: [
                TextField(
                  controller: titulo,
                  
                  decoration: InputDecoration(
                    hintText: 'Titulo',
                  ),
                ),
                TextField(
                  controller: contenido,
                  decoration: InputDecoration(
                    hintText: 'Contenido',
                  ),
                ),
              ],
            )),
            actions: [
              MaterialButton(
                child: Text('Actualizar'),
                textColor: Colors.blue,
                onPressed: () async {
                  if (titulo.text != "" && contenido.text != "") {
                    preguntasProvider.editPreguntas(new Pregunta(
                        titulo: titulo.text, contenido: contenido.text,id: int.parse(this.widget.id)));
                    
                    await preguntasProvider.getPreguntas();
                    setState(() {});
                    
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          );
        });
  }
}