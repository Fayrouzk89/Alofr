import 'package:billing/models/Product.dart';
import 'package:billing/modules/buy/buy_controller.dart';
import 'package:billing/modules/home/tabs/slider_adver.dart';
import 'package:billing/modules/product_details/product_details_controller.dart';
import 'package:billing/shared/services/MessageHelper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/responses/banners_response.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/AppBars/auth_app_bar.dart';
import '../../shared/widgets/custom_rounded.dart';
import '../../shared/widgets/AppBars/main_app_bar.dart';
import '../../globals.dart' as globals;
import '../../shared/widgets/input_field_phone.dart';
import '../../shared/widgets/input_password.dart';
import '../Allproducts/products_screen.dart';
import '../home/Cards/PackageCard.dart';
import '../home/Cards/product_card.dart';
import '../home/Shimmer/ProductShimmer.dart';
import '../mapcustom/CustomPlacesPickers.dart';
import '../solid_app_bar.dart';
class DetailsScreen extends StatefulWidget {
  final Product? product;
  DetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  _DetailsScreenState createState() {
    return _DetailsScreenState();
  }
}

class _DetailsScreenState extends State<DetailsScreen> with RouteAware{
  DetailsController? controller;
  final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
  Product? product;
  @override
  void initState() {
    super.initState();
    product = widget.product;
    controller = Get.put(DetailsController(apiRepository: Get.find(),product: product));
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
   // controller!.getCategories(widget.mainCategoryId);
  }
  @override
  void didPush() {
    print('SecondPage: Called didPush');
    /*
    if(!controller!.isLoading)
    {
      controller!. callMethods();
    }
    setState(() {

    });

     */
    super.didPush();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async =>true,
      child: Scaffold(
          backgroundColor: ColorConstants.whiteBack,
          appBar: SolidAppBar(title: LocalString.getStringValue(context, 'packages') ??
              "الباقات",),
          body:
          PackageHomePage(controller: controller!,product:product ,)

      ),
    );
  }
}

class PackageHomePage extends StatefulWidget {
 final DetailsController controller;
 final Product? product;
 PackageHomePage({Key? key, this.product,required this.controller}) : super(key: key);

  @override
  State<PackageHomePage> createState() => _PackageHomePageState();
}

class _PackageHomePageState extends State<PackageHomePage> {
  @override
  initState() {
    super.initState();

    // Add listeners to this class
  }
  @override
  Widget build(BuildContext context) {
    return _buildForms(context);
  }

