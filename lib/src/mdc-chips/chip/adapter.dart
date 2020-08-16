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

import './constants.dart' show EventSource;

/**
 * Defines the shape of the adapter expected by the foundation.
 * Implement this adapter for your framework of choice to delegate updates to
 * the component in your framework of choice. See architecture documentation
 * for more details.
 * https://github.com/material-components/material-components-web/blob/master/docs/code/architecture.md
 */
abstract class MDCChipAdapter {
  /**
   * Adds a class to the root element.
   */
  void addClass(String className);

  /**
   * Removes a class from the root element.
   */
  void removeClass(String className);

  /**
   * @return true if the root element contains the given class.
   */
  bool hasClass(String className);

  /**
   * Adds a class to the leading icon element.
   */
  void addClassToLeadingIcon(String className);

  /**
   * Removes a class from the leading icon element.
   */
  void removeClassFromLeadingIcon(String className);

  /**
   * @return true if target has className, false otherwise.
   */
  bool eventTargetHasClass(EventTarget target, String className);

  /**
   * @return the attribute string value if present, otherwise null
   */
  String getAttribute(String attr);

  /**
   * Emits a custom "MDCChip:interaction" event denoting the chip has been
   * interacted with (typically on click or keydown).
   */
  void notifyInteraction();

  /**
   * Emits a custom "MDCChip:selection" event denoting the chip has been selected or deselected.
   */
  void notifySelection(bool selected, bool chipSetShouldIgnore);

  /**
   * Emits a custom "MDCChip:trailingIconInteraction" event denoting the trailing icon has been
   * interacted with (typically on click or keydown).
   */
  void notifyTrailingIconInteraction();

  /**
   * Emits a custom event "MDCChip:removal" denoting the chip will be removed.
   */
  void notifyRemoval(String removedAnnouncement);

  /**
   * Emits a custom event "MDCChip:navigation" denoting a focus navigation event.
   */
  void notifyNavigation(String key, EventSource source);

  /**
   * Emits when editing starts.
   */
  void notifyEditStart();

  /**
   * Emits when editing finishes.
   */
  void notifyEditFinish();

  /**
   * @return The computed property value of the given style property on the root element.
   */
  String getComputedStyleValue(String propertyName);

  /**
   * Sets the property value of the given style property on the root element.
   */
  void setStyleProperty(String propertyName, String value);

  /**
   * @return Whether the chip has a leading icon.
   */
  bool hasLeadingIcon();

  /**
   * @return The bounding client rect of the root element.
   */
  ClientRect getRootBoundingClientRect();

  /**
   * @return The bounding client rect of the checkmark element or null if it doesn't exist.
   */
  ClientRect getCheckmarkBoundingClientRect();

  /**
   * Sets the value of the attribute on the primary action content.
   */
  void setPrimaryActionAttr(String attr, String value);

  /**
   * Gives focus to the primary action.
   */
  void focusPrimaryAction();

  /**
   * Sets focus to the trailing action.
   */
  void focusTrailingAction();

  /**
   * Removes focus from the trailing action.
   */
  void removeTrailingActionFocus();

  /**
   * Returns true if the trailing action is navigable.
   * Should return the value of MDCChipTrailingAction#isNavigable() or false.
   */
  bool isTrailingActionNavigable();

  /**
   * @return true if the text direction is right-to-left.
   */
  bool isRTL();
} /* interface:MDCChipAdapter */
