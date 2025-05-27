import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeltonLoader extends StatelessWidget {


    double borderRadius ;
   final Duration period;

   SkeltonLoader({
     super.key,

     this.borderRadius = 8,
     this.period = const Duration(milliseconds: 1200),
   });

   @override
   Widget build(BuildContext context){
     return Shimmer.fromColors(
       baseColor: const Color(0xFFE8E8E8),
       highlightColor: const Color(0xFFF5F5F5),
       period: period,
       child: Container(

         decoration: BoxDecoration(
           color: Colors.white,               // ignored by shimmer
           borderRadius: BorderRadius.circular(borderRadius),
         ),
       ),
     );
   }
}