import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

extension ConvertToShimmer on Widget {
  Widget get convertToShimmer {
    return Shimmer.fromColors(baseColor: Colors.grey, highlightColor: Colors.white, child: this);
  }

  Widget get convertToShimmerWithContainer {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child:
            Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: this));
  }
}