  Widget _buildForms(BuildContext context) {
    return Form(
      key: widget.controller.FormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context,widget.product!),
              _buildSlider(widget.product!),
              SizedBox(height: 10,),
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    LocalString.getStringValue(context, 'product_details') ??
                        "تفاصيل الإعلان",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: CommonConstants.smallText,
                        color: ColorConstants.textColor,
                        fontWeight: FontWeight.w100,
                        fontFamily: CommonConstants.largeTextFont),
                  )),
              SizedBox(height: 5,),
              Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                  Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Text(
                                widget.product!.desctiption,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: CommonConstants.smallText,
                                    color: ColorConstants.textColor,
                                    fontWeight: FontWeight.w100,
                                    fontFamily: CommonConstants.largeTextFont),
                              ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 10,),
              Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                  Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorConstants.greenColor,
                                radius: 20,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.call, color: Colors.white,size: 20,),
                                  color: Colors.white,
                                  onPressed: () {
                                    launch("tel://" +
                                        widget.product!.mobile);
                                  },
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 50,
                                width: 1,
                                color: Colors.black12,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    openGoogleMap(widget.product);
                                  },
                                 child: Container(child: Text(
                                     ( widget.product!.latitude=="null"||  widget.product!.latitude=="")?
                                     (LocalString.getStringValue(context, 'no_location_found') ??
                                         "الإنتقال إلى خريطة جوجل"):
                                     LocalString.getStringValue(context, 'open_google_map') ??
                                       "الإنتقال إلى خريطة جوجل",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                       fontSize: CommonConstants.smallText,
                                       color: ColorConstants.textColor,
                                       fontWeight: FontWeight.w100,
                                       fontFamily: CommonConstants.largeTextFont),
                                 ),),
                             ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 10,),

              Obx(
                    () =>buildUserWidgetBody(context,widget.product),
              ),
              // buildGridProducts(),

              Obx(
                    () =>buildSimilarWidgetBody(context,widget.product),
              ),


            ],
          ),
        ),
      ),
    );
  }
  openGoogleMap(Product? product)async
  {
    /*
    LatLng? displayLocation = LatLng(double.parse(product!.latitude),double.parse(product.longitude));
    LocationResult result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CustomPlacePicker(globals.MapApiKey,true,displayLocation: displayLocation,)));

     */
    if(product!.latitude!="null" && product!.latitude!="" && product!.longitude!="null" && product!.latitude!="") {
      double latitude = double.parse(product!.latitude);

      double longitude = double.parse(product.longitude);
      String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      String encodedURl = Uri.encodeFull(googleUrl);

      if (await canLaunch(encodedURl)) {
        await launch(googleUrl);
      } else {

        //Icons.message.
        MessageHelper.showMessage(context, LocalString.getStringValue(context, 'no_location_found') ??
            "لم يتم تحديد موقع للإعلان");
      }
    }
    else
      {
        MessageHelper.showMessage(context, LocalString.getStringValue(context, 'no_location_found') ??
            "لم يتم تحديد موقع للإعلان");
      }
  }
  Widget buildHeader(BuildContext context,Product product) {
    return Row(children: [
      Padding(
        padding:  EdgeInsets.only(left: CommonConstants.paddingleft, right:  CommonConstants.paddingright),
        child: Text(
          product.title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: CommonConstants.normalText,
              color: ColorConstants.textColor,
              fontWeight: FontWeight.bold,
              fontFamily: CommonConstants.largeTextFont),
        ),
      ),
      Spacer(),
      GestureDetector(
        onTap: () {
          // Get.toNamed( Routes.allProducts);
         // Get.to(ProductsScreen(categoryId: -1,categoryName: '',));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child:   _buildButtonColumnViews(
              ColorConstants.greenColor,
              Icons.visibility,
              LocalString.getStringValue(
                  context, 'views') ??
                  "المشاهدات",
              product),
        ),
      )
    ]);
  }
  Column _buildButtonColumnViews(
      Color color, IconData icon, String label, Product? product) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color,size: 20,),
        Container(
            child: (product!.views != null)
                ? Text(
              product!.views!.toString() + " " + label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            )
                : Text(
              "0 " + label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            )),
      ],
    );
  }
  Widget _buildSlider(Product product) {
    List<DataBanners>? imgList=[];
    if(product.images!=null && product.images.length>0)
      {
        for(int i=0;i<product.images.length;i++)
          {
            DataBanners dataBanners = DataBanners(id: product.images[i].id, image: product.images[i].image,title:(LocalString.getStringValue(
                context, 'price') ??
                "السعر")+": "+ product.price.toString());
            imgList.add(dataBanners);
          }
      }
    return (imgList.length>0)?
    (imgList.length==1)?
    Container(
      width: SizeConfig().screenWidth,
      height: ColorConstants.sliderHeight+30,
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
                    (LocalString.getStringValue(
                          context, 'price') ??
                          "السعر")+ " "+product.price.toString(),
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
    ):
    Container(
      width: SizeConfig().screenWidth,
      height: ColorConstants.sliderHeight+30,
      child: CarouselWithIndicatorDemo(imgList:imgList),
    ):
    Container(
      width: SizeConfig().screenWidth,
      height: ColorConstants.sliderHeight+30,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Container(
                  width: SizeConfig().screenWidth-10,
                  child:
                  //Image.network(item.image??"", fit: BoxFit.cover)
                  Image.asset(
                      'images/logo.jpg',
                      fit: BoxFit.cover
                  ),
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
                    '',
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
    );
  }
  Widget buildBuyBundlesList(BuildContext context)
  {
    return Text('');
  }
  Widget WaitWidget(double size)
  {
    return Column(
      children: [
        SizedBox(height: 10,),
        Container(
            height: CommonConstants.listViewHeight,
            child: SetMenuShimmer()),
      ],
    );
  }
  Widget buildUserWidgetBody(BuildContext context,Product? product) {

    return (widget.controller!.ByUser!=null && widget.controller!.ByUser.value!=null)?
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildUserWidgetHeader(context,product),
        Container(
          height: CommonConstants.listViewHeight,
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.controller!.ByUser.value!.data.length,
                itemBuilder: (BuildContext context, int index) => ProductCard(
                  product: widget.controller!.ByUser.value!.data[index],
                )),
          ),
        ),
      ],
    ):
    (widget.controller!.isNullByUser==true)?
    Text(''):
    WaitWidget( SizeConfig().screenHeight * ColorConstants.sliderHeight);
  }
  Widget buildSimilarWidgetBody(BuildContext context,Product? product) {

    return (widget.controller!.Similar!=null && widget.controller!.Similar.value!=null)?
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSimilarWidgetHeader(context,product),
        Container(
          height: CommonConstants.listViewHeight,
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.controller!.Similar.value!.data.length,
                itemBuilder: (BuildContext context, int index) => ProductCard(
                  product: widget.controller!.Similar.value!.data[index],
                )),
          ),
        ),
      ],
    ):
    (widget.controller!.isNullSimilar==true)?
    Text(''):
    WaitWidget( SizeConfig().screenHeight * ColorConstants.sliderHeight);


  }
  Widget buildSimilarWidgetHeader(BuildContext context,Product? product) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Text(
          LocalString.getStringValue(context, 'similar_ads') ??
              "إعلانات مشابهة",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: CommonConstants.smallText,
              color: ColorConstants.textColor,
              fontWeight: FontWeight.bold,
              fontFamily: CommonConstants.largeTextFont),
        ),
      ),
      Spacer(),
      GestureDetector(
        onTap: () {
          Get.to(ProductsScreen(categoryId: -1,categoryName: '',));
          //  Get.toNamed(Routes.allProducts);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Text(
            LocalString.getStringValue(context, 'view_all') ?? "مشاهدة الكل",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: CommonConstants.smallText,
                color: ColorConstants.textColor,
                fontWeight: FontWeight.bold,
                fontFamily: CommonConstants.largeTextFont),
          ),
        ),
      )
    ]);
  }
  Widget buildUserWidgetHeader(BuildContext context,Product? product) {
    return Row(children: [
      Padding(
        padding:  EdgeInsets.only(left: CommonConstants.paddingleft, right:  CommonConstants.paddingright),
        child: Text(
        (LocalString.getStringValue(context, 'ads_name') ??
              "إعلانات" )
            +"|" + product!.user.firstName +" "+product!.user.lastName

          ,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: CommonConstants.smallText,
              color: ColorConstants.textColor,
              fontWeight: FontWeight.bold,
              fontFamily: CommonConstants.largeTextFont),
        ),
      ),
      Spacer(),
      GestureDetector(
        onTap: () {
          // Get.toNamed( Routes.allProducts);
          Get.to(ProductsScreen(categoryId: -1,categoryName: '',));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Text(
            LocalString.getStringValue(context, 'view_all') ?? "مشاهدة الكل",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: CommonConstants.smallText,
                color: ColorConstants.textColor,
                fontWeight: FontWeight.bold,
                fontFamily: CommonConstants.largeTextFont),
          ),
        ),
      )
    ]);
  }
}
