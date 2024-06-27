import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myappflutter/fetchMessage.dart';

class MessageDetailsPage extends StatefulWidget {
  final String title;
  final String id;
  final Map<String, String> headers;

  const MessageDetailsPage({super.key, required this.title, required this.id, required this.headers});

  @override
  State<MessageDetailsPage> createState() => _MessageDetailsPageState();
}

class _MessageDetailsPageState extends State<MessageDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<Map>(
        future: fetchMessagesContent(widget.id, widget.headers),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(children: [HtmlWidget(
                    snapshot.data!["response"][0]["content"].toString())],));
          } else if (snapshot.hasError) {
            return const Center(
                child: Column(
              children: [
                Icon(size: 50, Icons.error),
                Text("Ha ocurrido un error")
              ],
            ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
