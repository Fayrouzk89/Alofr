import 'package:billing/modules/product_details/product_details_screen.dart';
import 'package:billing/shared/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/responses/banners_response.dart';
import '../../../shared/utils/size_config.dart';
import '../../../globals.dart' as globals;
import '../../Allproducts/products_screen.dart';
import '../../category/categorys_screen.dart';
/*
final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

 */
class CarouselWithIndicatorDemo extends StatefulWidget {
  final List<DataBanners>? imgList;

  const CarouselWithIndicatorDemo({Key? key, this.imgList}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();


  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList!
        .map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(1.0),
        child: GestureDetector(
          onTap: () {
               if(item.type==globals.type_category) {
                 Get.to(CategoryScreen(mainCategoryName: item.target!.name,
                   mainCategoryId: item.target!.id,category: item.target!,));
               }
               if(item.type==globals.type_sub_category) {

                 Get.to(ProductsScreen(categoryId: item.target!.id,
                   categoryName: item.target!.name ,
                 ));
               }
               else if(item.type==globals.type_product)
                 {
                   Get.to(DetailsScreen(product: item.target,));
                 }
               else if(item.type==globals.type_external_url)
               {
                 launch(item.target);
               }
          },
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Container(
                     width: SizeConfig().screenWidth-50,
                      child:
                      //Image.network(item.image??"", fit: BoxFit.cover)
                      CachedNetworkImage(
                        imageUrl:item.image??"",
                          fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(child: Text('⏱',style: TextStyle(fontSize: 30),))
                        ,
                        errorWidget: (context, url, error) => Image.asset(
                          'images/logo.jpg',
                            fit: BoxFit.cover
                        ),
                      )
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        item.title!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    ))
        .toList();
    return Container(
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width-20,
          height: ColorConstants.sliderHeight,
          padding: EdgeInsets.zero,
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: (imageSliders.length==1)?false:true,
                enlargeCenterPage: true,

                aspectRatio: 2.0,

                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageSliders.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}