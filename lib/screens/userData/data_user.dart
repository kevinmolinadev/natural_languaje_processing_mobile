import 'package:flutter/material.dart';
import 'package:natural_languaje_processing_mobile/models/user.dart';

class DataUser extends StatelessWidget {
  final UserNLP user;

  const DataUser({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Datos'),
        backgroundColor: const Color(0xFF9E0044), // Color principal
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono de usuario
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF9E0044), // Color principal
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildUserInfo(context, 'Nombre', user.name),
            _buildUserInfo(context, 'Apellido', user.lastName),
            _buildUserInfo(context, 'Correo Electrónico', user.email),
            // Puedes agregar más información del usuario si es necesario
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9E0044), // Color principal
            ),
          ),
          Container(
            height: 2,
            width:
                MediaQuery.of(context).size.width / 2, // Mitad de la pantalla
            color: const Color(0xFF9E0044), // Color principal
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF9E0044), // Color principal
            ),
          ),
        ],
      ),
    );
  }
}
