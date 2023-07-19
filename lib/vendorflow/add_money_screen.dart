import 'package:dirise/routers/my_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/common_colour.dart';
import '../widgets/dimension_screen.dart';

class WithdrawMoney extends StatefulWidget {
  const WithdrawMoney({Key? key}) : super(key: key);
  static var withdrawMoney = "/withdrawMoney";
  @override
  State<WithdrawMoney> createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {
  final TextEditingController addMoneyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> moneyList = ["500", "800", "1000"];

  final walletStatus = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Withdrawal money',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xff423E5E),
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();

            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                'assets/icons/backicon.png',
                height: 23,
              ),
            ),
          ),
        ),
        // appBar: backAppBar(title: "Withdrawal money".tr, context: context),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF37C666).withOpacity(0.10),
                            offset: const Offset(
                              .1,
                              .1,
                            ),
                            blurRadius: 20.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "My Balance".tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                                    ),
                                    const Text(
                                      "€240.00",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 31, color: Color(0xFF262F33)),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.buttonColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.account_balance_wallet_sharp,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: AddSize.size5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF37C666).withOpacity(0.10),
                            offset: const Offset(
                              .1,
                              .1,
                            ),
                            blurRadius: 20.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                              child: Column(
                                children: [
                                  TextFormField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline5!.copyWith(
                                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: AddSize.font24),
                                      controller: addMoneyController,
                                      cursorColor: const Color(0xFF7ED957),
                                      // validator: validateMoney,
                                      decoration: const InputDecoration()),
                                  SizedBox(
                                    height: AddSize.size15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      moneyList.length,
                                      (index) => chipList(moneyList[index]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: AddSize.size25,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(MyRouters.orderDetails);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(double.maxFinite, AddSize.size50),
                                          primary: AppTheme.buttonColor,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          textStyle: TextStyle(fontSize: AddSize.font20, fontWeight: FontWeight.w500)),
                                      child: Text(
                                        "Withdrawal".tr.toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                                      )),
                                ],
                              ))),
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF37C666).withOpacity(0.10),
                              offset: const Offset(
                                .1,
                                .1,
                              ),
                              blurRadius: 20.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                          // color: AppTheme.backgroundcolor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Amount".tr,
                                  style: const TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: AppTheme.buttonColor),
                                ),
                                Text(
                                  "Date".tr,
                                  style: const TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: AppTheme.buttonColor),
                                ),
                                Text(
                                  "Status".tr,
                                  style: const TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: AppTheme.buttonColor),
                                )
                              ],
                            ),
                            const Divider(),
                            ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: AddSize.size5,
                                    ),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "€450.00",
                                          style: TextStyle(height: 1.5, fontWeight: FontWeight.w600, fontSize: 12),
                                        ),
                                        Text(
                                          "Monday, 2 June, 2021",
                                          style: TextStyle(
                                              height: 1.5,
                                              color: Color(0xFF8C9BB2),
                                              fontWeight: FontWeight.w300,
                                              fontSize: 11),
                                        ),
                                        Text(
                                          'Pending',
                                          style: TextStyle(
                                              height: 1.5,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Color(0xFFFFB26B)),
                                        )
                                      ],
                                    ),
                                    index != 4 ? const Divider() : const SizedBox(),
                                    SizedBox(
                                      height: AddSize.size5,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  chipList(title) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChoiceChip(
      padding: EdgeInsets.symmetric(horizontal: width * .005, vertical: height * .005),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), side: BorderSide(color: Colors.grey.shade300)),
      label: Text("+€${title}",
          style: const TextStyle(color: Color(0xFF262F33), fontSize: 14, fontWeight: FontWeight.w500)),
      selected: false,
      onSelected: (value) {
        setState(() {
          addMoneyController.text = title;
          FocusManager.instance.primaryFocus!.unfocus();
        });
      },
    );
  }
}
