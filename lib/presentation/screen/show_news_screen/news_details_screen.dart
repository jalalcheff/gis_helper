import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/presentation/cubit/get_image_documents_cubit.dart';
import 'package:intl/intl.dart' as intl;

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key});

  static const String imgeId = "1";

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  void initState() {
    context.read<GetImageDocumentsCubit>().getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        intl.DateFormat.yMMMMd('ar_SA').format(DateTime(2025, 6, 3));
    final String formattedTime =
        intl.DateFormat.Hm('ar_SA').format(DateTime(2025, 6, 3, 10, 45));

    return BlocBuilder<GetImageDocumentsCubit, GetImageDocumentsState>(
      builder: (context, state) {
        if (state is GetImageDocumentsLoading) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is GetImageDocumentsSuccess)
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 40),
                          const Text(
                            "تفاصيل الخبر",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_forward_outlined, size: 28)),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // News Image
                      ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 200.0,
                              autoPlay: true,         // تشغيل تلقائي
                              enlargeCenterPage: true, // تكبير الصورة في المنتصف
                              autoPlayInterval: Duration(seconds: 7), // المدة بين الصور
                              autoPlayAnimationDuration: Duration(milliseconds: 400), // مدة الحركة
                              viewportFraction: 0.8, // نسبة عرض كل صورة
                            ),
                            items: state.images.map((url) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: _createCachedNetwork(url.imageUrl)
                                  );
                                },
                              );
                            }).toList(),
                          )


                        /*CachedNetworkImage(
                            height: 180,
                            width: double.infinity,
                            imageUrl: "${state.images[0].imageUrl}",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Image.asset("images/noimage.png", height: 180, width: double.infinity,),
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )*/
                          ),

                      const SizedBox(height: 12),

                      // Title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "${state.images[0].title}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Date and Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.access_time,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '$formattedDate - $formattedTime صباحاً',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // News content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "${state.images[0].descriptions}",
                            style: TextStyle(fontSize: 15, height: 1.8),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  CachedNetworkImage _createCachedNetwork(String imageUrl) {
    return CachedNetworkImage(
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
          ),
        ),
      ),
    );
  }
}
