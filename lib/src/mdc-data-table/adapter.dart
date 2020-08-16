/**
 * @license
 * Copyright 2019 Google Inc.
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


import './constants.dart' show SortValue;
import './types.dart' show MDCDataTableRowSelectionChangedEventDetail, ProgressIndicatorStyles, SortActionEventDetail;

/**
 * Defines the shape of the adapter expected by the foundation.
 * Implement this adapter for your framework of choice to delegate updates to
 * the component in your framework of choice. See architecture documentation
 * for more details.
 * https://github.com/material-components/material-components-web/blob/master/docs/code/architecture.md
 */
abstract class MDCDataTableAdapter {
  /**
   * Adds CSS class name to root element.
   *
   * @param className CSS class name to add to root element.
   */
  void addClass(String className);

  /**
   * Removes CSS class name from root element.
   *
   * @param className CSS class name to add to root element.
   */
  void removeClass(String className);

  /**
   * Adds a class name to row element at given row index excluding header row.
   *
   * @param rowIndex Index of row element excluding header row.
   * @param cssClasses CSS Class string to add.
   */
  void addClassAtRowIndex(num rowIndex, String cssClasses);

  /**
   * @return Row count excluding header row.
   */
  num getRowCount();

  /**
   * @return Array of row elements excluding header row.
   */
  Element[] getRowElements();

  /**
   * Returns row id of row element at given row index based on `data-row-id` attribute on row element `tr`.
   *
   * @param rowIndex Index of row element.
   * @return Row id of row element, returns `null` in absence of `data-row-id` attribute on row element.
   */
  String getRowIdAtIndex(num rowIndex);

  /**
   * Returns index of row element that contains give child element. Returns -1 if element is not child of any row
   * element.
   *
   * @param el Child element of row element.
   * @return Index of row element.
   */
  num getRowIndexByChildElement(Element el);

  /**
   * @return Selected row count.
   */
  num getSelectedRowCount();

  /**
   * @param rowIndex Index of row element.
   * @return True if row checkbox at given row index is checked.
   */
  bool isCheckboxAtRowIndexChecked(num rowIndex);

  /**
   * @return True if header row checkbox is checked.
   */
  bool isHeaderRowCheckboxChecked();

  /**
   * @return True if table rows are selectable.
   */
  bool isRowsSelectable();

  /**
   * Notifies when row selection is changed.
   *
   * @param data Event detail data for row selection changed event.
   */
  void notifyRowSelectionChanged(MDCDataTableRowSelectionChangedEventDetail data);

  /**
   * Notifies when header row is checked.
   */
  void notifySelectedAll();

  /**
   * Notifies when header row is unchecked.
   */
  void notifyUnselectedAll();

  /**
   * Initializes header row checkbox. Destroys previous header row checkbox instance if any.
   * @return Can return Promise only if registering checkbox is asynchronous.
   */
  Promise<void> | void registerHeaderRowCheckbox();

  /**
   * Initializes all row checkboxes. Destroys previous row checkbox instances if any. This is usually called when row
   * checkboxes are added or removed from table.
   * @return Can return Promise only if registering checkbox is asynchronous.
   */
  Promise<void> | void registerRowCheckboxes();

  /**
   * Removes class name from row element at give row index.
   *
   * @param rowIndex Index of row element excluding header row element.
   * @param cssClasses Class name string.
   */
  void removeClassAtRowIndex(num rowIndex, String cssClasses);

  /**
   * Sets attribute to row element at given row index.
   *
   * @param rowIndex Index of row element excluding header row element.
   * @param attr Name of attribute.
   * @param value Value of attribute.
   */
  void setAttributeAtRowIndex(num rowIndex, String attr, String value);

  /**
   * Sets header row checkbox checked or unchecked.
   *
   * @param checked True to set header row checkbox checked.
   */
  void setHeaderRowCheckboxChecked(bool checked);

  /**
   * Sets header row checkbox to indeterminate.
   *
   * @param indeterminate True to set header row checkbox indeterminate.
   */
  void setHeaderRowCheckboxIndeterminate(bool indeterminate);

  /**
   * Sets row checkbox to checked or unchecked at given row index.
   *
   * @param rowIndex Index of row element excluding header row element.
   * @param checked True to set checked.
   */
  void setRowCheckboxCheckedAtIndex(num rowIndex, bool checked);

  /**
   * @return Total count of header cells.
   */
  num getHeaderCellCount();

  /**
   * @return Array of header cell elements.
   */
  Element[] getHeaderCellElements();

  /**
   * @return Attribute value for given header cell index.
   */
  String getAttributeByHeaderCellIndex(num columnIndex, String attribute);

  /**
   * Sets attribute of a header cell by index.
   */
  void setAttributeByHeaderCellIndex(num columnIndex, String attribute, String value);

  /**
   * Sets class name of a header cell by index.
   */
  void setClassNameByHeaderCellIndex(num columnIndex, String className);

  /**
   * Removes a class name of a header cell by index.
   */
  void removeClassNameByHeaderCellIndex(num columnIndex, String className);

  /**
   * Notifies when column is sorted.
   */
  void notifySortAction(SortActionEventDetail data);

  /**
   * @return Returns computed styles height of table's body element.
   */
  String getTableBodyHeight();

  /**
   * @return Returns computed styles height of table's header element.
   */
  String getTableHeaderHeight();

  /**
   * Sets progress indicator CSS styles to position it on top of table body.
   */
  void setProgressIndicatorStyles(ProgressIndicatorStyles styles);

  /**
   * Sets appropriate sort status label by header cell index. Skips setting sort
   * status label if header cell is not sortable.
   *
   * Example status label to set for sortValue:
   *
   *   - `SortValue.ASCENDING`: 'Sorted in ascending order'
   *   - `SortValue.DESCENDING`: 'Sorted in descending order'
   *   - `SortValue.NONE`: '' (Empty string)
   */
  void setSortStatusLabelByHeaderCellIndex(num columnIndex, SortValue sortValue);
} /* interface:MDCDataTableAdapter */
