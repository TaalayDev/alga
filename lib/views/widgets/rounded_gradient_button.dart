import 'package:flutter/material.dart';

class RoundedGradientButton extends StatelessWidget {
  const RoundedGradientButton({this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFF6713D2), Color(0xFFCC208E)])),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 120,
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    onPressed: onPressed,
                  ),
                  Text(
                    "Добавить изображения",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
