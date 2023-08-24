import 'dart:convert';
import 'package:dirise/model/order_models/model_single_order_response.dart';
import 'package:dirise/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/model_virtual_assets.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';
import '../../virtual_file_opener/pdf_reader.dart';
import '../../widgets/loading_animation.dart';

class EBookListScreen extends StatefulWidget {
  const EBookListScreen({super.key});

  @override
  State<EBookListScreen> createState() => _EBookListScreenState();
}

class _EBookListScreenState extends State<EBookListScreen> {

  final Repositories repositories = Repositories();
  ModelVirtualAssets modelVirtualAssets = ModelVirtualAssets();
  
  getData(){
    repositories.getApi(url: ApiUrls.virtualAssetsPDFUrl).then((value) {
      modelVirtualAssets = ModelVirtualAssets.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  
  @override
  void initState() {
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return modelVirtualAssets.product != null ?
    modelVirtualAssets.product!.isNotEmpty ?
    GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: .74
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        itemCount: modelVirtualAssets.product!.length,
        itemBuilder: (context, index){
          final item = modelVirtualAssets.product![index];
          return Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: (){
                Get.to(()=> PDFOpener(
                  pdfUrl: OrderItem(
                    virtualProductFile: item.virtualProductFile,
                    productName: item.pname
                  ),
                ));
              },
              behavior: HitTestBehavior.translucent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.network(
                      item.featuredImage.toString(),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    item.pname.toString(),
                    maxLines: 3,
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          );
        }) :
    Center(child: Text("You don't have any book in your collection",style: normalStyle,),) :
    const LoadingAnimation();
  }
}
