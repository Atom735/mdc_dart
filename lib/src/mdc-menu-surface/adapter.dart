/**
 * @license
 * Copyright 2018 Google Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import './types.dart' show MDCMenuDimensions, MDCMenuDistance, MDCMenuPoint;

/**
 * Defines the shape of the adapter expected by the foundation.
 * Implement this adapter for your framework of choice to delegate updates to
 * the component in your framework of choice. See architecture documentation
 * for more details.
 * https://github.com/material-components/material-components-web/blob/master/docs/code/architecture.md
 */
abstract class MDCMenuSurfaceAdapter {
  void addClass(String className);
  void removeClass(String className);
  bool hasClass(String className);
  bool hasAnchor();

  bool isElementInContainer(Element el);
  bool isFocused();
  bool isRtl();

  MDCMenuDimensions getInnerDimensions();
  ClientRect getAnchorDimensions();
  MDCMenuDimensions getWindowDimensions();
  MDCMenuDimensions getBodyDimensions();
  MDCMenuPoint getWindowScroll();
  void setPosition(Partial<MDCMenuDistance> position);
  void setMaxHeight(String height);
  void setTransformOrigin(String origin);

  /** Saves the element that was focused before the menu surface was opened. */
  void saveFocus();

  /** Restores focus to the element that was focused before the menu surface was opened. */
  void restoreFocus();

  /** Emits an event when the menu surface is closed. */
  void notifyClose();

  /** Emits an event when the menu surface is opened. */
  void notifyOpen();
} /* interface:MDCMenuSurfaceAdapter */
