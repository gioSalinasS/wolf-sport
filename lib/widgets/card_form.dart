import 'package:flutter/material.dart';

class CardForm extends StatelessWidget {
  const CardForm({super.key});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              const _CamposInicio(),
              _dividerWithText("Datos del Tutor"),
              _spacer(),
              _buildInputField("Nombre del Tutor", Icons.person),
              _spacer(),
              _buildInputField("Teléfono", Icons.phone),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showSnackBar(context, "Datos guardados exitosamente");
                  }
                },
                child: const Text("Guardar"),
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

  Widget _buildInputField(String hintText, IconData icon) {
    return _buildInputFieldWithOptions(
      hintText: hintText,
      icon: icon,
      isDateField: false,
      validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
    );
  }

  static Widget _buildInputFieldWithOptions({
    required String hintText,
    required IconData icon,
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
  const _CamposInicio({super.key});

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          CardForm._buildInputFieldWithOptions(
            hintText: "Nombre completo",
            icon: Icons.person,
            isDateField: false,
            validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
          ),
          CardForm._buildInputFieldWithOptions(
            hintText: selectedDate == null ? "Fecha de nacimiento" : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            icon: Icons.calendar_today,
            isDateField: true,
            onTap: () => _selectDate(context),
            validator: (value) => selectedDate == null ? 'Campo requerido' : null,
          ),
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
        const Text("Categoría", style: TextStyle(color: Colors.white)),
        const SizedBox(height: 5.0),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            fillColor: Colors.white,
            filled: true,
          ),
          items: const [
            DropdownMenuItem(value: "infantil", child: Text("Infantil")),
            DropdownMenuItem(value: "junior", child: Text("Junior")),
          ],
          onChanged: (value) {},
          validator: (value) => value == null ? 'Campo requerido' : null,
        ),
      ],
    );
  }
}
