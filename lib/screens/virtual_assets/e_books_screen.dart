import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class EBookListScreen extends StatefulWidget {
  const EBookListScreen({super.key});

  @override
  State<EBookListScreen> createState() => _EBookListScreenState();
}

class _EBookListScreenState extends State<EBookListScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: .74
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/notebook.png',
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  'Rock NoteBook',
                  maxLines: 3,
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                )
              ],
            ),
          );
        });
  }
}
