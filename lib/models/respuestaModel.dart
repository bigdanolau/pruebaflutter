// To parse this JSON data, do
//
//     final respuesta = respuestaFromJson(jsonString);

import 'dart:convert';

List<Respuesta> respuestaFromJson(String str) => List<Respuesta>.from(json.decode(str).map((x) => Respuesta.fromJson(x)));

String respuestaToJson(List<Respuesta> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Respuesta {
    Respuesta({
        this.id,
        this.titulo,
        this.contenido,
        this.publicado,
        this.pregunta,
    });

    int id;
    String titulo;
    String contenido;
    bool publicado;
    int pregunta;

    factory Respuesta.fromJson(Map<String, dynamic> json) => Respuesta(
        id: json["id"],
        titulo: json["titulo"],
        contenido: json["contenido"],
        publicado: json["publicado"],
        pregunta: json["pregunta"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "contenido": contenido,
        "publicado": publicado,
        "pregunta": pregunta,
    };
}
