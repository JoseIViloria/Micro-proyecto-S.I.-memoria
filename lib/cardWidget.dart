import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final int id;
  final String imagePath;
  bool emparejado = false;
  bool visible = false;

  CardWidget(this.id, this.imagePath, {super.key});
  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(   
      onPressed: () {
        setState(() {
          widget.visible = !widget.visible;
        });
      },
      child: widget.visible
          ? Image.asset(widget.imagePath)
          : SizedBox(
            height: 100,
            width: 100,
            child: Container(
              color: Colors.blue,
              constraints: BoxConstraints(minHeight: 100, minWidth: 100),
            ),
    )
    );
  }
}
