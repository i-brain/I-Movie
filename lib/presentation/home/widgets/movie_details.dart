import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/presentation/home/widgets/imdb_card.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FittedBox(
          child: Text(
            movie.name + ' (${movie.date})',
            style: TextStyle(fontSize: 20.sp),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          'Genre :${movie.genre}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            const IMDBCard(),
            Text(' : ${movie.imdb}'),
          ],
        ),
        SizedBox(height: 10.h),
        Text('Runtime : ${movie.runtime}'),
      ],
    );
  }
}
