import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wolf_sport/models/formulario_data.dart';  


class FormularioDataService extends ChangeNotifier {
  final String _baseUrl = "wolf-sport-default-rtdb.firebaseio.com"; 

  final List<FormularioData> formularios = [];

  bool isLoading = true;
  bool isSaving = false;

  FormularioDataService() {
    obtenerFormularios();
  }

  Future<List<FormularioData>> obtenerFormularios() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'formularios.json');  
    final resp = await http.get(url);

    if (resp.body == 'null') {
      isLoading = false;
      notifyListeners();
      return [];
    }

    final Map<String, dynamic> formulariosMap = jsonDecode(resp.body);

    formulariosMap.forEach((key, value) {
      final tempFormulario = FormularioData.fromMap(value);
      tempFormulario.id = key; 
      formularios.add(tempFormulario);
    });

    isLoading = false;
    notifyListeners();
    return formularios;
  }

  Future<String> crearFormulario(FormularioData formulario) async {
    isSaving = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'formularios.json');  
    final resp = await http.post(url, body: formulario.toJson());

    final decodedData = json.decode(resp.body);
    formulario.id = decodedData['name'];  
    formularios.add(formulario);

    isSaving = false;
    notifyListeners();

    return formulario.id!;  
  }
  
}
