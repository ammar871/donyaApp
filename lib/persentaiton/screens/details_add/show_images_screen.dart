import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';

import '../../../app-with-api/helpers/constants.dart';
class ShowingImagesScreen extends StatefulWidget {
  final List<dynamic> images;


  ShowingImagesScreen({required this.images});

  @override
  State<ShowingImagesScreen> createState() => _ShowingImagesScreenState();
}

class _ShowingImagesScreenState extends State<ShowingImagesScreen> {
  int index=0;

  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CarouselSlider.builder(
            itemCount: widget.images.length,
carouselController: buttonCarouselController,
            options: CarouselOptions(

              autoPlay: false,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 2,
              height: double.infinity
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex)

                    {
                      index=itemIndex;
                      return Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.blue,
                        child: PhotoView(

                            imageProvider:NetworkImage(baseUrlImages+widget.images[itemIndex].toString())
                        ),
                      );
                    }
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                padding: EdgeInsets.all(2),
                onPressed: () {
                  print("jhhxhxhx");
                  buttonCarouselController.nextPage(
                      duration: Duration(milliseconds: 300), curve: Curves.linear);

                },
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                padding: EdgeInsets.all(2),
                onPressed: () {
                  buttonCarouselController.previousPage(
                      duration: Duration(milliseconds: 300), curve: Curves.linear);
                },
                icon: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
