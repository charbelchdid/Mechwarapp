import 'dart:async';

import 'package:c_s_p_app/flutter_flow/flutter_flow_icon_button.dart';
import 'package:c_s_p_app/flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:url_launcher/url_launcher.dart';
import '../Models/hotel_model.dart';
import '../Models/images_model.dart';
import '../Services/GetImages.dart';
import '../components/map_direction_widget.dart';
import '../hotels_detail_screen/hotels_detail_screen_widget.dart';
import '../review_screen/review_screen_widget.dart';
import 'app_text.dart';
import 'custom_button.dart';
import 'custom_icon_container.dart';
import 'custom_rating.dart';
import 'gen/assets.gen.dart';
import 'gen/colors.gen.dart';


void _launchURL(String s) async {
  Uri url = Uri.parse(s); // Replace with your desired URL
  try {
    await launchUrl(url);
  } catch (e) {
    throw 'Could not launch $url';
  }
}
class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotel hotel;

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  List<Images> images = [];
  List<String> im = [];

  @override
  void initState() {
    super.initState();
    getImage();
  }

  getImage() async {
    images = (await getImages('hotel', widget.hotel.rowGuid))!;
    for (int i = 0; i < images.length; i++) {
      im.add(images[i].image);
    }
    setState(() {}); // Update the UI once the images are fetched
  }
  void _launchCall(String phoneNumber) async {
    final phoneUrl = 'tel:$phoneNumber';

    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch $phoneUrl';
    }
  }
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Details'),
    Tab(text: 'Reviews'),
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<String> elements = widget.hotel.services!=null?widget.hotel.services.split(",").map((element) => element.trim()).toList():[];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          body: Container(
            //margin: EdgeInsets.only(top: size.height * 0.4),
            decoration: BoxDecoration(
              color:FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
              Expanded(
                flex: 1,
                  child: TabBar(
                    tabs: myTabs,
                    labelStyle: FlutterFlowTheme.of(context).bodyText1,
                    labelColor: FlutterFlowTheme.of(context).primaryText,
                    indicatorColor: FlutterFlowTheme.of(context).primaryColor,
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: TabBarView(
                        children: [
                      ListView(
                        physics:BouncingScrollPhysics(),
                        children: [
                         Row(mainAxisAlignment: MainAxisAlignment.center, children: [_HotelTitleSection(hotel: widget.hotel)],),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FacilitiesSection(fac: elements,),
                              AppText.medium('Contact', fontWeight: FontWeight.bold),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      _launchCall(widget.hotel.openingTime); // Replace with the desired phone number
                                    },
                                    child: Text('Call Now'),
                                    style: ElevatedButton.styleFrom(backgroundColor: FlutterFlowTheme.of(context).primaryColor)
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      _launchURL(widget.hotel.website);
                                    },
                                    child: Text('Website/Instagram'),
                                    style: ElevatedButton.styleFrom(backgroundColor: FlutterFlowTheme.of(context).primaryColor)
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.medium('Photos', fontWeight: FontWeight.bold),
                              const SizedBox(height: 10),
                              buildImageSlider(context),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.medium('Location', fontWeight: FontWeight.bold),
                              const SizedBox(height: 30),
                              ClipRRect(
                                borderRadius:  BorderRadius.all(Radius.circular(30)),
                                child: Container(
                                    height: 200,
                                    //width: displayWidth,
                                    child: RouteMapWidget(destinationLatitude: widget.hotel.latitude, destinationLongitude: widget.hotel.longitude, name: widget.hotel.name, type: 'hotel',)
                                ),
                              ),
                            ],
                          ),
                          // _LocationSection(
                          //   address: hotel.openingTime,
                          //   coordinate: LatLng(hotel.latitude,hotel.longitude),
                          //   description: hotel.description,
                          // ),
                        ),
                      ],),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ReviewWidget(rowg: widget.hotel.rowGuid, type: 'hotel',),
                          )
                    ]),
                ),
              ],
            ),
          ), headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {return <Widget>[SliverList(
          delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Stack(children: [
                  Container(
                    height: size.height * 0.4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            widget.hotel.picture,
                          ),fit:  BoxFit.fitHeight,)
                    ),
                  ),
                  Align(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      height: 50,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                            icon: Assets.icon.chevronDown.svg(height: 25),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                    alignment:Alignment.topLeft,
                  )
                ],);
              }, childCount: 1),
        ),
        ];  },
        ),
        //bottomNavigationBar: _ReserveBar(price: hotel.minprice),
      ),
    );
  }
  Widget buildImageSlider(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: im.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ImageScreen(
                    images: im,
                    initialIndex: index,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(im[index]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HotelTitleSection extends StatelessWidget {
  const _HotelTitleSection({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.large(
          hotel.name,
          textAlign: TextAlign.left,
          maxLine: 2,
          textOverflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5),
        // Row(
        //   children: [
        //     Icon(Icons.,color: FlutterFlowTheme.of(context).primaryColor,),
        //     const SizedBox(width: 10),
        //     AppText.small(hotel.openingTime),
        //   ],
        // ),
        const SizedBox(height: 10),
        CustomRating(
          ratingScore:double.parse(hotel.rating) ,
          showReviews: true,
          //totalReviewer: hotel.totalReview,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _FacilitiesSection extends StatelessWidget {
 _FacilitiesSection({Key? key,required this.fac}) : super(key: key);
  List <String> fac;
 @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium('Facilities', fontWeight: FontWeight.bold),
        const SizedBox(height: 10),
        Table(
          //border: TableBorder.all(),
          columnWidths: {
            0: FlexColumnWidth(1.0),
            1: FlexColumnWidth(1.0),
          },
          children: List.generate(
            (fac.length / 2).ceil(),
                (index) {
              final rowIndex = index * 2;
              return TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        height:20,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Icon(Icons.circle_rounded,color: FlutterFlowTheme.of(context).primaryColor,size: 15,),
                            SizedBox(width: 20,),
                            Text(fac[rowIndex]),
                          ],
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: rowIndex + 1 < fac.length
                          ? Container(
                        height:20,
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                              children: [
                                Icon(Icons.circle_rounded,color: FlutterFlowTheme.of(context).primaryColor,size: 15,),
                                SizedBox(width: 20,),
                                Text(fac[rowIndex + 1]),
                              ],
                            ),
                          )
                          : SizedBox(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Padding _buildIconWithLabel(
    SvgPicture icon,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 10),
          AppText.medium(label, fontWeight: FontWeight.normal),
        ],
      ),
    );
  }
}

class _GallerySection extends StatelessWidget {
  const _GallerySection({
    Key? key,
    required this.imagePaths,
  }) : super(key: key);

  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AppText.medium('Gallery', fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 150,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10),
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              final imagePath = imagePaths[index];
              return AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LocationSection extends StatelessWidget {
  const _LocationSection({
    Key? key,
    required this.address,
    required this.coordinate,
    required this.description,
  }) : super(key: key);

  final String address;
  final LatLng coordinate;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium('Location', fontWeight: FontWeight.bold),
        const SizedBox(height: 10),
        AppText.medium(address, fontWeight: FontWeight.normal),
        const SizedBox(height: 10),
        FutureBuilder<BitmapDescriptor?>(
          future: _convertToMarkerBitmap(),
          builder: (context, snapshot) {
            final bitmapData = snapshot.data;
              return SizedBox(
                height: 200,
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  initialCameraPosition:
                      CameraPosition(target: coordinate, zoom: 15),
                  markers: {
                    Marker(
                      markerId: MarkerId(address),
                      position: coordinate,
                      icon: bitmapData!,
                    ),
                  },
                ),
              );
            },
        ),
        const SizedBox(height: 10),
        AppText.medium(description, fontWeight: FontWeight.normal),
        const SizedBox(height: 10),
        AppText.medium('Show more', textDecoration: TextDecoration.underline)
      ],
    );
  }

  Future<BitmapDescriptor?> _convertToMarkerBitmap() async {
    final data = await rootBundle.load(Assets.icon.pinPng.path);
    final uint8List = data.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(uint8List);
  }
}

class _ReserveBar extends StatelessWidget {
  const _ReserveBar({
    Key? key,
    required this.price,
  }) : super(key: key);

  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(20.0).copyWith(top: 10.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium('Start from', fontWeight: FontWeight.normal),
              RichText(
                text: TextSpan(
                  children: [
                    AppTextSpan.large('\$$price'),
                    AppTextSpan.medium(' /night'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 150,
            child: CustomButton(
              buttonText: 'Reserve',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
