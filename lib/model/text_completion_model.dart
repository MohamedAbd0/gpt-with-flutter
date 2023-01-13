class TextCompletionModel {
  final num created;
  final List<TextCompletionData> choices;

  TextCompletionModel({required this.created, required this.choices});

  factory TextCompletionModel.fromJson(Map<String, dynamic> json) {
    final textCompletionItems = json['choices'] as List;
    List<TextCompletionData> choices = textCompletionItems
        .map((singleItem) => TextCompletionData.fromJson(singleItem))
        .toList();

    return TextCompletionModel(
      choices: choices,
      created: json['created'],
    );
  }
}


class TextCompletionData{
  final String text;
  final num index;
  final String finishReason;
  final bool isSendMassage ;

  TextCompletionData({required this.text,required this.index,required this.finishReason,this.isSendMassage = false});


  factory TextCompletionData.fromJson(Map<String,dynamic> json){

    return TextCompletionData(
      text: json['text'],
      index: json['index'],
      finishReason: json['finish_reason'],
      isSendMassage: false,
    );
  }
}

/**
 /// text completion response
    {
    "id": "ewr-0SrUa1UJ4jAHWc6muODBj6SQdE8K1",
    "object": "text_completion",
    "created": 1672330820,
    "model": "text-davinci-003",
    "choices": [
    {
    "text": "\n\n1. Start with the basics: Before you dive into a new programming language, it’s important to understand the fundamentals of programming. Learn about variables, data types, control flow, and other basic concepts.\n\n2. Read tutorials and documentation: Once you have a basic understanding of programming concepts, read tutorials and documentation for the language you’re learning. This will help you understand how to use the language’s syntax and features.\n\n3. Practice coding: The best way to learn a new programming language is to actually write code in it. Try writing small programs or scripts to get familiar with the language’s syntax and features.\n\n4. Join online communities: There are many online communities dedicated to helping people learn new programming languages. Join one of these communities and ask questions when you get stuck or need help understanding something.\n\n5. Take an online course: If you want more structure in your learning process, consider taking an online",
    "index": 0,
    "logprobs": null,
    "finish_reason": "length"
    }
    ],
    "usage": {
    "prompt_tokens": 6,
    "completion_tokens": 200,
    "total_tokens": 206
    }

    }
 */
