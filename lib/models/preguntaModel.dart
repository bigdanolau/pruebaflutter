// To parse this JSON data, do
//
//     final pregunta = preguntaFromJson(jsonString);

import 'dart:convert';

List<Pregunta> preguntaFromJson(String str) => List<Pregunta>.from(json.decode(str).map((x) => Pregunta.fromJson(x)));

String preguntaToJson(List<Pregunta> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pregunta {
    Pregunta({
        this.id,
        this.titulo,
        this.contenido,
    });

    int id;
    String titulo;
    String contenido;

    factory Pregunta.fromJson(Map<String, dynamic> json) => Pregunta(
        id: json["id"],
        titulo: json["titulo"],
        contenido: json["contenido"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "contenido": contenido,
    };
}
