// import 'package:flutter/material.dart';
// import 'package:liquid_swipe/liquid_swipe.dart';

// class LiquidSwipeExample extends StatefulWidget {
//   const LiquidSwipeExample({ Key? key }) : super(key: key);

//   @override
//   _LiquidSwipeExampleState createState() => _LiquidSwipeExampleState();
// }

// class _LiquidSwipeExampleState extends State<LiquidSwipeExample> {

//   // Photos from google
//   final pages = [
//     Container(
//       height: double.infinity,
//       child: Image.network('https://w0.peakpx.com/wallpaper/114/378/HD-wallpaper-squid-game-netflix-electric-blue-magenta-squid-game.jpg', fit: BoxFit.cover,),),
//     Container(
//       height: double.infinity,
//       child: Image.network('https://w0.peakpx.com/wallpaper/432/1/HD-wallpaper-el-juego-del-calamar-netflix-squid-game.jpg', fit: BoxFit.cover,),),
//     Container(
//       height: double.infinity,
//       child: Image.network('https://w0.peakpx.com/wallpaper/114/378/HD-wallpaper-squid-game-netflix-electric-blue-magenta-squid-game.jpg', fit: BoxFit.cover,),),
//     Container(
//       height: double.infinity,
//       child: Image.network('https://w0.peakpx.com/wallpaper/432/1/HD-wallpaper-el-juego-del-calamar-netflix-squid-game.jpg', fit: BoxFit.cover,),),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Builder(
//         builder: (context) {
//           return LiquidSwipe(
//             pages: pages,
//             fullTransitionValue: 880,
//             waveType: WaveType.circularReveal,
//             slideIconWidget: Icon(Icons.arrow_back_ios, color: Colors.white,),
//             positionSlideIcon: 0.8,
//             onPageChangeCallback: (page) {
//               print(page);
//             },
//             liquidController: LiquidController(),
//           );
//         },
//       ),
//     );
//   }
// }
