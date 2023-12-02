import 'package:flutter/material.dart';
import 'package:natural_languaje_processing_mobile/models/user.dart';

class QuestionsScreen extends StatelessWidget {
  final UserNLP user;

  const QuestionsScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: RichText(
            textAlign: TextAlign.end,
            text: const TextSpan(
              style: TextStyle(
                color: Colors.white, // Blanco (invertido)
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Preguntas que puedes realizar',
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xFF9E0044), // Rojo oscuro (invertido)
        ),
      ),
      body: Container(
        color: Colors.white, // Blanco (invertido)
        child: Column(
          children: [
            Expanded(
              child: QuestionsList(),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionsList extends StatelessWidget {
  final List<String> questions = [
    '¿Cuáles son los horarios de atención de las oficinas de trámites y archivos?',
    '¿Quiénes desarrollaron este modelo de procesamiento de lenguaje natural?',
    '¿Cuáles son las becas disponibles para estudiantes regulares de la universidad?',
    '¿Cuándo se fundó la universidad y cuál es su historia?',
    '¿Quién es el encargado de trámites, archivos y habilitaciones?',
    '¿Cuántas sedes tiene la universidad y dónde están ubicadas?',
    '¿Cuáles son los horarios de atención de las cajas y dirección de carrera?',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return BubbleMessage(
          message: questions[index],
        );
      },
    );
  }
}

class BubbleMessage extends StatelessWidget {
  final String message;

  const BubbleMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF9E0044), // Rojo oscuro (invertido)
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Blanco (invertido)
          ),
        ),
      ),
    );
  }
}
