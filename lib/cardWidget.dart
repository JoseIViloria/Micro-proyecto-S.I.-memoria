import 'package:flutter/material.dart';
import 'package:microproyecto_si/global.dart';

// ignore_for_file: must_be_immutable

class CardWidget extends StatefulWidget {
  final int id;
  final String imagePath;
  final VoidCallback onClick;
  bool emparejado = false;

  CardWidget(this.id, this.imagePath, this.onClick, {super.key});

  @override
  State<CardWidget> createState() => CardWidgetState();
}

class CardWidgetState extends State<CardWidget> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: visible ? null : () {
        if (!widget.emparejado) {
          setState(() {
            visible = !visible;
            if (Global.clicks == 0) {
              Global.firstCardSelected = widget;
              Global.firstCardState = this;
              Global.clicks = 1;
            } else if (Global.clicks == 1) {
              Global.secondCardSelected = widget;
              Global.secondCardState = this;
              Global.clicks = 2;
            }
            if(Global.firstCardSelected?.id == Global.secondCardSelected?.id){
              widget.emparejado = true;
              Global.firstCardSelected?.emparejado = true;
              Global.secondCardSelected?.emparejado = true;
              widget.onClick();
              Global.clicks = 0;
            }
            else if(Global.clicks == 2){
              Future.delayed(const Duration(milliseconds: 500), () {
                Global.firstCardState?.setState(() {
                  Global.firstCardState?.visible = false;
                });
                Global.secondCardState?.setState(() {
                  Global.secondCardState?.visible = false;
                });
                Global.clicks = 0;
              });
            }
            
          });
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(20, 60),
      ),
      child: visible
          ? Image.asset(widget.imagePath)
          : SizedBox.expand(child: Container(color: Colors.blue,child: Text(widget.id.toString()),)),
    );
  }
}
