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
abstract class MDCTabScrollerAdapter {
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
   * Adds the given className to the scroll area element.
   * @param className The className to add
   */
  void addScrollAreaClass(String className);

  /**
   * Returns whether the event target matches given className.
   * @param evtTarget The event target
   * @param selector The selector to check
   */
  bool eventTargetMatchesSelector(EventTarget evtTarget, String selector);

  /**
   * Sets a style property of the area element to the passed value.
   * @param propName The style property name to set
   * @param value The style property value
   */
  void setScrollAreaStyleProperty(String propName, String value);

  /**
   * Sets a style property of the content element to the passed value.
   * @param propName The style property name to set
   * @param value The style property value
   */
  void setScrollContentStyleProperty(String propName, String value);

  /**
   * Returns the scroll content element's computed style value of the given css property `propertyName`.
   * We achieve this via `getComputedStyle(...).getPropertyValue(propertyName)`.
   */
  String getScrollContentStyleValue(String propertyName);

  /**
   * Sets the scrollLeft value of the scroll area element to the passed value.
   * @param scrollLeft The new scrollLeft value
   */
  void setScrollAreaScrollLeft(num scrollLeft);

  /**
   * Returns the scrollLeft value of the scroll area element.
   */
  num getScrollAreaScrollLeft();

  /**
   * Returns the offsetWidth of the scroll content element.
   */
  num getScrollContentOffsetWidth();

  /**
   * Returns the offsetWitdth of the scroll area element.
   */
  num getScrollAreaOffsetWidth();

  /**
   * Returns the bounding client rect of the scroll area element.
   */
  ClientRect computeScrollAreaClientRect();

  /**
   * Returns the bounding client rect of the scroll content element.
   */
  ClientRect computeScrollContentClientRect();

  /**
   * Returns the height of the browser's horizontal scrollbars (in px).
   */
  num computeHorizontalScrollbarHeight();
} /* interface:MDCTabScrollerAdapter */
