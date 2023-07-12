import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedOrderScreen extends StatefulWidget {
  const SelectedOrderScreen({super.key});
  static var selectedOrderScreen = "/selectedOrderScreen";

  @override
  State<SelectedOrderScreen> createState() => _SelectedOrderScreenState();
}

class _SelectedOrderScreenState extends State<SelectedOrderScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order",
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order #00069899",
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
              ),
              ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xffD9D9D9))),
                      ),
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xffEEEEEE),
                            child: Text("2x"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            height: size.height * .12,
                            'assets/images/bag.png',
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ecstasy 165 days ',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                '1 piece',
                                style: GoogleFonts.poppins(color: const Color(0xff858484)),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Date",
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text(
                      "2023-05-05",
                      style: GoogleFonts.poppins(
                          color: const Color(0xff9B9B9B), fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Status",
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text(
                      "Complete",
                      style: GoogleFonts.poppins(
                          color: const Color(0xff9B9B9B), fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment",
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text(
                      "22.9 KWD",
                      style: GoogleFonts.poppins(
                          color: const Color(0xff9B9B9B), fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Deliver",
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text(
                      "2 KWD",
                      style: GoogleFonts.poppins(
                          color: const Color(0xff9B9B9B), fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
