import 'package:al_hadith/core/utils/app_colors/app_colors.dart';
import 'package:al_hadith/models/hadith_item_model.dart';
import 'package:al_hadith/modules/hadith/controller/hadith_controller.dart';
import 'package:al_hadith/widgets/negative_curve_clipper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexagon/hexagon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HadithPage extends StatelessWidget {
  final HadithController hadithController = Get.put(HadithController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130.h,
        flexibleSpace: ClipPath(
          clipper:DownwardCurveClipper() ,
          child: Container(
            height:250.h,
            width: MediaQuery.of(context).size.width,color: AppColors.kGreenColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: AppColors.kWhite),
            onPressed: () {}),
        title: GetBuilder<HadithController>(
          builder: (controller) {
            var firstBookItem = controller.itemList.firstWhere(
              (item) => item.type == HadithItems.books,
            );

            if (firstBookItem != null) {
              print(
                  'First Book Title: ${firstBookItem.data['title'] ?? 'No title'}');
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: firstBookItem != null
                      ? [
                          Text(
                            ' ${firstBookItem.data['title'] ?? ''}',
                            style: TextStyle(
                                fontFamily: 'Kalpurush',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kWhite),
                          ),
                          Text(
                            ' ওহীর সূচনা অধ্যায়',
                            style: TextStyle(
                                fontFamily: 'Kalpurush',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kWhite),
                          )
                        ]
                      : [],
                ),
                IconButton(
                    icon: Icon(Icons.tune_outlined, color: AppColors.kWhite),
                    onPressed: () {}),
              ],
            );
          },
        ),
      ),
      body: GetBuilder<HadithController>(
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.itemList.isEmpty) {
            return Center(child: Text('No items found'));
          }

          return ListView.builder(
            itemCount: controller.itemList.length,
            itemBuilder: (context, index) {
              var item = controller.itemList[index];
              print(item.data);

              switch (item.type) {
                case HadithItems.section:
                  var relatedBooks = controller.itemList
                      .where((element) => element.type == HadithItems.books)
                      .toList();
                      
                  var relatedHadiths = controller.itemList
                      .where((element) => element.type == HadithItems.hadith)
                      .toList();

                  var abbreviationCode = relatedBooks.isNotEmpty ?relatedBooks[0].data['abvr_code'] ?? ''
                      : '';
                  var firstHadithGrade = relatedHadiths.isNotEmpty
                      ? relatedHadiths[0].data['grade'] ?? ''
                      : '';
                  var firstHadithAr = relatedHadiths.isNotEmpty
                      ? relatedHadiths[0].data['ar'] ?? ''
                      : '';
                  var firstHadithBn = relatedHadiths.isNotEmpty
                      ? relatedHadiths[0].data['bn'] ?? ''
                      : '';
                  var hadithNarrator = relatedHadiths.isNotEmpty
                      ? relatedHadiths[0].data['narrator'] ?? ''
                      : '';

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r)),
                      color: const Color.fromARGB(255, 236, 232, 232),
                    ),
                    padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.white,
                          ),
                          padding: REdgeInsets.only(
                              left: 10, right: 10, top: 20, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${item.data['number'] ?? ''} ',
                                      style: TextStyle(
                                          color: AppColors.kGreenColor,
                                          fontFamily: 'Kalpurush',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: '${item.data['title'] ?? ''}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Kalpurush',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: const Color.fromARGB(255, 236, 232, 232),
                              ),
                              Container(
                                color: Colors.white,
                                padding: REdgeInsetsDirectional.all(10),
                                child: Text(
                                  '${item.data['preface'] ?? ''}',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Kalpurush',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                       15.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.white,
                          ),
                          padding: REdgeInsets.only(left: 10, top: 20, bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  HexagonWidget.pointy(
                                    cornerRadius: 10.r,
                                    width: 40.w,
                                    color: Color(0xFF24DF0C),
                                    elevation: 0,
                                    child: Center(
                                        child: Text(
                                      '$abbreviationCode',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                 10.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: relatedBooks.map((bookItem) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                ' ${bookItem.data['title'] ?? ''}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Kalpurush',
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                ' হাদিস: ${bookItem.data['id'].toString() == '1' ?  '১' : ''}',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.kGreenColor,
                                                    fontFamily: 'Kalpurush',
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Container(
                                      padding: REdgeInsets.only(
                                          right: 15,
                                          left: 10,
                                          top: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: AppColors.kGreenColor),
                                      child: Text(' ${firstHadithGrade}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Kalpurush',
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold))),
                                  PopupMenuButton<String>(
                                    onSelected: (String value) {
                                    
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return {
                                        'Option 1',
                                        'Option 2',
                                        'Option 3'
                                      }.map((String choice) {
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          child: Text(choice),
                                        );
                                      }).toList();
                                    },
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                             15.verticalSpace,
                              Padding(
                                padding: REdgeInsets.only(right: 20, left: 10),
                                child: Text(' ${firstHadithAr}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'KGFQ',
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                            20.verticalSpace,
                              Padding(
                                padding: REdgeInsets.only(right: 20, left: 10),
                                child: Text('${hadithNarrator} থেকে বর্ণিত:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppColors.kGreenColor,
                                        fontFamily: 'Kalpurush',
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                          20.verticalSpace,
                               Padding(
                                padding: REdgeInsets.only(right: 20, left: 10),
                                child: Text('${firstHadithBn}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black
                        ,
                                        fontFamily: 'Kalpurush',
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                default:
                  return SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
