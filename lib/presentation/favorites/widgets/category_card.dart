import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_movie/bloc/favorites/favorites_cubit.dart';
import 'package:provider/src/provider.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.genre}) : super(key: key);

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: InkWell(
        splashColor: Colors.green[600],
        borderRadius: BorderRadius.circular(8.r),
        onTap: context.read<FavoritesCubit>().fetchNextFavorites,
        child: Center(
            child: Text(
          genre,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: Colors.black,
          ),
        )),
      ),
    );
  }
}
