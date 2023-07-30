import 'package:chinesequizapp/infrastructure/components/loading.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';

class ImagePadding extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final double top;
  final double right;
  final double bottom;
  final double left;
  final String imageName;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;
  final bool isNetwork;
  final bool isCircle;
  final double borderRadius;

  const ImagePadding(this.imageName, {super.key,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
    this.left = 0,
    this.width,
    this.height,
    this.color,
    this.padding,
    this.fit,
    this.isNetwork = false,
    this.isCircle = false,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
      ),
      margin: padding ?? EdgeInsets.only(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
      ),
      constraints: BoxConstraints(
        minWidth: width ?? 0,
        minHeight: height ?? 0,
      ),
      clipBehavior: isCircle || borderRadius > 0 ? Clip.hardEdge : Clip.none,
      child: _widgetImage(),
    );
  }

  Widget _widgetImage() {
    if (isNetwork) {
      return ExtendedImage.network(
        imageName,
        width: width,
        height: height,
        color: color,
        fit: fit ?? BoxFit.contain,
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return const Loading(
                size: 20,
              );
            case LoadState.completed:
              return null;
            case LoadState.failed:
              return Image(
                image: const AssetImage('assets/images/app_icon.png'),
                width: width,
                height: height,
                color: color,
                fit: fit ?? BoxFit.contain,
              );
          }
        },
      );
    } else {
      return Image(
        image: AssetImage(imageName.contains('assets/images') ? imageName : 'assets/images/$imageName'),
        width: width,
        height: height,
        color: color,
        fit: fit ?? BoxFit.contain,
      );
    }
  }
}