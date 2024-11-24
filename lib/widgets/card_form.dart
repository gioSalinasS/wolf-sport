import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_sport/models/formulario_data.dart';
import 'package:wolf_sport/services/formulario_data_service.dart';
import 'package:wolf_sport/services/alumno_service.dart'; 

class CardForm extends StatefulWidget {
  const CardForm({super.key});

  @override
  _CardFormState createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreCompletoController = TextEditingController();
  final TextEditingController _nombreTutorController = TextEditingController();
  final TextEditingController _telefonoTutorController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController(); 
  String? _categoriaSeleccionada = "infantil"; 

  DateTime? selectedDate;

  @override
  void dispose() {
    _nombreCompletoController.dispose();
    _nombreTutorController.dispose();
    _telefonoTutorController.dispose();
    _fechaNacimientoController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              const _Indicadores(),
              _spacer(),
              _CamposInicio(
                nombreCompletoController: _nombreCompletoController,
                nombreTutorController: _nombreTutorController,
                telefonoTutorController: _telefonoTutorController,
                fechaNacimientoController: _fechaNacimientoController, 
                categoriaSeleccionada: _categoriaSeleccionada,
                onCategoriaChanged: (newValue) {
                  setState(() {
                    _categoriaSeleccionada = newValue;
                  });
                },
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                    _fechaNacimientoController.text = "${date.toLocal()}".split(' ')[0]; 
                  });
                },
              ),
              _dividerWithText("Datos del Tutor"),
              _spacer(),
              _buildInputField("Nombre del Tutor", Icons.person, _nombreTutorController),
              _spacer(),
              _buildInputField("Teléfono", Icons.phone, _telefonoTutorController),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final formulario = FormularioData(
                      nombreCompleto: _nombreCompletoController.text, 
                      fechaNacimiento: selectedDate ?? DateTime.now(),  
                      categoria: _categoriaSeleccionada ?? "infantil", 
                      nombreTutor: _nombreTutorController.text, 
                      telefonoTutor: _telefonoTutorController.text,  
                    );
                    final alumnoService = Provider.of<AlumnoService>(context, listen: false); 
                    
                    // Crear alumno dependiendo de la categoría seleccionada
                    if (_categoriaSeleccionada == "infantil") {
                      alumnoService.crearAlumnoInfantil(
                        nombre: formulario.nombreCompleto,
                        nombreTutor: formulario.nombreTutor,
                        telTutor: formulario.telefonoTutor,
                        fNacimiento: "${formulario.fechaNacimiento}",
                      ).then((id) {
                        showSnackBar(context, "Alumno de la categoria Infantil creado exitosamente.");
                      }).catchError((error) {
                        showSnackBar(context, "Error al crear el alumno Infantil");
                      });
                    } else if (_categoriaSeleccionada == "junior") {
                      alumnoService.crearAlumnoJunior(
                        nombre: formulario.nombreCompleto,
                        nombreTutor: formulario.nombreTutor,
                        telTutor: formulario.telefonoTutor,
                        fNacimiento: "${formulario.fechaNacimiento}",
                      ).then((id) {
                        showSnackBar(context, "Alumno de la categoria Junior creado exitosamente.");
                      }).catchError((error) {
                        showSnackBar(context, "Error al crear el alumno Junior");
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0070F0), 
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), 
                  ),
                  elevation: 5.0, 
                ),
                child: const Text(
                  "Guardar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _spacer() => const SizedBox(height: 10.0);

  Widget _dividerWithText(String text) {
    return Column(
      children: [
        const Divider(color: Colors.white),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF003366),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(color: Colors.white),
      ],
    );
  }

  Widget _buildInputField(String hintText, IconData icon, TextEditingController controller) {
    return _buildInputFieldWithOptions(
      hintText: hintText,
      icon: icon,
      controller: controller,  
      isDateField: false,
      validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
    );
  }

  Widget _buildInputFieldWithOptions({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    required bool isDateField,
    String? Function(String?)? validator,
    Function()? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 5.0),
        TextFormField(
          controller: controller, 
          readOnly: isDateField,
          onTap: onTap,
          validator: validator,
          decoration: InputDecoration(
            border: _borderStyle(),
            focusedBorder: _focusedBorderStyle(),
            enabledBorder: _borderStyle(),
            errorBorder: _errorBorderStyle(),
            hintText: hintText,
            suffixIcon: Icon(icon),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }

  static OutlineInputBorder _borderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: Colors.white, width: 2.0),
    );
  }

  static OutlineInputBorder _focusedBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: Colors.green, width: 3.0),
    );
  }

  static OutlineInputBorder _errorBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: Colors.red, width: 3.0),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class _Indicadores extends StatelessWidget {
  const _Indicadores({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Regi",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Roboto'),
            ),
            const TextSpan(
              text: "stro",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFF0070F0), fontFamily: 'Roboto'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CamposInicio extends StatefulWidget {
  final TextEditingController nombreCompletoController;
  final TextEditingController nombreTutorController;
  final TextEditingController telefonoTutorController;
  final TextEditingController fechaNacimientoController; 
  final String? categoriaSeleccionada;
  final Function(String?) onCategoriaChanged;
  final Function(DateTime) onDateSelected;

  const _CamposInicio({
    super.key,
    required this.nombreCompletoController,
    required this.nombreTutorController,
    required this.telefonoTutorController,
    required this.fechaNacimientoController,
    required this.categoriaSeleccionada,
    required this.onCategoriaChanged,
    required this.onDateSelected,
  });

  @override
  __CamposInicioState createState() => __CamposInicioState();
}

class __CamposInicioState extends State<_CamposInicio> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.onDateSelected(selectedDate!);  
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          _buildInputField("Nombre completo", Icons.person, widget.nombreCompletoController),
          _buildInputField("Fecha de nacimiento", Icons.calendar_today, widget.fechaNacimientoController, onTap: () => _selectDate(context)), 
          const SizedBox(height: 10.0),
          _buildDropdown(),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Categoría", style: TextStyle(color: Color(0xFF003366))),
        const SizedBox(height: 5.0),
        DropdownButtonFormField<String>(
          value: widget.categoriaSeleccionada,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            fillColor: Colors.white,
            filled: true,
          ),
          items: const [
            DropdownMenuItem(value: "infantil", child: Text("Infantil")),
            DropdownMenuItem(value: "junior", child: Text("Junior")),
          ],
          onChanged: widget.onCategoriaChanged,
          validator: (value) => value == null ? 'Campo requerido' : null,
        ),
      ],
    );
  }

  Widget _buildInputField(String hintText, IconData icon, TextEditingController controller, {Function()? onTap}) {
    return _buildInputFieldWithOptions(
      hintText: hintText,
      icon: icon,
      controller: controller,  
      isDateField: false,
      validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
      onTap: onTap, 
    );
  }

  Widget _buildInputFieldWithOptions({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    required bool isDateField,
    String? Function(String?)? validator,
    Function()? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 5.0),
        TextFormField(
          controller: controller, 
          readOnly: isDateField,
          onTap: onTap, 
          validator: validator,
          decoration: InputDecoration(
            border: _borderStyle(),
            focusedBorder: _focusedBorderStyle(),
            enabledBorder: _borderStyle(),
            errorBorder: _errorBorderStyle(),
            hintText: hintText,
            suffixIcon: Icon(icon),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }

  static OutlineInputBorder _borderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: Colors.white, width: 2.0),
    );
  }

  static OutlineInputBorder _focusedBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: Colors.green, width: 3.0),
    );
  }

  static OutlineInputBorder _errorBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: Colors.red, width: 3.0),
    );
  }
}
