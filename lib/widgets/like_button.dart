import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key, required this.isLiked, required this.onPressed}) : super(key: key);
  final bool isLiked;
  final VoidCallback onPressed;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
      return IconButton(
          onPressed: widget.onPressed,
          icon: Icon(
            widget.isLiked ? Icons.favorite : Icons.favorite_border_rounded,
            color: widget.isLiked ? Colors.red : Colors.grey.shade700,
          )
      );
  }
}
