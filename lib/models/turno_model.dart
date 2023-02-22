// To parse this JSON data, do
//
//     final agenda = agendaFromMap(jsonString);

import 'dart:convert';

class Agenda {
    Agenda({
        required this.turno,
    });

    List<Turno> turno;

    factory Agenda.fromJson(String str) => Agenda.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Agenda.fromMap(Map<String, dynamic> json) => Agenda(
        turno: json["Turno"] == null ? [] : List<Turno>.from(json["Turno"]!.map((x) => Turno.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "Turno": turno == null ? [] : List<dynamic>.from(turno.map((x) => x.toMap())),
    };
}

class Turno {
    Turno({
        this.id,
        this.turno,
    });

    String? id;
    TurnoClass? turno;

    factory Turno.fromJson(String str) => Turno.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Turno.fromMap(Map<String, dynamic> json) => Turno(
        id: json["id"],
        turno: json["turno"] == null ? null : TurnoClass.fromMap(json["turno"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "turno": turno?.toMap(),
    };
}

class TurnoClass {
    TurnoClass({
        this.fecha,
        this.name,
        this.lluvia,
        this.court,
        this.idTurno,
    });

    String? fecha;
    String? name;
    String? lluvia;
    String? court;
    int? idTurno;

    factory TurnoClass.fromJson(String str) => TurnoClass.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TurnoClass.fromMap(Map<String, dynamic> json) => TurnoClass(
        fecha: json["fecha"],
        name: json["name"],
        lluvia: json["lluvia"],
        court: json["court"],
        idTurno: json["id_turno"],
    );

    Map<String, dynamic> toMap() => {
        "fecha": fecha,
        "name": name,
        "lluvia": lluvia,
        "court": court,
        "id_turno": idTurno,
    };
}
