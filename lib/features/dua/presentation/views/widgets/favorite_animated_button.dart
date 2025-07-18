import 'package:flutter/material.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';

class FavoriteAnimatedButton extends StatefulWidget {
  const FavoriteAnimatedButton({super.key});

  @override
  State<FavoriteAnimatedButton> createState() => _FavoriteAnimatedButtonState();
}

class _FavoriteAnimatedButtonState extends State<FavoriteAnimatedButton>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _colorAnimation = ColorTween(
      begin: ColorsManger.grey,
      end: ColorsManger.primary,
    ).animate(_animationController);

    _sizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 30), weight: 50),
    ]).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isFavorite = true;
      } else if (status == AnimationStatus.dismissed) {
        isFavorite = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return IconButton(
          color: _colorAnimation.value,
          iconSize: _sizeAnimation.value,
          onPressed: () {
            if (isFavorite) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
          },
          icon: Icon(Icons.favorite),
        );
      },
    );
  }
}
