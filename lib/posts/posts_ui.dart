import 'dart:convert';
import 'dart:io';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/posts/post_ui_player.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/profile_controller.dart';
import '../language/app_strings.dart';
import '../model/create_news_model.dart';
import '../model/get_publish_model.dart';
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

  File pickedFile = File("");
  final formKey = GlobalKey<FormState>();
  String postId = '';
  final profileController = Get.put(ProfileController());

  createPost() {
    Map<String, String> map = {};
    map['title'] = postController.text.toString();
    map['discription'] = postController.text.toString();
    Map<String, File> gg = {};
    if (pickedFile.path.isNotEmpty) {
      gg["file"] = pickedFile;
    }
    if (profileController.userLoggedIn == true) {
      if (pickedFile.path.isNotEmpty || postController.text.isNotEmpty) {
        repositories
            .multiPartApi(mapData: map, images: gg, url: ApiUrls.createPostUrl, context: context, onProgress: (gg, kk) {})
            .then((value) {
          CreateNewsModel response = CreateNewsModel.fromJson(jsonDecode(value));
          showToast(response.message.toString());
          if (response.status == true) {
            postController.clear();
            pickedFile = File('');
            getPublishPostData();
            showToast(response.message.toString());
          } else {
            showToast(response.message.toString());
          }
        });
      } else {
        showToast('Nothing To Post');
      }
    } else {
      showToast('LogIN YourSelf First');
    }
  }

  addRemoveLike(postId) {
    Map<String, String> map = {};
    map['post_id'] = postId;

    repositories.postApi(mapData: map, url: ApiUrls.addRemoveLike, context: context).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getPublishPostData();
        showToast(response.message.toString());
      } else {
        showToast(response.message.toString());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // aboutUsData();
    getPublishPostData();
  }

  TextEditingController postController = TextEditingController();

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
          return getPublishModel.value.status == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
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
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: postController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Post Something';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'What’s Happening?',
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.poppins(
                                    color: const Color(0xFF5B5B5B), fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/link-2.png',
                                      width: 28,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          NewHelper.showImagePickerSheet(
                                              gotImage: (File gg) {
                                                pickedFile = gg;
                                                setState(() {});
                                              },
                                              context: context);
                                          print(pickedFile.path.toString());
                                        },
                                        child: Image.asset(
                                          'assets/images/gallery.png',
                                          width: 25,
                                        )),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          NewHelper().addVideoPicker().then((value) {
                                            if (value == null) return;
                                            pickedFile = value;
                                            setState(() {});
                                            print(pickedFile.path.toString());
                                          });
                                        },
                                        child: Image.asset(
                                          'assets/images/play-cricle.png',
                                          width: 27,
                                        )),
                                  ],
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    createPost();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.buttonColor,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                    child: const Text(
                                      'Publish Post ',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            pickedFile.path == ""
                                ? const SizedBox()
                                : Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: AddSize.padding16),
                                    width: AddSize.screenWidth,
                                    height: 160,
                                    alignment: Alignment.center,
                                    child: Image.file(
                                      pickedFile,
                                      fit: BoxFit.contain,
                                      errorBuilder: (_, __, ___) => SizedBox(
                                          width: double.maxFinite,
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: BetterPlayer.file(
                                              pickedFile.path,
                                              betterPlayerConfiguration: const BetterPlayerConfiguration(
                                                autoPlay: false,
                                                aspectRatio: 16 / 9,
                                              ),
                                            ),
                                          )),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          itemCount: getPublishModel.value.data!.length,
                          itemBuilder: (context, index) {
                            var item = getPublishModel.value.data![index];
                            String inputDateString = item.createdAt.toString();
                            DateTime dateTime = DateTime.parse(inputDateString);
                            String formattedDate =
                                "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
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
                                                  errorWidget: (context, url, error) =>
                                                      Image.asset('assets/images/post_img.png'),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                item.userId!.name.toString(),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            formattedDate.toString(),
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xFF5B5B5B), fontWeight: FontWeight.w500, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      Text(
                                        item.discription ?? '',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF5B5B5B),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          letterSpacing: 0.24,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      item.fileType!.contains('image')
                                          ? SizedBox(
                                              width: double.maxFinite,
                                              height: 300,
                                              child: CachedNetworkImage(
                                                imageUrl: item.file.toString(),
                                                fit: BoxFit.contain,
                                                errorWidget: (context, url, error) => Image.asset(
                                                  'assets/images/Rectangle 39892.png',
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            )
                                          : item.fileType == 'directory'
                                              ? const SizedBox()
                                              : item.fileType == ''
                                                  ? const SizedBox()
                                                  : AspectRatio(
                                                      aspectRatio: 16 / 9,
                                                      child:  PostVideoPlayer(
                                                        fileUrl: item.file.toString() ,
                                                      ),
                                                    ),
                                      item.fileType == 'directory'
                                          ? Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(40),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        addRemoveLike(item.id.toString());
                                                      },
                                                      child: item.isLike == true
                                                          ? const Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            )
                                                          : const Icon(
                                                              Icons.favorite_border,
                                                              color: Color(0xFF014E70),
                                                            )),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    item.likeCount.toString(),
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(0xFF014E70),
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 13,
                                                      letterSpacing: 0.24,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
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
                                                  InkWell(
                                                      onTap: () {
                                                        addRemoveLike(item.id.toString());
                                                      },
                                                      child: item.isLike == true
                                                          ? const Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            )
                                                          : const Icon(
                                                              Icons.favorite_border,
                                                              color: Color(0xFF014E70),
                                                            )),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    item.likeCount.toString() ?? '0',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(0xFF014E70),
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 13,
                                                      letterSpacing: 0.24,
                                                    ),
                                                  ),
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
                      ),
                    ],
                  ),
                )
              : const LoadingAnimation();
        }),
      ),
    );
  }
}
