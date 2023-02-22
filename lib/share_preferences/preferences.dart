

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter/models/turno_model.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _turnos = '';
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get turnos{
    return _prefs.getString('turnos') ?? _turnos;
  }

  static set turnos(String turnos) {
    _turnos = turnos;
    _prefs.setString('turnos', turnos);
  }
  

}