// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This example shows how to draw some bi-directional text using the raw
// interface to the engine.

import 'dart:ui' as ui;
import 'dart:typed_data';

// A paragraph represents a rectangular region that contains some text.
ui.Paragraph paragraph;

ui.Picture paint(ui.Rect paintBounds) {
  ui.PictureRecorder recorder = new ui.PictureRecorder();
  ui.Canvas canvas = new ui.Canvas(recorder, paintBounds);

  canvas.translate(ui.window.size.width / 2.0, ui.window.size.height / 2.0);
  canvas.drawRect(new ui.Rect.fromLTRB(-100.0, -100.0, 100.0, 100.0),
                  new ui.Paint()..color = const ui.Color.fromARGB(255, 0, 255, 0));

  // The paint method of Pargraph draws the contents of the paragraph unto the
  // given canvas.
  paragraph.paint(canvas, new ui.Offset(paragraph.maxWidth / -2.0, (paragraph.maxWidth / 2.0) - 125));

  return recorder.endRecording();
}

ui.Scene composite(ui.Picture picture, ui.Rect paintBounds) {
  final double devicePixelRatio = ui.window.devicePixelRatio;
  ui.Rect sceneBounds = new ui.Rect.fromLTWH(
    0.0,
    0.0,
    ui.window.size.width * devicePixelRatio,
    ui.window.size.height * devicePixelRatio
  );
  Float64List deviceTransform = new Float64List(16)
    ..[0] = devicePixelRatio
    ..[5] = devicePixelRatio
    ..[10] = 1.0
    ..[15] = 1.0;
  ui.SceneBuilder sceneBuilder = new ui.SceneBuilder(sceneBounds)
    ..pushTransform(deviceTransform)
    ..addPicture(ui.Offset.zero, picture)
    ..pop();
  return sceneBuilder.build();
}

void beginFrame(Duration timeStamp) {
  ui.Rect paintBounds = ui.Point.origin & ui.window.size;
  ui.Picture picture = paint(paintBounds);
  ui.Scene scene = composite(picture, paintBounds);
  ui.window.render(scene);
}

void main() {
  // To create a paragraph of text, we use ParagraphBuilder.
  ui.ParagraphBuilder builder = new ui.ParagraphBuilder()
    // We first push a style that turns the text blue.
    ..pushStyle(new ui.TextStyle(color: const ui.Color(0xFF0000FF)))
    ..addText('Hello, ')
    // The next run of text will be bold.
    ..pushStyle(new ui.TextStyle(fontWeight: ui.FontWeight.bold))
    ..addText('world. ')
    // The pop() command signals the end of the bold styling.
    ..pop()
    // We add text to the paragraph in logical order. The paragraph object
    // understands bi-directional text and will compute the visual ordering
    // during layout.
    ..addText('هذا هو قليلا طويلة من النص الذي يجب التفاف .')
    // The second pop() removes the blue color.
    ..pop()
    // We can add more text with the default styling.
    ..addText(' و أكثر قليلا لجعله أطول. ')
    ..addText('สวัสดี');
  // When we're done adding styles and text, we build the Paragraph object, at
  // which time we can apply styling that affects the entire paragraph, such as
  // left, right, or center alignment. Once built, the contents of the paragraph
  // cannot be altered, but sizing and positioning information can be updated.
  paragraph = builder.build(new ui.ParagraphStyle())
    // Next, we supply a maximum width that the text is permitted to occupy.
    ..maxWidth = 180.0
    // ... and we ask the paragraph to the visual position of each its glyphs as
    // well as its overall size, subject to its sizing constraints.
    ..layout();

  // Finally, we register our beginFrame callback and kick off the first frame.
  ui.window.onBeginFrame = beginFrame;
  ui.window.scheduleFrame();
}
