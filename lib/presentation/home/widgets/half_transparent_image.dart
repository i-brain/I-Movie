import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_movie/presentation/home/widgets/cool_linear_progress_indicator.dart';

class HalfTransparentImage extends StatelessWidget {
  const HalfTransparentImage({Key? key, required this.imageUrl})
      : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,

          colors: <Color>[
            Colors.black.withOpacity(1.0),
            Colors.black.withOpacity(1.0),
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.3), // <-- change this opacity
            // Colors.transparent // <-- you might need this if you want full transparency at the edge
          ],
          stops: const [
            0.0,
            0.5,
            0.55,
            1.0
          ], //<-- the gradient is interpolated, and these are where the colors above go into effect (that's why there are two colors repeated)
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        alignment: Alignment.topCenter,
        height: size.height * 0.72,
        placeholder: (context, url) => const CoolLinearProgressIndicator(),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/error.png',
          height: size.height * 0.72,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
