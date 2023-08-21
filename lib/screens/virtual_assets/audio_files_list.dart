import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioFilesListScreen extends StatefulWidget {
  const AudioFilesListScreen({super.key});

  @override
  State<AudioFilesListScreen> createState() => _AudioFilesListScreenState();
}

class _AudioFilesListScreenState extends State<AudioFilesListScreen> {
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
                    'assets/images/voicebook.png',
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  'Eustasy 165 days',
                  maxLines: 3,
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                )
              ],
            ),
          );
        });
  }
}
