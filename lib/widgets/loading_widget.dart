  import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

Center loadingWidget() {
    return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CollectionSlideTransition(
                  children: const <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 12,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 12,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.yellow,
                      radius: 12,
                    ),
                  ],
                ),
                FadingText('Loading...'),
              ],
            ),
          );
  }
