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
abstract class MDCListAdapter {
  /**
   * Returns the attribute value of list item at given `index`.
   */
  String getAttributeForElementIndex(num index, String attr);

  num getListItemCount();

  num getFocusedElementIndex();

  void setAttributeForElementIndex(num index, String attribute, String value);

  void addClassForElementIndex(num index, String className);

  void removeClassForElementIndex(num index, String className);

  /**
   * Focuses list item at the index specified.
   */
  void focusItemAtIndex(num index);

  /**
   * Sets the tabindex to the value specified for all button/a element children of
   * the list item at the index specified.
   */
  void setTabIndexForListItemChildren(num listItemIndex, String tabIndexValue);

  /**
   * @return true if radio button is present at given list item index.
   */
  bool hasRadioAtIndex(num index);

  /**
   * @return true if checkbox is present at given list item index.
   */
  bool hasCheckboxAtIndex(num index);

  /**
   * @return true if checkbox inside a list item is checked.
   */
  bool isCheckboxCheckedAtIndex(num index);

  /**
   * @return true if root element is focused.
   */
  bool isRootFocused();

  /**
   * @param index list item index.
   * @param className the name of the class whose presence is to be checked.
   * @return true if list item at `index` has class `className`.
   */
  bool listItemAtIndexHasClass(num index, String className);

  /**
   * Sets the checked status of checkbox or radio at given list item index.
   */
  void setCheckedCheckboxOrRadioAtIndex(num index, bool isChecked);

  /**
   * Notifies user action on list item.
   */
  void notifyAction(num index);

  /**
   * @return true when the current focused element is inside list root.
   */
  bool isFocusInsideList();

  /**
   * @return the primary text content of the list item at index.
   */
  String getPrimaryTextAtIndex(num index);
} /* interface:MDCListAdapter */
