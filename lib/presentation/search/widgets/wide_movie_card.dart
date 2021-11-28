import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_movie/data/models/movie.dart';

class WideMovieCard extends StatelessWidget {
  const WideMovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTextStyle(
      style: TextStyle(color: Colors.grey[400]),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            height: 0.2 * size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white30,
            ),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: movie.imageUrl,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/error.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FittedBox(
                        child: Text(
                          movie.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Genre : ${movie.genre}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('Runtime: ${movie.runtime}'),
                      Text(movie.date)
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Text(
              movie.imdb.toString(),
              style: TextStyle(color: const Color(0xfff5c611), fontSize: 30.sp),
            ),
          )
        ],
      ),
    );
  }
}
