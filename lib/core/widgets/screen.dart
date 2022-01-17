import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  const Screen({
    required this.child,
    this.title,
    this.isBackButtonHidden = false,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final String? title;
  final bool isBackButtonHidden;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: title == null
            ? null
            : AppBar(
                centerTitle: true,
                title: Text(title!),
                automaticallyImplyLeading: !isBackButtonHidden,
              ),
        body: child,
      ),
    );
  }
}
