import 'package:flutter/material.dart';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

import 'model/message_model.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final textMessage = TextEditingController();
  late OpenAI openAI;

  // StreamSubscription? subscription;
  static const kDefault = 15.0;
  static const kHeight = 50.0;

  /// openai api key
  final apiKey = 'YOUR_OPENAI_API_KEY';

  /// list messages
  // final messages =
  // UnmodifiableListView<MessageModel>([MessageModel(true, 'Hi')]);

  final messages = [MessageModel(true, 'Hi')];

  void sendMessage(String message) async {
    // final request = CompleteText(
    //   prompt: message,
    //   // model: kTranslateModelV3,
    //   model: kChatGptTurbo,
    //   maxTokens: 2000,
    // );
    // final event = await openAI.onCompletion(request: request);
    // // .asBroadcastStream()
    // // .listen((event) {
    final request = CompleteText(
      prompt: message,
      model: Model.textDavinci3,
      maxTokens: 200,
    );

    // subscription = openAI.build(token: apiKey).onChatCompletion(request: request).asStream().listen((event) { });

    final event = await openAI.onCompletion(request: request);
    setState(() {
      messages.add(
        MessageModel(true, '${event?.choices.last.text}'),
      );
      for (var element in messages) {
        debugPrint(element.toString());
        debugPrint(event?.choices.last.text);
        debugPrint('element.message => ${element.message}');
      }
    });
    // // });
  }

  @override
  void initState() {
    openAI = OpenAI.instance.build(token: apiKey);
    super.initState();
  }

  @override
  void dispose() {
    textMessage.dispose();
    openAI.cancelAIGenerate();
    // subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          messageList(),
          bottomNavigation(context),
        ],
      ),
    );
  }

  Flexible messageList() {
    return Flexible(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) => messages[index].isBot
            ? botCard(index: index)
            : userCard(index: index),
      ),
    );
  }

  Padding userCard({required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefault,
        vertical: kDefault,
      ),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          Positioned(
            right: kHeight,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefault / 1.1,
                    vertical: kDefault / 1.2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(kDefault * 1.8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.12),
                        offset: const Offset(.5, kDefault / 1.6),
                        blurRadius: kDefault * 2,
                      ),
                    ],
                  ),
                  child: Text(messages[index].message.trim()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding botCard({required int index}) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefault,
          vertical: kDefault,
        ),
        child: Stack(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('chatGptImage.PNG'),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: kDefault * 3.6),
              padding: const EdgeInsets.symmetric(
                horizontal: kDefault / 1.1,
                vertical: kDefault / 1.2,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(kDefault * 1.8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.12),
                    offset: const Offset(kDefault / 1.2, kDefault / 2),
                    blurRadius: kDefault * 2,
                  ),
                ],
              ),
              child: Text(
                messages[index].message.trim(),
                maxLines: 100,
              ),
            ),
          ],
        ),
      );

  Align bottomNavigation(context) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
            horizontal: kDefault,
            vertical: kDefault / 1.5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(kDefault),
              topLeft: Radius.circular(kDefault),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.23),
                offset: const Offset(kDefault / 1.2, .5),
                blurRadius: kDefault,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.12),
              borderRadius: BorderRadius.circular(kDefault),
            ),
            child: TextFormField(
              controller: textMessage,
              autofocus: true,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    sendMessage(textMessage.text.toString());
                    setState(() {
                      messages.add(
                        MessageModel(false, textMessage.text.toString()),
                      );
                      textMessage.text = '';
                    });
                  },
                  child: const Icon(
                    Icons.send,
                    size: kDefault * 1.6,
                    color: Colors.blue,
                  ),
                ),
                hintText: 'Enter question here',
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.send,
            ),
          ),
        ),
      );

  AppBar appBar() => AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: kDefault * 0.8),
          child: CircleAvatar(
            backgroundImage: AssetImage('chatGptImage.PNG'),
            radius: 50,
          ),
        ),
        title: const Text('ChatGPT SDK Flutter'),
      );
}
