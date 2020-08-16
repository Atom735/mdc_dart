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

/**
 * Defines the shape of the adapter expected by the foundation.
 * Implement this adapter for your framework of choice to delegate updates to
 * the component in your framework of choice. See architecture documentation
 * for more details.
 * https://github.com/material-components/material-components-web/blob/master/docs/code/architecture.md
 */
abstract class MDCTabAdapter {
  /**
   * Adds the given className to the root element.
   * @param className The className to add
   */
  void addClass(String className);

  /**
   * Removes the given className from the root element.
   * @param className The className to remove
   */
  void removeClass(String className);

  /**
   * Returns whether the root element has the given className.
   * @param className The className to remove
   */
  bool hasClass(String className);

  /**
   * Sets the given attrName of the root element to the given value.
   * @param attr The attribute name to set
   * @param value The value so give the attribute
   */
  void setAttr(String attr, String value);

  /**
   * Activates the indicator element.
   * @param previousIndicatorClientRect The client rect of the previously activated indicator
   */
  void activateIndicator(ClientRect previousIndicatorClientRect?);

  /** Deactivates the indicator. */
  void deactivateIndicator();

  /**
   * Emits the MDCTab:interacted event for use by parent components
   */
  void notifyInteracted();

  /**
   * Returns the offsetLeft value of the root element.
   */
  num getOffsetLeft();

  /**
   * Returns the offsetWidth value of the root element.
   */
  num getOffsetWidth();

  /**
   * Returns the offsetLeft of the content element.
   */
  num getContentOffsetLeft();

  /**
   * Returns the offsetWidth of the content element.
   */
  num getContentOffsetWidth();

  /**
   * Applies focus to the root element
   */
  void focus();
} /* interface:MDCTabAdapter */
