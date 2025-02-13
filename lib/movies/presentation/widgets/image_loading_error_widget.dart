import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ImageLoadingErrorWidget extends StatelessWidget {
  const ImageLoadingErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.blackPrimary2,
        child: Icon(
          Icons.error_outline_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
