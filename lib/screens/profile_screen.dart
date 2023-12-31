import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getDataProfile();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My profile',
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
      body: Obx(() {
        return profileController.statusOfProfile.value.isSuccess
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(MyRouters.editprofileScreen);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            color: AppTheme.primaryColor,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              imageUrl: profileController.model.value.user!.profileImage.toString(),
                              placeholder: (context, url) => const SizedBox(),
                              errorWidget: (context, url, error) => const SizedBox(),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.buttonColor),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Image.asset(
                                'assets/icons/profile.png',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: const Color(0xff454545),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                               profileController.model.value.user!.name.toString(),

                                style: GoogleFonts.poppins(
                                    color: const Color(0xff21181A), fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: Color(0xffEFEFEF),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.buttonColor),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Image.asset(
                                'assets/icons/message.png',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'E-Mail',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: const Color(0xff454545),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                profileController.model.value.user!.email.toString(),
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff21181A), fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: Color(0xffEFEFEF),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.buttonColor),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Image.asset(
                                'assets/icons/phone.png',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mobile Number',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: const Color(0xff454545),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                profileController.model.value.user!.phone.toString(),
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff21181A), fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: Color(0xffEFEFEF),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: 50,
                      //       width: 50,
                      //       decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.buttonColor),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(15),
                      //         child: Image.asset(
                      //           'assets/icons/location.png',
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 15,
                      //     ),
                      //     Expanded(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             'Address',
                      //             style: GoogleFonts.poppins(
                      //               fontSize: 14,
                      //               color: const Color(0xff454545),
                      //             ),
                      //           ),
                      //           const SizedBox(
                      //             height: 3,
                      //           ),
                      //           Text(
                      //             profileController.model.value.user!.address.toString(),
                      //             style: GoogleFonts.poppins(
                      //                 color: const Color(0xff21181A), fontSize: 16, fontWeight: FontWeight.w500),
                      //           ),
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      SizedBox(
                        height: size.height * .23,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: size.height * .07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.buttonColor,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          onPressed: () {
                            Get.toNamed(MyRouters.editprofileScreen);
                          },
                          child: Text(
                            'Edit profile',
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : profileController.statusOfProfile.value.isError
                ? SizedBox()
                : const CircularProgressIndicator();
        ;
      }),
    );
  }
}
