# chat_gpt_sdk_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 1. Research: Chat GPT SDK Flutter

- Keywords:
    - chatgpt flutter
    - chatgpt sdk
    - flutter chatgpt sdk
    - chatgpt flutter app
    - flutter ai
    - flutter chat gpt github
    - chatbot gpt github
    - flutter chatbot github
    - build chatgpt app in flutter using openai api
    - openai_gpt3_api flutter
    - how to use chat gpt api in flutter
    - flutter ai package
    - flutter ai projects
    - chat gpt and flutter
    - how to use chat gpt api in flutter
    - chat gpt api key
    - chat gpt api documentation
- Video Title: Chat GPT SDK Flutter Package | Flutter OpenAI Chat bot using ChatGPT SDK Package of
  Flutter with GPT-4, 3.5 and SSE

## 2. Research: Competitors

**Flutter Videos/Articles**

- 56K: https://youtu.be/94JmNb1IhX0
- 6.1k: https://youtu.be/UaKFvEPjs9I
- 2.9K: https://youtu.be/qUEUMxGW_0Q
- https://pub.dev/packages/chat_gpt_sdk
- https://pub.dev/documentation/chat_gpt_sdk
- https://dev.to/riyaspullurofficial/chat-gpt-openai-using-flutter-48bh

**Android/Swift/React Videos**

- 1.8K: https://youtu.be/bLktoOzb4R0
- 1.2K: https://youtu.be/yw0c2IVfzYg
- 1.1K: https://youtu.be/Jl51WzDpnYE
- 1.1K: https://youtu.be/nmwJceyIRLk
- 30K: https://youtu.be/ahhze_u5ZUs
- 28K: https://www.youtube.com/watch?v=9DjbQpbQVFo
- 184: https://www.youtube.com/watch?v=EbfHc2vZKW4
- 1.5K: https://www.youtube.com/watch?v=uuuz9TrjVvA
- 5K: https://www.youtube.com/watch?v=0FDiaNcW5s4
- 4.6K: https://www.youtube.com/watch?v=tdxgG9Gq41A
- 64K: https://www.youtube.com/watch?v=kR9Kgo8H7po
- 18K: https://www.youtube.com/watch?v=XtnYX1m2Ha8
- https://www.codester.com/items/42353/chat-gpt-ai-chatbot-android-app-with-kotlin
- https://github.com/lambiengcode/compose-chatgpt-kotlin-android-chatbot
- https://www.geeksforgeeks.org/how-to-build-a-chatgpt-like-app-in-android-using-openai-api/
- https://iosexample.com/chat-gpt-open-ai-with-swift-for-ios/
- https://medium.com/codex/how-to-integrate-openais-gpt-3-in-swift-337973ce209c
- https://chatbotslife.com/how-to-add-chatbot-to-react-native-7176bc19a7f
- https://medium.com/@hrupesh/creating-a-chatbot-and-translation-app-with-nextjs-and-react-native-using-chatgpt-e4cc6c986106
- https://medium.com/@hello_chirag/creating-powerful-chatbots-a-developers-guide-to-integrating-chatgpt-and-react-native-dfa320e33917

**Great Features**

- This plugin creates chat bot and other bots with ChatGPT supporting GPT-4 , 3.5 and SSE Prompt (
  Stream).
- Find more features at [pub.dev](https://pub.dev/packages/chat_gpt_sdk).

**Problems from Videos**

- Question: How will generate my own api token?

Answer: Find your OpenAI API key [here](https://platform.openai.com/account/api-keys).

- Question: In the AIHandler class, the dispose method is giving an error, it says 'error: The
  method 'close' isn't defined for the type 'OpenAI'. ... How to solve this?

Answer: Use 'cancelAIGenerate' instead of 'close' in the updated version up to 2.1.2 now.

**Problems from Flutter Stackoverflow**

- https://stackoverflow.com/questions/75524962/flutter-chatgpt-sdk-continue-discussion-with-context

## 3. Video Structure

**Main Points / Purpose Of Lesson**

1. In this video, you will learn how to use OpenAI ChatGPT as chat bot for users to question from
   chat bot.
2. Main points:
    - Use chat_gpt sdk for this purpose.
    - Get your api key from [here](https://platform.openai.com/account/api-keys).
    - Initialize OpenAI
3. This can also be used for SSE stream chat by some modifications in this project.

**The Structured Main Content**

1. Run `dart pub add chat_gpt_sdk` in your terminal to add chat_gpt_sdk in your project's
   pubspec.yaml file.
2. In `main.dart` file, there are some theming properties and `ChatBotPage` is being called
   through `home` property.
3. In `message_model.dart` file, there is simple model with isBot and message arguments:

```dart
class MessageModel {
  final bool isBot;
  final String message;

  MessageModel(this.isBot, this.message);
}

```

4. In `chat_bot_page.dart` file, I have defined some constants and variables:

kDefault and kHeight are constants used for UI.

textMessage is used to control the text field where question is written.

openAI is initialized here and then will be declared in initState.

apiKey is OpenAI secret key.

messages is list of MessageModel.

```dart

static const kDefault = 15.0;
static const kHeight = 50.0;

final textMessage = TextEditingController();
late OpenAI openAI;

/// openai api key
final apiKey = 'YOUR_OPENAI_API_KEY';
final messages = [MessageModel(true, 'Hi')];
```

OpenAI is initialized as `openAI = OpenAI.instance.build(token: apiKey);` in initState and disposed
as `openAI.cancelAIGenerate();` in dispose method:

```dart
  @override
void initState() {
  openAI = OpenAI.instance.build(token: apiKey);
  super.initState();
}

@override
void dispose() {
  textMessage.dispose();
  openAI.cancelAIGenerate();
  super.dispose();
}
```

Code for sending message to OpenAI chat bot is here.

`message` is required for this method which is to be asked from OpenAI.

`CompleteText` is assigned to request variable. It requires prompt and model parameters. model is
set to Model.textDavinci3. You can also choose another models.

Then this request of CompleteText is passed to OpenAI.onCompletion which requires
CompleteText. `openAI.onCompletion(request: request);`

Through `event?.choices.last.text` new message is added to list of messages by using setState to
update UI.

```dart
  void sendMessage(String message) async {
  final request = CompleteText(
    prompt: message,
    model: Model.textDavinci3,
    maxTokens: 200,
  );

  final event = await openAI.onCompletion(request: request);
  setState(() {
    messages.add(
      MessageModel(true, '${event?.choices.last.text}'),
    );
    for (var element in messages) {
      debugPrint(element.toString());
      debugPrint('element.message => ${element.message}');
    }
  });
}
```

Following is the code for UI.

```dart
  @override
Widget build(BuildContext context) =>
    Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          messageList(),
          bottomNavigation(context),
        ],
      ),
    );
```

appBar() widget code is following:

```dart
  AppBar appBar() =>
    AppBar(
      leading: const Padding(
        padding: EdgeInsets.only(left: kDefault * 0.8),
        child: CircleAvatar(
          backgroundImage: AssetImage('chatGptImage.PNG'),
          radius: 50,
        ),
      ),
      title: const Text('ChatGPT SDK Flutter'),
    );
```

bottomNavigation(context) code is following:

```dart
Align bottomNavigation(context) =>
    Align(
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
```

messageList() widget contains userCard() widget and botCard() widget:

`ListView.builder` itemCount is according to the length of list of messages.

itemBuilder first confirms that if the message in the list of messages is from bot then show bot
card otherwise show the user card.

```dart
  Flexible messageList() {
  return Flexible(
    child: ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) =>
      messages[index].isBot
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

Padding botCard({required int index}) =>
    Padding(
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

```