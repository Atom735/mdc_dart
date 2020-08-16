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
abstract class MDCDrawerAdapter {
  /**
   * Adds a class to the root Element.
   */
  void addClass(String className);

  /**
   * Removes a class from the root Element.
   */
  void removeClass(String className);

  /**
   * Returns true if the root Element contains the given class.
   */
  bool hasClass(String className);

  /**
   * Returns true if the element contains the given class.
   * @param element target element to verify class name
   * @param className class name
   */
  bool elementHasClass(Element element, String className);

  /**
   * Saves the focus of currently active element.
   */
  void saveFocus();

  /**
   * Restores focus to element previously saved with 'saveFocus'.
   */
  void restoreFocus();

  /**
   * Focuses the active / selected navigation item.
   */
  void focusActiveNavigationItem();

  /**
   * Emits a custom event "MDCDrawer:closed" denoting the drawer has closed.
   */
  void notifyClose();

  /**
   * Emits a custom event "MDCDrawer:opened" denoting the drawer has opened.
   */
  void notifyOpen();

  /**
   * Traps focus on root element and focuses the active navigation element.
   */
  void trapFocus();

  /**
   * Releases focus trap from root element which was set by `trapFocus`
   * and restores focus to where it was prior to calling `trapFocus`.
   */
  void releaseFocus();
} /* interface:MDCDrawerAdapter */
