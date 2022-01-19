import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  const Screen({
    required this.child,
    this.title,
    this.isBackButtonHidden = false,
    this.onWillPop,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final String? title;
  final bool isBackButtonHidden;

  /// A function to be called when trying to navigate to the previous screen. Must return true to allow navigation.
  final bool Function()? onWillPop;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop == null ? null : () async => onWillPop!(),
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
      ),
    );
  }
}
