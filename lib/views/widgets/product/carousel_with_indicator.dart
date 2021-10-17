import 'package:alga/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../youtube_video.dart';

class CarouselWithIndicator extends StatelessWidget {
  final List<String> images;
  final String? video;
  final int current;

  const CarouselWithIndicator({
    Key? key,
    required this.images,
    this.video,
    this.current = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    return images.isNotEmpty || video != null
        ? InkWell(
            onTap: () {},
            child: Stack(children: [
              GetBuilder<_CarouselController>(
                  init: _CarouselController(current: current),
                  global: false,
                  builder: (controller) {
                    return CarouselSlider.builder(
                        itemCount: images.length + (video != null ? 1 : 0),
                        viewportFraction: 1.0,
                        onPageChanged: (index) {
                          controller.current = index;
                        },
                        itemBuilder: (BuildContext context, int itemIndex) {
                          if (video?.isNotEmpty ?? false) {
                            if (itemIndex == 0)
                              return YoutubeVideo(videoUrl: video!);

                            itemIndex--;
                          }

                          return Container(
                            width: width,
                            color: Colors.grey.withAlpha(50),
                            child: images[itemIndex] != null
                                ? Image.network(
                                    '${images[itemIndex]}',
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.image,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                          );
                        });
                  }),
              GetBuilder<_CarouselController>(builder: (controller) {
                return Positioned(
                  bottom: 4,
                  right: 0,
                  left: 0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0;
                            i < images.length + (video != null ? 1 : 0);
                            i++)
                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.current == i
                                  ? Colors.cyan
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          )
                      ]),
                );
              }),
              Positioned(
                bottom: 10,
                left: 10,
                child: Icon(
                  Icons.aspect_ratio,
                  color: Colors.white30,
                ),
              )
            ]),
          )
        : Container(height: 55);
  }
}

class _CarouselController extends GetxController {
  int _current = 0;
  int get current => _current;
  set current(int i) {
    _current = i;
    update();
  }

  _CarouselController({current = 0}) {
    _current = current;
  }
}
