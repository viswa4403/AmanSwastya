import 'package:first_app/pages/home_page.dart';
import 'package:first_app/util/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:typeset/typeset.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _chatTextController = TextEditingController();
  final List<Map<String, dynamic>> _chatMessages = <Map<String, dynamic>>[
    {
      "message":
          "Hello! I'm Aman Chayatri, your personalised assistant. Ask me about fitness related questions",
      "isGemini": true,
      "timestamp": DateTime.now(),
    }
  ];

  late GenerativeModel model;
  late ChatSession chat;

  bool _isChatBotThinking = false;

  @override
  void initState() {
    model = GenerativeModel(
      model: "gemini-pro",
      apiKey: "AIzaSyDb_PhoPBJDP-WgkdFrRWr6SnGjd3FiXOk",
    );

    chat = model.startChat(
      history: [
        Content.text(
          "You are an expert fitness coach.The target audience is fitness enthusiasts who are interested in staying healthy and improving their physical fitness. Answer the questions they have.",
        ),
        Content.model(
          [
            TextPart(
              'Let us get started! ',
            ),
          ],
        ),
      ],
    );
    super.initState();
  }

  @override
  void dispose() {
    _chatTextController.dispose();
    super.dispose();
  }

  Widget _buildChatMessage(Map<String, dynamic> message) {
    return message["isGemini"] == true
        ? Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 12.0,
            ),
            child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                dense: true,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                title: TypeSet(
                  message["message"] ?? "I'm sorry, I don't understand.",
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                subtitle: Text(
                  "\n${Helper().humanReadableAgoTime(
                    Timestamp.fromMillisecondsSinceEpoch(
                      message["timestamp"].millisecondsSinceEpoch,
                    ),
                  )}",
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                )),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 12.0,
            ),
            child: ListTile(
              selected: true,
              selectedTileColor:
                  Theme.of(context).colorScheme.secondaryContainer,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              dense: true,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              trailing: const CircleAvatar(
                child: Icon(
                  Icons.person_2_rounded,
                ),
              ),
              title: Text(
                message["message"] ?? "",
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              subtitle: Text(
                Helper().humanReadableAgoTime(
                    Timestamp.fromMillisecondsSinceEpoch(
                        message["timestamp"].millisecondsSinceEpoch)),
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            centerTitle: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            expandedHeight: MediaQuery.of(context).size.height * 0.16,
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            //   icon: const Icon(Icons.arrow_back_rounded),
            // ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false);
              },
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 8.0,
              ),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32.0),
                  bottomRight: Radius.circular(32.0),
                ),
                child: Image.asset(
                  "assets/aman.jpg",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  "Aman Chayatri",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16.0,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _buildChatMessage(_chatMessages[index]);
              },
              childCount: _chatMessages.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          12.0,
          12.0,
          12.0,
          MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: _isChatBotThinking == false
            ? TextFormField(
                enabled: !_isChatBotThinking,
                controller: _chatTextController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a message.";
                  }
                  return null;
                },
                scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  hintText: "Ask Aman Chayatri anything...",
                  suffixIcon: IconButton(
                    onPressed: () async {
                      if (_chatTextController.text.isNotEmpty) {
                        setState(() {
                          _chatMessages.add({
                            "message": _chatTextController.text,
                            "isGemini": false,
                            "timestamp": DateTime.now(),
                          });
                          _isChatBotThinking = true;
                        });

                        try {
                          var response = await chat.sendMessage(
                            Content.text(_chatTextController.text),
                          );

                          var theResponse = response.text;

                          theResponse ??= "I'm sorry, I don't understand.";

                          setState(() {
                            _chatMessages.add({
                              "message": theResponse,
                              "isGemini": true,
                              "timestamp": DateTime.now(),
                            });
                            _isChatBotThinking = false;
                          });
                        } catch (e) {
                          setState(() {
                            _chatMessages.add({
                              "message": "I'm sorry, I don't understand.",
                              "isGemini": false,
                              "timestamp": DateTime.now(),
                            });
                            _isChatBotThinking = false;
                          });
                        } finally {
                          _chatTextController.clear();
                        }
                      }
                    },
                    icon: const Icon(Icons.send_rounded),
                  ),
                ),
              )
            : const LinearProgressIndicator(),
      ),
    );
  }
}
