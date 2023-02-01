import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

import '../Services/firebase_service.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseService _service = FirebaseService();
  double scrollPosition = 0;

  final List _bannerImage = [];

  @override
  void initState() {
    getBanner();
    super.initState();
  }

  getBanner() {
    return _service.banner.get().then((QuerySnapshot querySnapshot) {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _bannerImage.add(doc['image']);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: PageView.builder(
                itemCount: _bannerImage.length,
                itemBuilder: (BuildContext context, int index) {
                  return CachedNetworkImage(
                    imageUrl: _bannerImage[index],
                    placeholder: (context, url) => GFShimmer(
                      showShimmerEffect: true,
                      mainColor: Colors.grey.shade500,
                      secondaryColor: Colors.grey.shade300,
                      child: Container(
                        color: Colors.grey.shade200,
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  );
                },
                onPageChanged: (val) {
                  setState(() {
                    scrollPosition = val.toDouble();
                  });
                },
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 11.0,
          child: DotIndicatorWidget(
            scrollPosition: scrollPosition,
            dotscount: 3,
          ),
        )
      ],
    );
  }
}

class DotIndicatorWidget extends StatelessWidget {
  const DotIndicatorWidget({
    Key? key,
    required this.scrollPosition,
    required this.dotscount,
  }) : super(key: key);

  final double scrollPosition;
  final int dotscount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DotsIndicator(
            position: scrollPosition,
            dotsCount: dotscount,
            decorator: DotsDecorator(
              spacing: const EdgeInsets.all(2),
              size: const Size.square(6),
              activeSize: const Size(12, 6),
              activeColor: Colors.deepPurple,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
