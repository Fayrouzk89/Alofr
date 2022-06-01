import 'package:billing/shared/constants/colors.dart';
import 'package:flutter/material.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';
class SplashBackground extends StatelessWidget {
  /// 是否需要水波浪
  final bool needWave;
  final Widget? child;
  final bool needTopSafeArea;
  final bool needTopRadius;

  SplashBackground({
    Key? key,
    this.needWave = true,
    this.needTopSafeArea = true,
    this.needTopRadius = false,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return needTopSafeArea
        ? Container(
      color: Theme.of(context).colorScheme.primaryVariant,
      child: SafeArea(
        child: _buildBackground(context),
      ),
    )
        : _buildBackground(context);
  }

  Widget _buildBackground(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: needTopRadius
                ? BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            )
                : null,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.9],
              colors: [
                hexToColor('#4BAE4F'),
                hexToColor('#4BAE4F'),
              ],
            ),
          ),
          child: child,
        ),


      ],
    );
  }

}