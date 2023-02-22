// To parse this JSON data, do
//
//     final days = daysFromMap(jsonString);

import 'dart:convert';

class Days {
    Days({
        required this.days,
    });

    List<Day> days;

    factory Days.fromJson(String str) => Days.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Days.fromMap(Map<String, dynamic> json) => Days(
        days: json["Days"] == null ? [] : List<Day>.from(json["Days"]!.map((x) => Day.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "Days": days == null ? [] : List<dynamic>.from(days.map((x) => x.toMap())),
    };
}

class Day {
    Day({
        this.date,
        this.probPrecipPct,
    });

    String? date;
    double? probPrecipPct;
    

    factory Day.fromJson(String str) => Day.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Day.fromMap(Map<String, dynamic> json) => Day(
        date: json["date"],
        probPrecipPct: json["prob_precip_pct"],
    );

    Map<String, dynamic> toMap() => {
        "date": date,
        "prob_precip_pct": probPrecipPct,
    };
}
