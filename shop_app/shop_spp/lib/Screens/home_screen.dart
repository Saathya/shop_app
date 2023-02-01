import 'package:flutter/material.dart';

import '../widget/brand_highlights.dart';
import '../widget/home_product_list.dart';
import '../widget/home_widget.dart';

// import 'package:multi_shop_app/widget/banner_widget.dart';
// import 'package:multi_shop_app/widget/brand_highlights.dart';
// import 'package:multi_shop_app/widget/category_widget.dart';


class HomeScreen extends StatelessWidget {
  static const String id = "home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeWidget(),
            BrandHighlights(),
            SizedBox(height: 10),
            HomeProduct(),
           
          ],
        ),
      ),
    );
  }
}

// class SearchWidget extends StatelessWidget {
//   const SearchWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 55,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(4),
//               child: const TextField(
//                 decoration: InputDecoration(
//                   focusColor: Colors.grey,
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 5),
//                   hintText: 'Search in Saloni Studio App',
//                   hintStyle: TextStyle(color: Colors.grey),
//                   prefixIcon: Icon(
//                     Icons.search,
//                     size: 24,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 20,
//           width: MediaQuery.of(context).size.width,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Row(
//                 children: const [
//                   Icon(CupertinoIcons.info_circle,
//                       size: 18, color: Colors.black),
//                   Text(
//                     " 100% Genuine",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700),
//                   )
//                 ],
//               ),
//               Row(
//                 children: const [
//                   Icon(CupertinoIcons.info_circle,
//                       size: 18, color: Colors.black),
//                   Text(
//                     " 5-10 Days Easy Return",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700),
//                   )
//                 ],
//               ),
//               Row(
//                 children: const [
//                   Icon(
//                     CupertinoIcons.info_circle,
//                     size: 18,
//                     color: Colors.black,
//                   ),
//                   Text(
//                     " Trusted Products",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }





// ActionChip(
//                     padding: EdgeInsets.zero,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5)),
//                     backgroundColor: _selectedCategory == category.catName
//                         ? Colors.purple
//                         : Colors.grey.shade400,
//                     label: Column(
//                       children: [
//                         CachedNetworkImage(imageUrl: category.image),
//                         Text(
//                           category.catName,
//                           style: TextStyle(
//                               fontSize: 12,
//                               color: _selectedCategory == category.catName
//                                   ? Colors.white
//                                   : Colors.black),
//                         ),
//                       ],
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _selectedCategory = category.catName;
//                       });
//                     },
                  // )
// }
