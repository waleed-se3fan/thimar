import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SectionShimmer extends StatelessWidget {
  const SectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              color: Colors.grey.shade300,
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 10,
              width: 30,
              color: Colors.grey.shade300,
            )
          ],
        ));
  }
}

class AnimatedImagesShimmer extends StatelessWidget {
  const AnimatedImagesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.only(top: 25.h),
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade300,
      ),
    );
  }
}
