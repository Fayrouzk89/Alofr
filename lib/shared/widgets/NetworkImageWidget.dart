import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatefulWidget {
  final double width;
  final double height;
  final String url;

  NetworkImageWidget(
      {required this.width, required this.height, required this.url});

  @override
  State<NetworkImageWidget> createState() => _InputFieldState();
}

class _InputFieldState extends State<NetworkImageWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
         Text('')
          /*
          Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            color: ColorConstants.greenColor,

          ),
        ),
      ),

           */
      ,
      errorWidget: (context, url, error) => Image.asset(
        'images/logo.png',
        fit: BoxFit.fill,
      ),
      width: widget.width,
      height: widget.height,
      fit: BoxFit.fill,
    );
  }
}
