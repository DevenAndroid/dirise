
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/common_textfield.dart';
import 'order_completed_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});
  static var checkOutScreen = "/checkOutScreen";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(backgroundColor: Colors.white,surfaceTintColor: Colors.white, elevation: 0,leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70),size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Checkout",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 22),),

          ],
        ),),

      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.fromLTRB(18,10,18,18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start
          ,children: [
          Text("Deliver to ",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18)),
          const SizedBox(height: 20,),
            InkWell(onTap: (){
              bottemSheet();
            },
              child: DottedBorder(
                color: const Color(0xff014E70),
                strokeWidth: 1.2,
                dashPattern: const [6,3,0,3],
                child:Container(
                  height: 60,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Text("Address ",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18)),),
              ),
            ),
            const SizedBox(height: 30,),
            Text("Payment",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18)),
            const SizedBox(height: 20,),
            Row(children: [
              Container(width: size.width*.3,
                decoration: BoxDecoration(border: Border.all(color: const Color(0xffAFB1B1)),borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: Column(children: [
                        Image.asset("assets/images/knet.png",width: 50,height: 55,)
                ],),
              ),
              const SizedBox(width: 15,),
              Container(width: size.width*.3,
                         height: 57,
                decoration: BoxDecoration(border: Border.all(color: const Color(0xffAFB1B1)),borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Icon(Icons.credit_card,color: Color(0xffAFB1B1),),
                  Text("Credit Card",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 12)),

                ],),
              )

            ],),
            const SizedBox(height: 30,),
            Text("Add delivery instructions :",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18)),
            const SizedBox(height: 10,),
            Text("Add delivery instructions to help us with the delivery",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: const Color(0xff949495))),
            const SizedBox(height: 30,),
            Text("Have a coupon code?",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18)),
            const SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Expanded(child: CommonTextfield(obSecure: false, hintText: 'Enter Code',)),
              Expanded(
                child: TextFormField(style: GoogleFonts.poppins(),decoration: InputDecoration.collapsed(hintText: "Enter Conde",hintStyle: GoogleFonts.poppins(color: const Color(0xff949495))),
                ),
              ),
              const SizedBox(width: 20,),
              Container(decoration: BoxDecoration(color: const Color(0xff014E70),borderRadius: BorderRadius.circular(22)),
                padding: const EdgeInsets.fromLTRB(22,10,22,10),
                child: Text("Apply",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),),)
            ],),
            const SizedBox(height: 30,),
            Text("Your Order",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18)),
            const SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal (4 items)",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: const Color(0xff949495))),
                Text("KWD 21.00",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: const Color(0xff949495))),
              ],),
            const SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18)),
                Text("KWD 21.00",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18)),
              ],),



        ],),),
      ),
      bottomNavigationBar: InkWell(onTap: (){
        Get.toNamed(OrderCompleteScreen.orderCompleteScreen);
      },
        child: Container(decoration: const BoxDecoration(color: Color(0xff014E70)),
        height: 55,
        alignment: Alignment.bottomCenter,
        child: Align(alignment:Alignment.center,child: Text("Complete Payment",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 19,color: Colors.white))),),
      ),
    );
  }
  Future bottemSheet(){
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return  Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: size.width,
              height: size.height*.8,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Area *',
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color:const Color(0xff585858)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 15),
                      child: CommonTextfield(obSecure: false, hintText: 'Select area',),
                    ),
                    Text(
                      'Block *',
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color:const Color(0xff585858)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 15),
                      child: CommonTextfield(obSecure: false, hintText: 'Select block',),
                    ),
                    Text(
                      'Street and avenue * ',
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color:const Color(0xff585858)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 15),
                      child: CommonTextfield(obSecure: false, hintText: 'Select Street and avenue  ',),
                    ),
                    Text(
                      'Address type *',
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color:const Color(0xff585858)),
                    ),
                    const SizedBox(height: 8,),
                    Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                      Container(width: size.width*.25,
                        height: 52,
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xffAFB1B1)),borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.center,
                        child: Text(
                          'House',
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color:const Color(0xff585858)),
                        ),
                      ),
                      Container(width: size.width*.25,
                        height: 52,
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xffAFB1B1)),borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.center,
                        child: Text(
                          'Farm',
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color:const Color(0xff585858)),
                        ),
                      ),
                      Container(width: size.width*.25,
                        height: 52,
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xffAFB1B1)),borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.center,
                        child: Text(
                          'Farm',
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color:const Color(0xff585858)),
                        ),
                      )
                    ],),
                    const SizedBox(height:15),
                    Text(
                      'House No *',
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color:const Color(0xff585858)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 15),
                      child: CommonTextfield(obSecure: false, hintText: 'House No ',),
                    ),
                    Text(
                      'Name this Address * ',
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color:const Color(0xff585858)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 15),
                      child: CommonTextfield(obSecure: false, hintText: 'e.g. Home / Office / Gym',),
                    ),
                    Text(
                      'Contact Number *',
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color:const Color(0xff585858)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 15),
                      child: CommonTextfield(obSecure: false, hintText: 'Enter Contact Number ',),
                    ),



                  ],
                ),
              ),
            ),
          );
        });
  }
}
