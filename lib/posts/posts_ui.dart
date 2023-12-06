import 'dart:convert';
import 'dart:io';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../language/app_strings.dart';
import '../model/create_news_model.dart';
import '../model/get_publish_model.dart';
import '../repository/create_post_repo.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../utils/helper.dart';
import '../widgets/common_colour.dart';
import '../widgets/dimension_screen.dart';


class PublishPostScreen extends StatefulWidget {
  const PublishPostScreen({super.key});

  static String route = "/PublishPostScreen";

  @override
  State<PublishPostScreen> createState() => _PublishPostScreenState();
}

class _PublishPostScreenState extends State<PublishPostScreen> {

  Rx<GetPublishPostModel> getPublishModel = GetPublishPostModel().obs;


  Future getPublishPostData() async {
    repositories.getApi(url: ApiUrls.getPublishUrl).then((value) {
      getPublishModel.value = GetPublishPostModel.fromJson(jsonDecode(value));
    });
  }

  final Repositories repositories = Repositories();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // aboutUsData();
    getPublishPostData();
  }

  TextEditingController postController = TextEditingController();
  Rx<File> image1 = File("").obs;
  String filePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.publishPostScreen,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.buttonColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return getPublishPostData();
        },
        child: Obx(() {
          return   getPublishModel.value.status == true ?
            SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5F5F5F).withOpacity(0.4),
                      offset: const Offset(0.0, 0.2),
                      blurRadius: 2,
                    ),
                  ]),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: postController,
                        decoration: InputDecoration(
                          hintText: 'What’s Happening?',
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.poppins(
                              color: const Color(0xFF5B5B5B),
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/link-2.png', width: 28,),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    NewHelper.showImagePickerSheet(
                                        gotImage: (File gg) {
                                          image1.value = gg;
                                          setState(() {});
                                        },
                                        context: context);
                                  },
                                  child: Image.asset('assets/images/gallery.png', width: 25,)),
                              const SizedBox(
                                width: 12,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    NewHelper().addVideoPicker()
                                        .then((value) {
                                      image1.value = value!;
                                    });
                                    setState(() {

                                    });
                                    String input = image1.value.toString();
                                    RegExp regExp = RegExp(r"'(.*?)'");
                                    Match? match = regExp.firstMatch(input);
                                    if (match != null) {
                                      filePath = match.group(1)!;
                                      print(filePath);
                                    } else {
                                      print("No match found");
                                    }
                                    print('video path is ${image1.value.toString()}');
                                  },
                                  child: Image.asset('assets/images/play-cricle.png', width: 27,)),

                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              createNewsRepo(
                                context: context,
                                title: postController.text.trim(),
                                description: postController.text.trim(),)
                                  .then((value) {

                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.buttonColor,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: const Text('Publish Post ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white
                                ),

                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      image1.value.path == "" ? const SizedBox() :
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AddSize.padding16,
                            vertical: AddSize.padding16),
                        width: AddSize.screenWidth,
                        height: 290,
                        child: Stack(
                          children: [
                            SizedBox(
                                width: double.maxFinite,
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: BetterPlayer.file(
                                    filePath.toString(),
                                    betterPlayerConfiguration:
                                    const BetterPlayerConfiguration(
                                      autoPlay: false,
                                      aspectRatio: 16 / 9,
                                    ),
                                  ),
                                )
                            ),

                            // Positioned(
                            //   right: 0,
                            //   top: 0,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       print('dgfygd');
                            //       NewHelper()
                            //           .addImagePicker(
                            //           imageSource: ImageSource.gallery)
                            //           .then((value) {
                            //         image1.value = value!;
                            //         print(
                            //             image1.value.path);
                            //         setState(() {});
                            //         // print(controller.image.value.path);
                            //       });
                            //     },
                            //     child: Container(
                            //       height: AddSize.size30,
                            //       width: AddSize.size30,
                            //       decoration: BoxDecoration(
                            //           border: Border.all(
                            //               width: 1,
                            //               color: Colors.black12),
                            //           color:
                            //           Colors.green,
                            //           borderRadius:
                            //           BorderRadius.circular(
                            //               50)),
                            //       child: const Center(
                            //           child: Icon(
                            //             Icons.edit,
                            //             color: Colors.black45,
                            //             size: 20,
                            //           )),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: getPublishModel.value.data!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var item = getPublishModel.value.data![index];
                    String inputDateString = item.createdAt.toString();
                    DateTime dateTime = DateTime.parse(inputDateString);
                    String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day
                        .toString().padLeft(2, '0')}";
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF5F5F5F).withOpacity(0.4),
                              offset: const Offset(0.0, 0.2),
                              blurRadius: 2,
                            ),
                          ]),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          imageUrl: item.userId!.profileImage.toString(),
                                          height: 45,
                                          width: 45,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) => Image.asset('assets/images/post_img.png'),
                                        ),
                                      ),
                                      const SizedBox(width: 15,),
                                      Text(item.userId!.name.toString(),
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15
                                        ),)
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(formattedDate.toString(),
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xFF5B5B5B),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12
                                    ),),
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(item.discription.toString(),
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF5B5B5B),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  letterSpacing: 0.24,
                                ),),
                              const SizedBox(
                                height: 15,
                              ),
                              item.fileType!.contains('image') ?
                              SizedBox(
                                width: double.maxFinite,
                                child: CachedNetworkImage(
                                  imageUrl: item.file.toString(),
                                  height: 170,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/images/Rectangle 39892.png', fit: BoxFit.fitWidth,),
                                ),
                              ) : item.fileType == 'directory' ?
                              const SizedBox() :
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: BetterPlayer.network(
                                  item.file.toString(),

                                  betterPlayerConfiguration:
                                  const BetterPlayerConfiguration(
                                    autoPlay: false,
                                    aspectRatio: 16 / 9,
                                  ),
                                ),
                              ),

                              item.fileType == 'directory' ?
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white,
                                ),

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.favorite_border, color: Color(0xFF014E70),),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text('7482',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF014E70),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        letterSpacing: 0.24,
                                      ),),
                                  ],
                                ),
                              ) :
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.favorite_border, color: Color(0xFF014E70),),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text('7482',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF014E70),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        letterSpacing: 0.24,
                                      ),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    );
                  },
                ),

              ],
            ),
          ): const LoadingAnimation();
        }),
      ),
    );
  }
}
