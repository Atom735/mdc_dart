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

import './types.dart' show MDCMenuItemEventDetail;

/**
 * Implement this adapter for your framework of choice to delegate updates to
 * the component in your framework of choice. See architecture documentation
 * for more details.
 * https://github.com/material-components/material-components-web/blob/master/docs/code/architecture.md
 */
abstract class MDCMenuAdapter {
  /**
   * Adds a class to the element at the index provided.
   */
  void addClassToElementAtIndex(num index, String className);

  /**
   * Removes a class from the element at the index provided
   */
  void removeClassFromElementAtIndex(num index, String className);

  /**
   * Adds an attribute, with value, to the element at the index provided.
   */
  void addAttributeToElementAtIndex(num index, String attr, String value);

  /**
   * Removes an attribute from an element at the index provided.
   */
  void removeAttributeFromElementAtIndex(num index, String attr);

  /**
   * @return true if the element contains the className.
   */
  bool elementContainsClass(Element element, String className);

  /**
   * Closes the menu-surface.
   * @param skipRestoreFocus Whether to skip restoring focus to the previously
   *    focused element after the surface has been closed.
   */
  void closeSurface(bool skipRestoreFocus?);

  /**
   * @return Index of the element in the list or -1 if it is not in the list.
   */
  num getElementIndex(Element element);

  /**
   * Emit an event when a menu item is selected.
   */
  void notifySelected(MDCMenuItemEventDetail evtData);

  /** @return Returns the menu item count. */
  num getMenuItemCount();

  /**
   * Focuses the menu item at given index.
   * @param index Index of the menu item that will be focused every time the menu opens.
   */
  void focusItemAtIndex(num index);

  /** Focuses the list root element. */
  void focusListRoot();

  /**
   * @return Returns selected list item index within the same selection group which is
   * a sibling of item at given `index`.
   * @param index Index of the menu item with possible selected sibling.
   */
  num getSelectedSiblingOfItemAtIndex(num index);

  /**
   * @return Returns true if item at specified index is contained within an `.mdc-menu__selection-group` element.
   * @param index Index of the selectable menu item.
   */
  bool isSelectableItemAtIndex(num index);
} /* interface:MDCMenuAdapter */
