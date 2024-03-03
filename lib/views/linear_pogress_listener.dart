import 'package:flutter/material.dart';

class LinearProgressController {
  LinearProgressController();

  void Function(double) onProgress = (double progress) {};
}

class LinearProgressListener extends StatefulWidget {
  const LinearProgressListener({
    super.key,
    required this.controller,
  });

  final LinearProgressController controller;

  @override
  State<LinearProgressListener> createState() => _LinearProgressListenerState();
}

class _LinearProgressListenerState extends State<LinearProgressListener> {
  double progress = 0;

  void _updateProgress(double progress) {
    setState(() {
      this.progress = progress;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.onProgress = _updateProgress;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: LinearProgressIndicator(
        value: progress,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
