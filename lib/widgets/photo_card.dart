import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    Key? key,
    required this.image,
  }) : super(key: key);
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Material(
        color: Colors.white,
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: image,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.heart_broken)),
              IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
              IconButton(onPressed: () {}, icon: Icon(Icons.send))
            ],
          )
        ]),
      ),
    );
  }
}
