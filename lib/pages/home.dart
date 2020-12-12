import 'package:flutter/material.dart';
import 'package:pruebatecnicaapp/models/preguntaModel.dart';
import 'package:pruebatecnicaapp/pages/detail.dart';
import '../providers/preguntasProvider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  final preguntasProvider = PreguntasProvider();
  
  Widget build(BuildContext context) {
     
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Preguntas'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  setState(() {
                    preguntasProvider.getPreguntas();
                  });
                },
                child: Icon(Icons.update)),
            )
            ],
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _mostrarDialogo();
          },
        ),
        body: _buildList());
  }

  _mostrarDialogo() {
    final titulo = TextEditingController();
    final contenido = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Añadir Pregunta'),
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
                child: Text('Añadir'),
                textColor: Colors.blue,
                onPressed: () async {
                  if (titulo.text != "" && contenido.text != "") {
                    preguntasProvider.addPreguntas(new Pregunta(
                        titulo: titulo.text, contenido: contenido.text));
                    await preguntasProvider.getPreguntas();
                    
                    setState(() {});
                    Navigator.pop(context);
                  }
                },
              )
            ],
          );
        });
  }
}

Widget _buildList() {
  final preguntasProvider = PreguntasProvider();

  return FutureBuilder(
    future: preguntasProvider.getPreguntas(),
    builder: (context, AsyncSnapshot<List<Pregunta>> res) {
      if (!res.hasData) {
        return Container();
      } else {
        return ListView.builder(
          itemCount: res.data.length,
          itemBuilder: (context, i) {
            return Column(
              children: <Widget>[
                Dismissible(
                  key: Key(res.data[i].id.toString()),
                  onDismissed: (DismissDirection direction) async {
                    await preguntasProvider.deletePreguntas(res.data[i]);
                   
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Registro Eliminado"),
                    ));
                  },
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Eliminar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Text('${res.data[i].titulo.substring(0, 2)}'),
                    ),
                    title: Text('${res.data[i].titulo}'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    titulo: '${res.data[i].titulo}',
                                    contenido: '${res.data[i].contenido}',
                                    id: '${res.data[i].id}'
                                  )));
                    },
                  ),
                ),
              ],
            );
          },
        );
      }
    },
  );
}
