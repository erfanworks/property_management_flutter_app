// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// //
// class ShimmerWidget extends StatelessWidget {
//   final double height;
//   final double width;
//   final ShapeBorder shapeBorder;
//
//   const ShimmerWidget.rectangular({
//     super.key,
//     required this.height,
//     this.width = double.infinity,
//   }) : shapeBorder = const RoundedRectangleBorder();
//
//   const ShimmerWidget.circular({
//     super.key,
//     required this.height,
//     this.width = double.infinity,
//     this.shapeBorder = const CircleBorder()
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         height: height,
//         width: width,
//         decoration: ShapeDecoration(
//             color: Colors.grey,
//             shape: shapeBorder
//         ),
//       ),
//     );
//   }
// }
