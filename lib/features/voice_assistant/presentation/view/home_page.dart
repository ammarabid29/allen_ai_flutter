import 'package:allen_ai_flutter/core/colors/pallete.dart';
import 'package:allen_ai_flutter/features/voice_assistant/presentation/view/widgets/feature_box.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeechToText();
  }

  void _initSpeechToText() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Allen"),
        leading: Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // virtual assistant image
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/virtualAssistant.png"),
                    ),
                  ),
                ),
              ],
            ),

            // chat bubble
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius: BorderRadius.circular(
                  20,
                ).copyWith(topLeft: Radius.zero),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Good Morning! What task can I do for you?",
                  style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: 25,
                    fontFamily: "Cera Pro",
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10, left: 22),
              alignment: Alignment.centerLeft,
              child: Text(
                "Here are a few suggestions",
                style: TextStyle(
                  fontFamily: "Cera Pro",
                  color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // features list
            Column(
              children: [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: "ChatGpt",
                  descText:
                      "A smarter way to stay organized and informed with Chatgpt",
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: "Dall-E",
                  descText:
                      "Get inspired and stay creative with your personal assistant powered by Dall-E",
                ),
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: "Smart Voice Assistant",
                  descText:
                      "Get the best of both worlds with a voice assistant powered by Chatgpt and Dall-E",
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: () async {
          if (await _speechToText.hasPermission &&
              _speechToText.isNotListening) {
            await _startListening();
          } else if (_speechToText.isListening) {
            await _stopListening();
          } else {
            _initSpeechToText();
          }
        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
