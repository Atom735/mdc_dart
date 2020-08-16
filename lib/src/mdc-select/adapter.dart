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

import 'package:mdc_dart/src/mdc-menu-surface/constants.dart' show Corner;

/**
 * Defines the shape of the adapter expected by the foundation.
 * Implement this adapter for your framework of choice to delegate updates to
 * the component in your framework of choice. See architecture documentation
 * for more details.
 * https://github.com/material-components/material-components-web/blob/master/docs/code/architecture.md
 */
abstract class MDCSelectAdapter {
  /**
   * Adds class to select anchor element.
   */
  void addClass(String className);

  /**
   * Removes a class from the select anchor element.
   */
  void removeClass(String className);

  /**
   * Returns true if the select anchor element contains the given class name.
   */
  bool hasClass(String className);

  /**
   * Activates the bottom line, showing a focused state.
   */
  void activateBottomLine();

  /**
   * Deactivates the bottom line.
   */
  void deactivateBottomLine();

  /**
   * Returns the selected menu item element.
   */
  Element getSelectedMenuItem();

  /**
   * Returns true if label exists, false if it doesn't.
   */
  bool hasLabel();

  /**
   * Floats label determined based off of the shouldFloat argument.
   */
  void floatLabel(bool shouldFloat);

  /**
   * Returns width of label in pixels, if the label exists.
   */
  num getLabelWidth();

  /**
   * Styles the label as required, if the label exists.
   */
  void setLabelRequired(bool isRequired);

  /**
   * Returns true if outline element exists, false if it doesn't.
   */
  bool hasOutline();

  /**
   * Only implement if outline element exists.
   */
  void notchOutline(num labelWidth);

  /**
   * Closes notch in outline element, if the outline exists.
   */
  void closeOutline();

  /**
   * Sets the line ripple transform origin center.
   */
  void setRippleCenter(num normalizedX);

  /**
   * Emits a change event when an element is selected.
   */
  void notifyChange(String value);

  /**
   * Sets the text content of the selectedText element to the given string.
   */
  void setSelectedText(String text);

  /**
   * Returns whether the select anchor is focused.
   */
  bool isSelectAnchorFocused();

  /**
   * Gets the given attribute on the select anchor element.
   */
  String getSelectAnchorAttr(String attr);

  /**
   * Sets the given attribute on the select anchor element.
   */
  void setSelectAnchorAttr(String attr, String value);

  /**
   * Removes the given attribute on the select anchor element.
   */
  void removeSelectAnchorAttr(String attr);

  // Menu-related methods ======================================================

  /**
   * Adds class to the menu element.
   */
  void addMenuClass(String className);

  /**
   * Removes a class from the menu element.
   */
  void removeMenuClass(String className);

  /**
   * Opens the menu.
   */
  void openMenu();

  /**
   * Closes the menu.
   */
  void closeMenu();

  /**
   * Returns the select anchor element.
   */
  Element getAnchorElement();

  /**
   * Sets the menu anchor element.
   */
  void setMenuAnchorElement(Element anchorEl);

  /**
   * Sets the menu anchor corner.
   */
  void setMenuAnchorCorner(Corner anchorCorner);

  /**
   * Sets whether the menu should wrap focus.
   */
  void setMenuWrapFocus(bool wrapFocus);

  /**
   * Sets the attribute on the menu item at the given index.
   */
  void setAttributeAtIndex(num index, String attributeName, String attributeValue);

  /**
   * Focuses the menu item element at the given index.
   */
  void focusMenuItemAtIndex(num index);

  /**
   * Returns the number of menu items.
   */
  num getMenuItemCount();

  /**
   * Returns an array representing the VALUE_ATTR attributes of each menu item.
   */
  string[] getMenuItemValues();

  /**
   * Gets the text content of the menu item element at the given index.
   */
  String getMenuItemTextAtIndex(num index);

  /**
   * Returns the given attribute on the the menu item element.
   */
  String getMenuItemAttr(Element menuItem, String attr);

  /**
   * Adds the class name on the menu item at the given index.
   */
  void addClassAtIndex(num index, String className);

  /**
   * Removes the class name on the menu item at the given index.
   */
  void removeClassAtIndex(num index, String className);

  /**
   * Returns whether typeahead is in progress in the menu.
   */
  bool isTypeaheadInProgress();

  /**
   * Adds a character to the list typeahead buffer and returns index of the
   * next item in the list matching the buffer.
   */
  num typeaheadMatchItem(String nextChar, num startingIndex);
} /* interface:MDCSelectAdapter */
