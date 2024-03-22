import 'package:flutter/material.dart';
import 'package:flutter_application/postcard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _data = [];

  Future<void> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _data = List<Map<String, dynamic>>.from(jsonData);
      });
    } else if (response.statusCode == 404) {
      // Обработка ошибки 404 (Not Found)
      print('Запрашиваемый ресурс не найден: ${response.statusCode}');
    } else if (response.statusCode == 500) {
      // Обработка ошибки 500 (Internal Server Error)
      print('Внутренняя ошибка сервера: ${response.statusCode}');
    } else {
      // Обработка других ошибок
      print('Неизвестная ошибка: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of posts'),
      ),
      body: _data.isNotEmpty
          ? ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final item = _data[index];
                return GestureDetector(
                  child: Dismissible(
                    key: Key(item['id'].toString()),
                    onDismissed: (direction) {
                      setState(() {
                        _data.removeAt(index);
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      child: const Center(
                        child: Text('Delete',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    child: PostCard(
                      title: item["title"],
                      userId: item["userId"],
                      body: item["body"],
                      id: item["id"],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
