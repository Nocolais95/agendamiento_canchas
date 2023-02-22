import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter/models/turno_model.dart';
import 'package:test_flutter/share_preferences/preferences.dart';

class StepperProvider with ChangeNotifier {
  String cancha = '';
  int currentStep = 0;
  String name = '';
  bool isOkey = false;
  bool isOkeyFecha = false;
  String fecha = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Agenda agenda = Agenda(turno: []);
  int idTurno = 0;
  String rain = '';

  Agenda getAgenda(){
    Agenda agendaMostrar = Preferences.turnos == '' ? Agenda(turno: []) : Agenda.fromJson(Preferences.turnos);
    return agendaMostrar;
  }
  setDeleteTurno(String id) {
    Agenda ag = getAgenda();
    int index = ag.turno.indexWhere((e) => e.id == id);
    ag.turno.removeAt(index);
    String a = ag.toJson();
    Preferences.turnos = a;
    notifyListeners();
  }
  String get getRain => rain;
  set setRain(String valor) {
    rain = valor;
    notifyListeners();
  }

  int get getIdTurno => idTurno;
  set setIdTurno(int valor) {
    idTurno = valor;
    notifyListeners();
  }

  Agenda get getTurnos => agenda;
  set setTurnos(Turno valor) {
    Agenda ag = (Preferences.turnos == '') ? Agenda(turno: <Turno> []) : Agenda.fromJson(Preferences.turnos);
    ag.turno.add(valor);
    agenda = Agenda(turno: ag.turno);
    String a = agenda.toJson();
    Preferences.turnos = a;
    notifyListeners();
  }

  String get getCancha => cancha;
  set setCancha(String valor) {
    cancha = valor;
    notifyListeners();
  }

  String get getFecha => fecha;
  set setFecha(String valor) {
    fecha = valor;
    notifyListeners();
  }

  bool get getIsOkey => isOkey;
  set setIsOkey(bool valor) {
    isOkey = valor;
  }
  bool get getIsOkeyFecha => isOkeyFecha;
  set setIsOkeyFecha(bool valor) {
    isOkeyFecha = valor;
    notifyListeners();
  }

  String get getName => name;
  set setName(String valor) {
    name = valor;
    notifyListeners();
  }

  int get getCurrentStep => currentStep;
  set setCurrentStep(int valor) {
    currentStep = valor;
    notifyListeners();
  }
}