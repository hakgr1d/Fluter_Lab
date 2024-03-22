import 'package:flutter/material.dart';

import 'postScreen.dart';

class PostCard extends StatefulWidget {
  final String title;
  final int userId;
  final int id;
  final String body;

  PostCard({
    required this.title,
    required this.userId,
    required this.id,
    required this.body,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = Tween(begin: 1.0, end: 0.80).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PostScreen(
                  title: widget.title,
                  userId: widget.userId,
                  body: widget.body,
                  id: widget.id,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () {
        _controller.reverse();
      },
      child: Transform.scale(
        scale: _animation.value,
        child: Card(
            elevation: 4.0,
            margin: const EdgeInsets.all(10.0),
            color: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: 150.0,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          ),
                        )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Owner id: ${widget.userId}, post id: ${widget.id}",
                        style: const TextStyle(
                            fontSize: 14, color: Colors.lightGreenAccent),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
