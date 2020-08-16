/**
 * @license
 * Copyright 2017 Google Inc.
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

import 'package:mdc_dart/src/mdc-base/types.dart' show EventType, SpecificEventListener;

/**
 * Defines the shape of the adapter expected by the foundation.
 * Implement this adapter for your framework of choice to delegate updates to
 * the component in your framework of choice. See architecture documentation
 * for more details.
 * https://github.com/material-components/material-components-web/blob/master/docs/code/architecture.md
 */
abstract class MDCSliderAdapter {
  /**
   * Returns true if className exists for the slider Element
   */
  bool hasClass(String className);

  /**
   * Adds a class to the slider Element
   */
  void addClass(String className);

  /**
   * Removes a class from the slider Element
   */
  void removeClass(String className);

  /**
   * Returns a string if attribute name exists on the slider Element, otherwise
   * returns null
   */
  String getAttribute(String name);

  /**
   * Sets attribute name on slider Element to value
   */
  void setAttribute(String name, String value);

  /**
   * Removes attribute name from slider Element
   */
  void removeAttribute(String name);

  /**
   * Returns the bounding client rect for the slider Element
   */
  ClientRect computeBoundingRect();

  /**
   * Returns the tab index of the slider Element
   */
  num getTabIndex();

  /**
   * Registers an event handler on the root element for a given event.
   */
  void registerInteractionHandler<K extends EventType>(K evtType, SpecificEventListener<K> handler);

  /**
   * Deregisters an event handler on the root element for a given event.
   */
  void deregisterInteractionHandler<K extends EventType>(K evtType, SpecificEventListener<K> handler);

  /**
   * Registers an event handler on the thumb container element for a given
   * event.
   */
  void registerThumbContainerInteractionHandler<K extends EventType>(K evtType, SpecificEventListener<K> handler);

  /**
   * Deregisters an event handler on the thumb container element for a given
   * event.
   */
  void deregisterThumbContainerInteractionHandler<K extends EventType>(K evtType, SpecificEventListener<K> handler);

  /**
   * Registers an event handler on the body for a given event.
   */
  void registerBodyInteractionHandler<K extends EventType>(K evtType, SpecificEventListener<K> handler);

  /**
   * Deregisters an event handler on the body for a given event.
   */
  void deregisterBodyInteractionHandler<K extends EventType>(K evtType, SpecificEventListener<K> handler);

  /**
   * Registers an event handler for the window resize event
   */
  void registerResizeHandler(SpecificEventListener<'resize'> handler);

  /**
   * Deregisters an event handler for the window resize event
   */
  void deregisterResizeHandler(SpecificEventListener<'resize'> handler);

  /**
   * Emits a custom event MDCSlider:input from the root
   */
  void notifyInput();

  /**
   * Emits a custom event MDCSlider:change from the root
   */
  void notifyChange();

  /**
   * Sets a style property of the thumb container element to the passed value
   */
  void setThumbContainerStyleProperty(String propertyName, String value);

  /**
   * Sets a style property of the track element to the passed value
   */
  void setTrackStyleProperty(String propertyName, String value);

  /**
   * Sets the inner text of the pin marker to the passed value
   */
  void setMarkerValue(num value);

  /**
   * Send track markers numbers to setup mark container element
   */
  void setTrackMarkers(num step, num max, num min);

  /**
   * Returns true if the root element is RTL, otherwise false
   */
  bool isRTL();
} /* interface:MDCSliderAdapter */
