import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  final String title;
  final int userId;
  final String body;
  final int id;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  PostScreen({
    required this.title,
    required this.userId,
    required this.body,
    required this.id,
  });

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isEditable = false;

  late String title;
  late String body;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    body = widget.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Post text:"),
            const SizedBox(height: 30),
            Expanded(
                child: !isEditable
                    ? Text(body)
                    : TextFormField(
                        initialValue: body,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          setState(() {
                            isEditable = false;
                            body = value;
                          });
                        })),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.edit),
                iconSize: 35.0,
                onPressed: () {
                  setState(() {
                    isEditable = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
