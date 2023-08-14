import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../Models/hotel_model.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'model/hotel_list_data.dart';

class HotelListView extends StatelessWidget {
  const HotelListView(
      {Key? key,
      this.hotelData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Hotel? hotelData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 2,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover, imageUrl: hotelData!.picture,
                          ),
                        ),
                        Container(
                          color:FlutterFlowTheme.of(context).primaryBackground,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          hotelData!.name,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                        // Row(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.center,
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.start,
                                        //   children: <Widget>[
                                        //     Text(
                                        //       'London',
                                        //       style: TextStyle(
                                        //           fontSize: 14,
                                        //           color: Colors.grey
                                        //               .withOpacity(0.8)),
                                        //     ),
                                        //     const SizedBox(
                                        //       width: 4,
                                        //     ),
                                        //     Icon(
                                        //       FontAwesomeIcons.locationDot,
                                        //       size: 12,
                                        //       color: FlutterFlowTheme.of(context).primaryBackground,
                                        //     ),
                                        //     Expanded(
                                        //       child: Text(
                                        //         '2.0 km to city',
                                        //         overflow:
                                        //             TextOverflow.ellipsis,
                                        //         style: TextStyle(
                                        //             fontSize: 14,
                                        //             color: Colors.grey
                                        //                 .withOpacity(0.8)),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: <Widget>[
                                              RatingBar(
                                                initialRating:
                                                    3,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 24,
                                                ratingWidget: RatingWidget(
                                                  full: Icon(
                                                    Icons.star_rate_rounded,
                                                    color: FlutterFlowTheme.of(context).primaryColor,
                                                  ),
                                                  half: Icon(
                                                    Icons.star_half_rounded,
                                                    color: FlutterFlowTheme.of(context).primaryColor,
                                                  ),
                                                  empty: Icon(
                                                    Icons
                                                        .star_border_rounded,
                                                    color: FlutterFlowTheme.of(context).primaryColor,
                                                  ),
                                                ),
                                                itemPadding:
                                                    EdgeInsets.zero,
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              Text(
                                                ' 28 Reviews',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                        .withOpacity(0.8)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16, top: 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      '\$300',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Text(
                                      '/per night',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Colors.grey.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
