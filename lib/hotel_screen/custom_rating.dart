import 'package:c_s_p_app/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'app_text.dart';

class CustomRating extends StatelessWidget {
  const CustomRating({
    Key? key,
    required this.ratingScore,
    this.totalReviewer = 0,
    this.showReviews = false,
  }) : super(key: key);

  final double ratingScore;
  final int totalReviewer;
  final bool showReviews;

  @override
  Widget build(BuildContext context) {
    const size = 15.0;
    return Row(
      children: [
        for (int i = 1; i <= 5; i++)
          Container(
            margin: const EdgeInsets.all(1),
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: i <= ratingScore ? FlutterFlowTheme.of(context).primaryColor : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: FlutterFlowTheme.of(context).primaryColor, width: 2),
            ),
          ),
        const SizedBox(width: 12),
        AppText.medium(
          '${ratingScore > 5 ? 5.0 : ratingScore}',
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
