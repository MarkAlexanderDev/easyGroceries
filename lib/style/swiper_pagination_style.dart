import 'package:foodz/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

SwiperPagination getCustomSwiperPagination() {
  return SwiperPagination(builder: SwiperCustomPagination(
      builder: (BuildContext context, SwiperPluginConfig config) {
    return ConstrainedBox(
      child: Align(
        alignment: Alignment.center,
        child: DotSwiperPaginationBuilder(
                color: grey,
                activeColor: accentColor,
                size: 10.0,
                activeSize: 10.0)
            .build(context, config),
      ),
      constraints: BoxConstraints.expand(height: 20.0),
    );
  }));
}
