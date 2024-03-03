import 'package:flipub/views/library_view.dart';
import 'package:flutter/material.dart';

const sharedPreferencesFontSizeKey = 'fontSize';

class Flipub extends StatelessWidget {
  const Flipub({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LibrayView(),
    );
  }
}
