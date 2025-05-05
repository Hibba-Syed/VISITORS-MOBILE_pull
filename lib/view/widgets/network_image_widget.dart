import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';

import '../../utils/validation_util.dart';

class NetworkImageWidget extends StatefulWidget {
  final String? url;
  final double width;
  final double height;
  final BoxFit? fit;
  final BoxShape shape;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final Widget? placeHolder;
  final Color? imageBackgroundColor;

  const NetworkImageWidget(
      {super.key,
      required this.url,
      this.width = 55.0,
      this.height = 55.0,
      this.fit = BoxFit.cover,
      this.shape = BoxShape.circle,
      this.border,
      this.borderRadius,
      this.placeHolder,
        this.imageBackgroundColor
      });

  @override
  State<NetworkImageWidget> createState() => _NetworkImageWidgetState();
}

class _NetworkImageWidgetState extends State<NetworkImageWidget> {
  late Widget _placeHolder;

  @override
  void initState() {
    super.initState();
    _placeHolder = Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.imageBackgroundColor ?? AppColors.gray,
        shape: widget.shape,
      ),
      child: widget.placeHolder ??
          const Icon(
            Icons.person,
            color: AppColors.darkGrey,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !ValidationUtil.isValid(widget.url)
        ? _placeHolder
        : CachedNetworkImage(
            imageUrl: widget.url!,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: widget.fit,
                  ),
                  shape: widget.shape,
                  border: widget.border,
                  borderRadius: widget.borderRadius),
            ),
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            errorWidget: (context, url, error) => _placeHolder,
            placeholder: (context, url) => _placeHolder,
          );
  }
}
