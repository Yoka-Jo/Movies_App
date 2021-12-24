import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;

  const ImageCard({Key? key, required this.imageUrl}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.network(
        imageUrl,
        height: 200,
        width: 120,
        fit: BoxFit.cover,
      ),
    );
  }
}
