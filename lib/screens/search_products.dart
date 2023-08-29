import 'package:dirise/screens/app_bar/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/common_colour.dart';

class SearchProductsScreen extends StatefulWidget {
  final String searchText;
  const SearchProductsScreen({Key? key, required this.searchText}) : super(key: key);

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {

  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(
            titleText: "Search",
            backGroundColor: AppTheme.buttonColor,
            textColor: Colors.white,
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              // await getAllAsync();
            },
            child: Column(
              children: [
                Container(
                  color: AppTheme.buttonColor,
                  child: Column(
                    children: [
                      Hero(
                        tag: "search_tag",
                        child: Material(
                          color: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: textEditingController,
                              style: GoogleFonts.poppins(fontSize: 16),
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                  filled: true,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      'assets/icons/search.png',
                                      height: 5,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.buttonColor)),
                                  disabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.buttonColor)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.buttonColor)),
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.all(15),
                                  hintText: 'What are you looking for?',
                                  hintStyle: GoogleFonts.poppins(color: AppTheme.buttonColor, fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: const SingleChildScrollView(
                        child: Column(children: [
                      // SliderWidget(),
                      // CategoryItems(),
                      // TrendingProducts(),
                      // PopularProducts(),
                      // AdBannerUI(),
                      // AuthorScreen(),
                    ])),
                  ),
                ),
              ],
            )));
  }
}
