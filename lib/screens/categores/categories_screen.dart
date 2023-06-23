
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static var categoriesScreen = "/categoriesScreen";

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 35,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    InkWell(onTap: (){
                      Get.back();
                    },child: Icon(Icons.arrow_back_ios)),
                    const SizedBox(width: 20,),
                    Text("Categories",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),),
                  ],),

                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff014E70)
                    ),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                        Text(("0"),style: TextStyle(color: Colors.white,fontSize: 20),)
                      ],),
                  )

                ],),
              Container(child: Image.asset("name"),)
            ],
          )
        //     : Column(
        //   children: [
        //     Expanded(
        //       child: ListView.builder(
        //           itemCount: cartController.model.value.cart!.length,
        //           shrinkWrap: true,
        //           itemBuilder: (context, index) {
        //             return GestureDetector(
        //               onTap: () {
        //                 if (cartController.model.value.cart![index].productType.toString() == "booking") {
        //                   Get.toNamed(MyRouter.bookingProductScreen, arguments: [cartController.model.value.cart![index].id.toString()]);
        //                 }
        //                 else {
        //                   singleProductRedirection(
        //                       cartController.model.value.cart![index].productType.toString(),
        //                       index,
        //                       cartController.model.value.cart![index].slug,
        //                       cartController.model.value.cart![index]);
        //                 }
        //               },
        //               child: Card(
        //                 margin: const EdgeInsets.only(bottom: 10),
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(20.0),
        //                 ),
        //                 child: Stack(
        //                   children: [
        //                     Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: Row(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Material(
        //                             borderRadius: BorderRadius.circular(12),
        //                             elevation: 3,
        //                             shadowColor: Colors.grey.shade400,
        //                             child: SizedBox(
        //                               height: 110,
        //                               width: 100,
        //                               child: ClipRRect(
        //                                 borderRadius:
        //                                 const BorderRadius.all( Radius.circular(12)),
        //                                 child: CachedNetworkImage(
        //                                   imageUrl: cartController.model.value.cart![index].featuredImage.toString(),
        //                                   fit: BoxFit.fill,
        //                                   placeholder: (context, url) => const SizedBox(),
        //                                   errorWidget: (context, url, error) => const SizedBox(),
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                           addWidth(10),
        //                           Expanded(
        //                               flex: 2,
        //                               child: Column(
        //                                 crossAxisAlignment: CrossAxisAlignment.start,
        //                                 children: [
        //                                   addHeight(6),
        //                                   Text(
        //                                     cartController.model.value.cart![index].pname.toString(),
        //                                     style: const TextStyle(
        //                                         color: AppTheme.textColorDarkBLue,
        //                                         fontSize: 16.0,
        //                                         fontWeight: FontWeight.w400),
        //                                   ),
        //                                   addHeight(6),
        //                                   Text("${cartController.model.value.cart![index].productType.toString().capitalizeFirst!} product",
        //                                     style: TextStyle(
        //                                       color: AppTheme.textColorDarkBLue.withOpacity(0.5),
        //                                       fontSize: 14.0,),
        //                                   ),
        //                                   addHeight(6),
        //                                   Text('${cartController.model.value.cart![index].currencySign.toString()} '
        //                                       '${cartController.model.value.cart![index].sPrice}',
        //                                     style: const TextStyle(
        //                                         color: AppTheme.badgeColor,
        //                                         fontSize: 14.0,
        //                                         fontWeight: FontWeight.w500),
        //                                   ),
        //                                   addHeight(8),
        //                                   cartController.model.value.cart![index].productType.toString() != "booking"
        //                                       && cartController.model.value.cart![index].productType.toString() != "bid" ?
        //                                   Row(
        //                                     children: [
        //                                       InkWell (
        //                                         onTap: (){
        //                                           if(int.parse(cartController.model.value.cart![index].qty!) > 1) {
        //                                             cartController.model.value.cart![index].qty = (int.parse(cartController.model.value.cart![index].qty!) - 1).toString();
        //                                             cartQuantityUpdate(context , cartController.model.value.cart![index].id , cartController.model.value.cart![index].qty).then((value) {
        //                                               showToast(value.message);
        //                                               if(value.status) {
        //                                                 cartController.totalAmount.value = "0";
        //                                                 for(var item in cartController.model.value.cart!) {
        //                                                   cartController.totalAmount.value =
        //                                                       (double.parse(cartController.totalAmount.toString()) +
        //                                                           (double.parse(item.qty.toString()) * double.parse(item.sPrice.toString()))).toString();
        //                                                 }
        //                                                 setState((){});
        //                                               } else {
        //                                                 cartController.model.value.cart![index].qty =
        //                                                     (int.parse(cartController.model.value.cart![index].qty!) + 1).toString();
        //                                               }
        //                                             });
        //                                           }
        //                                         },
        //                                         child: Container(
        //                                             padding: const EdgeInsets.all(4),
        //                                             decoration: BoxDecoration(
        //                                                 color: Colors.transparent,
        //                                                 border: Border.all(color: AppTheme.badgeColor,
        //                                                   width: 1,
        //                                                 ),
        //                                                 borderRadius: BorderRadius.circular(100)
        //                                             ),
        //                                             child: const Icon(
        //                                               Icons.remove,
        //                                               size: 16,
        //                                               color: AppTheme.badgeColor,
        //                                             )),
        //                                       ),
        //                                       addWidth(10),
        //                                       Text(
        //                                         cartController.model.value.cart![index].qty.toString(),
        //                                         style: const TextStyle(
        //                                             color: AppTheme.badgeColor,
        //                                             fontSize: 16.0,
        //                                             fontWeight: FontWeight.w500),
        //                                       ),
        //                                       addWidth(10),
        //                                       InkWell(
        //                                         onTap: (){
        //                                           cartController.model.value.cart![index].qty = (int.parse(cartController.model.value.cart![index].qty.toString()) + 1).toString();
        //                                           cartQuantityUpdate(
        //                                               context,
        //                                               cartController.model.value.cart![index].id,
        //                                               cartController.model.value.cart![index].qty).then((value) {
        //                                             showToast(value.message);
        //                                             if(value.status){
        //                                               cartController.totalAmount.value = "0";
        //                                               for(var item in cartController.model.value.cart!){
        //                                                 cartController.totalAmount.value =
        //                                                     (double.parse(cartController.totalAmount.toString()) +
        //                                                         (double.parse(item.qty.toString()) * double.parse(item.sPrice.toString()))).toString();
        //                                               }
        //                                               setState((){
        //                                               });
        //                                             }
        //                                             else{
        //                                               cartController.model.value.cart![index].qty = (int.parse(cartController.model.value.cart![index].qty.toString()) - 1).toString();
        //                                             }
        //                                           });
        //                                         },
        //                                         child: Container(
        //                                             padding: const EdgeInsets.all(4),
        //                                             decoration: BoxDecoration(
        //                                                 color: Colors.transparent,
        //                                                 border: Border.all(color: AppTheme.badgeColor,
        //                                                   width: 1,
        //                                                 ),
        //                                                 borderRadius:
        //                                                 BorderRadius.circular(100)),
        //                                             child: const Icon(
        //                                               Icons.add,
        //                                               size: 16,
        //                                               color: AppTheme.badgeColor,
        //                                             )),
        //                                       ),
        //                                     ],
        //                                   ) :
        //                                   Row(
        //                                     children: [
        //                                       Text(
        //                                         "QTY ${cartController.model.value.cart![index].qty}",
        //                                         style: const TextStyle(
        //                                             color: AppTheme.badgeColor,
        //                                             fontSize: 16.0,
        //                                             fontWeight: FontWeight.w500),
        //                                       ),
        //                                     ],
        //                                   )
        //                                 ],
        //                               )),
        //                         ],
        //                       ),
        //                     ),
        //                     Positioned(
        //                         right: 14,
        //                         bottom: 14,
        //                         child: IconButton(
        //                           alignment: Alignment.bottomRight,
        //                           padding: EdgeInsets.zero,
        //                           constraints: const BoxConstraints(
        //                             minHeight: 0,
        //                             minWidth: 0
        //                           ),
        //                           onPressed: () {
        //                             removeFromCardList(context , cartController.model.value.cart![index].id ).then((value) {
        //                               showToast(value.message);
        //                               if(value.status == true) {
        //                                 cartController.model.value.cart!.removeAt(index);
        //                                 cartController.getData();
        //                                 setState(() {});
        //                               }
        //                             });
        //                           },
        //                           icon: const Icon(
        //                             Icons.delete,
        //                             size: 24,
        //                             color: Colors.grey,
        //                           ),
        //                         ))
        //                   ],
        //                 ),
        //               ),
        //             );
        //           }),
        //     ),
        //     Card(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20.0),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        //         child: Column(
        //           children: [
        //             addHeight(12),
        //             _getPaymentDetails(
        //                 'Subtotal:',
        //                 "${cartController.model.value.cart![0].currencySign} ${cartController.totalAmount}"),
        //             addHeight(12),
        //             _getPaymentDetails(
        //                 'Tax and Fee:',
        //                 cartController.model.value.discount.toString()
        //             ),
        //             addHeight(12),
        //             Row(
        //               mainAxisAlignment:
        //               MainAxisAlignment.spaceBetween,
        //               children: [
        //                 const Text(
        //                   'Total:',
        //                   style: TextStyle(
        //                       fontSize: 18.0,
        //                       fontWeight: FontWeight.bold,
        //                       color:
        //                       AppTheme.primaryColor),
        //                 ),
        //                 Text("${cartController.model.value.cart![0].currencySign} ${cartController.totalAmount}",
        //                   style: TextStyle(
        //                       fontSize: 18.0,
        //                       fontWeight: FontWeight.bold,
        //                       color: Colors.grey.shade700),
        //                 ),
        //               ],
        //             ),
        //             addHeight(14),
        //             CommonButton(
        //                 buttonHeight: 6.5,
        //                 buttonWidth: screenSize.width,
        //                 text: 'Checkout',
        //                 onTap: () async {
        //                   SharedPreferences pref = await SharedPreferences.getInstance();
        //                   if (pref.getString('user') != null) {
        //                     Get.toNamed(MyRouter.checkoutScreen,
        //                         arguments: [cartController.totalAmount.value]);
        //                   } else {
        //                     Get.toNamed(MyRouter.logInScreen);
        //                   }
        //                 },
        //                 mainGradient: AppTheme.primaryGradientColor),
        //             addHeight(10),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
