import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../Models/category_model.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  // String? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Category For You",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 20),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View all...',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              )
            ],
          ),
          SizedBox(
            height: 99,
            child: FirestoreListView<CategoryModel>(
              scrollDirection: Axis.horizontal,
              query: categorysCollection,
              itemBuilder: (context, snapshot) {
                CategoryModel category = snapshot.data();
                return AspectRatio(
                  aspectRatio: 2 / 2.5,
                  child: SizedBox(
                    width: 62,
                    height: 30,
                    child: Column(
                      children: [
                        Image.network(category.image, height: 60),
                        const SizedBox(height: 10),
                        Text(category.catName,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}





























     // Padding(
          //   padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          //   child: SizedBox(
          //     height: 80,
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: FirestoreListView<CategoryModel>(
          //             scrollDirection: Axis.horizontal,
          //             query: categorysCollection,
          //             itemBuilder: (context, snapshot) {
          //               CategoryModel category = snapshot.data();
          //               return Padding(
          //                 padding: const EdgeInsets.only(right: 9.0),
          //                 child: ActionChip(
          //                   padding: EdgeInsets.zero,
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(5)),
          //                   backgroundColor:
          //                       _selectedCategory == category.catName
          //                           ? Colors.purple
          //                           : Colors.grey.shade400,
          //                   label: Column(
          //                     children: [
          //                       CachedNetworkImage(imageUrl: category.image),
          //                       Text(
          //                         category.catName,
          //                         style: TextStyle(
          //                             fontSize: 12,
          //                             color:
          //                                 _selectedCategory == category.catName
          //                                     ? Colors.white
          //                                     : Colors.black),
          //                       ),
          //                     ],
          //                   ),
          //                   onPressed: () {
          //                     setState(() {
          //                       _selectedCategory = category.catName;
          //                     });
          //                   },
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //         Container(
          //           decoration: BoxDecoration(
          //             border: Border(
          //               left: BorderSide(color: Colors.grey.shade100),
          //             ),
          //           ),
          //         ),

          //         // IconButton(
          //         //   onPressed: () {},
          //         //   icon: const Icon(CupertinoIcons.arrow_down),
          //         // ),
          //       ],
          //     ),
          //   ),
          // ),
          // HomeProduct(
          //   category: _selectedCategory,
          // )