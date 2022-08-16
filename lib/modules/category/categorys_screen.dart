import 'package:billing/modules/category/categorys_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/responses/banners_response.dart';
import '../../models/responses/categories_response.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/AppBars/build_header.dart';
import '../../shared/widgets/AppBars/silver_custom.dart';
import '../../shared/widgets/no_date.dart';
import '../Allproducts/products_screen.dart';
import '../home/Cards/PackageCard.dart';
import '../home/Cards/product_card.dart';
import '../home/tabs/slider_adver.dart';
import '../product_details/product_details_screen.dart';
import '../solid_app_bar.dart';
import '../../globals.dart' as globals;
class CategoryScreen extends StatefulWidget {
  final int mainCategoryId;
  final String mainCategoryName;
  final Category? category;
  const CategoryScreen({Key? key,required this.mainCategoryId,required this.mainCategoryName,required this.category}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategorysController? homePageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePageController = Get.put(CategorysController(apiRepository: Get.find(), mainCategoryId: widget.mainCategoryId,));
    homePageController!.getCategories(widget.mainCategoryId);
  }
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: ColorConstants.greyBack,
      body: Container(
        child: CustomScrollView(
          slivers: [
            SilverAppBarCustom(  title: widget.mainCategoryName)
            ,
            SliverFillRemaining(
                hasScrollBody: true,
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildSlider(),
                      ),
                      Obx(
                              () =>Expanded(child: home(orientation))
                      ),
                      SizedBox(height: 5,)
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
    return Scaffold(
        backgroundColor: ColorConstants.greyBack,
        appBar: SolidAppBar(title: widget.mainCategoryName,),
        body:Obx(
                () =>home(orientation)
        )


    );
  }

 Widget buildSlider()
  {
    List<DataBanners>? imgList=[];
    if(widget.category!.banners!=null && widget.category!.banners!.length>0)
    {
      imgList=widget.category!.banners!;
    }
    return
    (imgList.length==1)?
    Container(
      width: SizeConfig().screenWidth,
      height: ColorConstants.sliderHeight+30,
      child: GestureDetector(
        onTap: () {
          DataBanners item=imgList![0];
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
                    width: SizeConfig().screenWidth-10,
                    child:
                    //Image.network(item.image??"", fit: BoxFit.cover)
                    CachedNetworkImage(
                      imageUrl:imgList[0].image??"",
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(child: Text('⏱',style: TextStyle(fontSize: 30),))
                      ,
                      errorWidget: (context, url, error) => Image.asset(
                          'images/logo.png',
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
                      imgList[0].title??"",
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
    ):
    (imgList.length>0)?
    Container(
      width: SizeConfig().screenWidth,
      height: ColorConstants.sliderHeight+30,
      child: CarouselWithIndicatorDemo(imgList:imgList),
    ):
    Text("");
   return (widget.category!.banners!=null && widget.category!.banners!.length>0)?
        Text("Banners")
        :
    Text("");
  }
  Widget home(orientation )
  {
    return
      (homePageController!.categories!=null
          && homePageController!.categories.value!=null
          &&   homePageController!.categories.value!.data!=null

      )?
      (homePageController!.categories.value!.data.isEmpty)?
      NoData(  text: LocalString.getStringValue(context, 'no_categories') ??
          "لا يوجد تصنيفات فرعية", imagePath: 'images/review.png', ):
      ListViewCategories():
    Text('')
    ;
  }
 Widget ListViewCategories ()
  {
    return Padding(
      padding: const EdgeInsets.only(top: 2,bottom: 10),
      child: Container(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.all(1),
            scrollDirection: Axis.vertical,
            itemCount: homePageController!.categories.value!.data.length,
            itemBuilder: (context, index) {
          return  Padding(
            padding: const EdgeInsets.only(left: 4,right: 4,top: 1,bottom: 8),
            child: Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(

                  trailing:
                  (homePageController!.categories.value!.data[index].image!=null
                      && homePageController!.categories.value!.data[index].image!=''
                  )?
                  Container(
                   // color: Colors.red,
                    width: 60,
                    height: 100,
                    child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 30,
                        child:  CircleAvatar(
                          radius:30,
                          backgroundImage:  NetworkImage(homePageController!.categories.value!.data[index].image??'images/logo.jpg'),
                          backgroundColor: Colors.transparent,
                        )
                    ),
                  ):
                  Container(
                    width: 60,
                    height: 100,
                    child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius:60,
                        child:  CircleAvatar(
                          radius:60,
                          backgroundImage:
                          AssetImage('images/logo.jpg'),
                          backgroundColor: Colors.transparent,
                        )
                    ),
                  ),


                  title: Container(child: Text(homePageController!.categories.value!.data[index].name)),
                  onTap: () => _openDetail(context, index),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
  _openDetail(context, index) {
    /*
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>ProductsScreen(categoryId: homePageController!.categories.value!.data[index].id,
        categoryName: homePageController!.categories.value!.data[index].name ,
      )),
    );

     */

    Get.to(ProductsScreen(categoryId: homePageController!.categories.value!.data[index].id,
    categoryName: homePageController!.categories.value!.data[index].name ,
    ));



  }
}
