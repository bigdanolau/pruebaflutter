import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pruebatecnicaapp/models/preguntaModel.dart';
import 'package:pruebatecnicaapp/providers/generalesProvider.dart';

class PreguntasProvider {
  final generalProvider = GeneralesProvider();
  final String _url = "http://146.71.79.163/api/v1";
  final String format = "?format=json";
  final preguntas = [];


  Future<List<Pregunta>> getPreguntas() async {
    var conexion = await this.generalProvider.veirifcarConexion();
    if (conexion) {
      try {
        final url = '$_url/preguntas/list' + this.format;
        final response = await http.get(url);
        final List<dynamic> decodedData = json.decode(response.body);
        final List<Pregunta> pregunta = (decodedData)
            .map<Pregunta>((json) => Pregunta.fromJson(json))
            .toList();

        return pregunta;
      } catch (e) {
        return [];
      }

      //  print(ListdecodedData);
      //  return ListdecodedData;
    } else {
      return [];
    }
  }

  Future<bool> addPreguntas(Pregunta preguntaadd) async {
    var conexion = await this.generalProvider.veirifcarConexion();
    if (conexion) {
      try {
        final url = '$_url/preguntas/create' + this.format;
        final response = await http.post(url, body: {
          "titulo": "${preguntaadd.titulo}",
          "contenido": "${preguntaadd.contenido}"
        });
        final Map decodedData = json.decode(response.body);
        if (decodedData['id'] != null) {

          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }

      //  print(ListdecodedData);
      //  return ListdecodedData;
    } else {
      return false;
    }
  }
  Future<bool> editPreguntas(Pregunta preguntaedit) async {
    var conexion = await this.generalProvider.veirifcarConexion();
    if (conexion) {
      try {
        final url = '$_url/preguntas/update/${preguntaedit.id.toString()}' + this.format;
        final response = await http.put(url, body: {
          "titulo": "${preguntaedit.titulo}",
          "contenido": "${preguntaedit.contenido}"
        });
        final Map decodedData = json.decode(response.body);
        if (decodedData['id'] != null) {

          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }

      //  print(ListdecodedData);
      //  return ListdecodedData;
    } else {
      return false;
    }
  }
  Future<bool> deletePreguntas(Pregunta preguntadelete) async {
    var conexion = await this.generalProvider.veirifcarConexion();
    if (conexion) {
      try {
        final url = '$_url/preguntas/delete/${preguntadelete.id}' + this.format;
        final response = await http.delete(url);
        final Map decodedData = json.decode(response.body);
        if (decodedData['id'] != null) {
          
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }

      //  print(ListdecodedData);
      //  return ListdecodedData;
    } else {
      return false;
    }
  }
}
