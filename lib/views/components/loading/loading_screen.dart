import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insta_riverpod/views/components/constants/strings.dart';
import 'package:insta_riverpod/views/components/loading/loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);

    final textStreamController = StreamController<String>();
    textStreamController.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: CircularProgressIndicator(),
                      ),
                      StreamBuilder<String>(
                        stream: textStreamController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.requireData,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        textStreamController.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        textStreamController.add(text);
        return true;
      },
    );
  }
}
