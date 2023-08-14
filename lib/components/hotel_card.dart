import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


import '../hotel_screen/app_text.dart';
import '../hotel_screen/custom_rating.dart';
import '../hotel_screen/hotel_screen.dart';
import '../Models/hotel_model.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelDetailScreen(hotel: hotel),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover, imageUrl:hotel.picture,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.large(
                        hotel.name,
                        fontSize: 18,
                        textAlign: TextAlign.left,
                        maxLine: 2,
                        textOverflow: TextOverflow.ellipsis,
                      ),

                      // Row(
                      //   children: [
                      //     Assets.icon.location.svg(
                      //       color: ColorName.darkGrey,
                      //       height: 15,
                      //     ),
                      //     const SizedBox(width: 8),
                      //     AppText.small(hotel.location),
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: CustomRating(ratingScore: double.parse(hotel.rating) ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            AppTextSpan.large('\$${hotel.minprice} - ${hotel.maxprice}'),
                            AppTextSpan.medium(' /night'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
