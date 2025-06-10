import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/presentation/cubit/image_document_cubit.dart';
import 'package:gis_helper/presentation/screen/show_news_screen/news_details_screen.dart';

import '../../../constants/style_constants.dart';
import '../../cubit/get_image_documents_cubit.dart';

class HomeScreenAdsWidget {
  Container addsCard(MediaQueryData mediaQuery, BuildContext context,
      StyleConstants styleConstants) {
    return Container(
        height: 192,
        width: mediaQuery.size.width,
        child: BlocBuilder<GetImageDocumentsCubit, GetImageDocumentsState>(
          builder: (context, state) {
            if (state is GetImageDocumentsLoading) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            else if (state is GetImageDocumentsSuccess)
              {
              return CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  // تشغيل تلقائي
                  enlargeCenterPage: true,
                  // تكبير الصورة في المنتصف
                  autoPlayInterval: Duration(seconds: 7),
                  // المدة بين الصور
                  autoPlayAnimationDuration: Duration(milliseconds: 400),
                  // مدة الحركة
                  viewportFraction: 0.8, // نسبة عرض كل صورة
                ),
                items: state.images.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return _createCachedNetwork(url.imageUrl, context,url.title, url.descriptions);
                    },
                  );
                }).toList(),
              );
          }
            else if (state is GetImageDocumentsError) {
              return Scaffold(
                body: Center(child: Text("حدث خطأ أثناء تحميل الصور")),
              );
            }
            else {
              return Scaffold(
                body: Center(child: Text("لا يوجد صور")),
              );
            }
           /* return Card(
              child: Container(
                  padding: EdgeInsets.all(styleConstants.largeDp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(
                            StyleConstants().mediumRadius.toDouble())),
                    image: DecorationImage(
                      image: AssetImage("images/img.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.darken),
                    ),
                  ),
                  child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "تركيب محولة جديدة",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text("فك اختناق حي الامانة",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                          textAlign: TextAlign.end),
                    )
                  ])),
            );*/
          },
        ));
  }
  Stack _createCachedNetwork(String imageUrl, BuildContext context, String title, String descriptions) {
    final styleConstants = StyleConstants();
    return Stack(
        children: [
      InkWell(
        onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(descriptions: descriptions, imageUrl: imageUrl,title: title)));
    },
        child: CachedNetworkImage(
          height: double.infinity,
          width: double.infinity,
          imageUrl: imageUrl,
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Image.asset("images/noimage.png", height: 180, width: double.infinity,),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.50), BlendMode.darken),
              ),
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
          ),
        ),
      ),
      Positioned(
        right: 20,
        bottom: 20,
        child: Container(
          alignment: Alignment.bottomRight,
          child: Text(
            title,
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ]);
      /*CachedNetworkImage(
      height: 180,
      width: double.infinity,
      imageUrl: imageUrl,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Image.asset("images/noimage.png", height: 180, width: double.infinity,),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
      ),
    );*/
  }

}
/*
* image: DecorationImage(
              image: AssetImage("images/img.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.darken),
            ),*/