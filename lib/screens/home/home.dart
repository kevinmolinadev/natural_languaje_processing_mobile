import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natural_languaje_processing_mobile/helpers/navigate.dart';
import 'package:natural_languaje_processing_mobile/models/user.dart';
import 'package:natural_languaje_processing_mobile/screens/login/login.dart';
import 'package:voice_to_text/voice_to_text.dart';

class Home extends StatefulWidget {
  final UserNLP user;
  const Home({required this.user, super.key});
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final VoiceToText _speech = VoiceToText();
  List<String> chat = [];
  String text =
      ""; //this is optional, I could get the text directly using speechResult
  @override
  void initState() {
    super.initState();
    _speech.initSpeech();
    _speech.addListener(() {
      setState(() {
        text = _speech.speechResult;
        text.isEmpty ? null : chat.add(text);
      });
    });
  }

  Widget newMessage(String questionInput) {
    if (questionInput.isEmpty) return const SizedBox();
    TextStyle styles = const TextStyle(fontSize: 15);
    Widget question = Card(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            questionInput,
            style: styles,
          ),
        ));
    Widget response = Card(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Text("El modelo respondio :D", style: styles),
    ));
    Widget content = Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: question,
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: response,
        ),
      ],
    );
    return Container(margin: const EdgeInsets.only(bottom: 10), child: content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Expanded(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Welcome ${widget.user.name} ${widget.user.lastName}"),
          )),
          IconButton(
            onPressed: () async {
              navigate(
                  context: context,
                  screen: const Login(),
                  method: MethodNavigate.replace);
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
            alignment: Alignment.centerRight,
          ),
        ],
      )),
      body: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Column(
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemCount: chat.length,
              itemBuilder: (context, index) {
                if (chat.isEmpty) return const SizedBox();
                return newMessage(chat[index]);
              },
            )),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50, // Ajusta la altura según tus necesidades
                  color: Colors.white, // Cambia el color según tus necesidades
                  child: IconButton(
                    color: Colors.blue,
                    onPressed:
                        // If not yet listening for speech start, otherwise stop
                        _speech.isNotListening
                            ? _speech.startListening
                            : _speech.stop,
                    tooltip: 'Listen',
                    icon: Icon(
                        _speech.isNotListening ? Icons.mic_off : Icons.mic),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
