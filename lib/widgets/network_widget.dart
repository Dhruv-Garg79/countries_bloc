import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class NetworkWidget extends StatefulWidget {
  final Widget child;
  NetworkWidget({this.child});

  @override
  _NetworkWidgetState createState() => _NetworkWidgetState();
}

class _NetworkWidgetState extends State<NetworkWidget> {
  StreamSubscription<ConnectivityResult> _subscription;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();

    _subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        setState(() {
          _isOnline = result != ConnectivityResult.none;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isOnline
        ? widget.child
        : Center(
            child: Text(
              "Please check your network connectivity",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
