import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/presentation/widgets/add_watchlist_button.dart';
import 'package:i_movie/presentation/home/widgets/half_transparent_image.dart';

import 'movie_details.dart';

class TikTokWidget extends StatelessWidget {
  const TikTokWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return DefaultTextStyle(
      style: TextStyle(
          color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
      child: Container(
        height: mediaQuery.size.height - mediaQuery.padding.bottom,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Stack(
          fit: StackFit.expand,
          children: [
            HalfTransparentImage(
              imageUrl: movie.imageUrl,
            ),
            Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0.w),
                          child: MovieDetails(
                            movie: movie,
                          ),
                        ),
                      ),
                      Expanded(
                        child: AddWatchListButton(
                          movie: movie,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
