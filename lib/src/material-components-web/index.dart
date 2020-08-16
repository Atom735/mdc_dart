/**
 * @license
 * Copyright 2016 Google Inc.
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

import 'package:mdc_dart/src/mdc-auto-init/index.dart' show autoInit;
import 'package:mdc_dart/src/mdc-base/index.dart' as base;
import 'package:mdc_dart/src/mdc-checkbox/index.dart' as checkbox;
import 'package:mdc_dart/src/mdc-chips/index.dart' as chips;
import 'package:mdc_dart/src/mdc-circular-progress/index.dart' as circularProgress;
import 'package:mdc_dart/src/mdc-data-table/index.dart' as dataTable;
import 'package:mdc_dart/src/mdc-dialog/index.dart' as dialog;
import 'package:mdc_dart/src/mdc-dom/index.dart' as dom;
import 'package:mdc_dart/src/mdc-drawer/index.dart' as drawer;
import 'package:mdc_dart/src/mdc-floating-label/index.dart' as floatingLabel;
import 'package:mdc_dart/src/mdc-form-field/index.dart' as formField;
import 'package:mdc_dart/src/mdc-icon-button/index.dart' as iconButton;
import 'package:mdc_dart/src/mdc-line-ripple/index.dart' as lineRipple;
import 'package:mdc_dart/src/mdc-linear-progress/index.dart' as linearProgress;
import 'package:mdc_dart/src/mdc-list/index.dart' as list;
import 'package:mdc_dart/src/mdc-menu-surface/index.dart' as menuSurface;
import 'package:mdc_dart/src/mdc-menu/index.dart' as menu;
import 'package:mdc_dart/src/mdc-notched-outline/index.dart' as notchedOutline;
import 'package:mdc_dart/src/mdc-radio/index.dart' as radio;
import 'package:mdc_dart/src/mdc-ripple/index.dart' as ripple;
import 'package:mdc_dart/src/mdc-select/index.dart' as select;
import 'package:mdc_dart/src/mdc-slider/index.dart' as slider;
import 'package:mdc_dart/src/mdc-snackbar/index.dart' as snackbar;
import 'package:mdc_dart/src/mdc-switch/index.dart' as switchControl;
import 'package:mdc_dart/src/mdc-tab-bar/index.dart' as tabBar;
import 'package:mdc_dart/src/mdc-tab-indicator/index.dart' as tabIndicator;
import 'package:mdc_dart/src/mdc-tab-scroller/index.dart' as tabScroller;
import 'package:mdc_dart/src/mdc-tab/index.dart' as tab;
import 'package:mdc_dart/src/mdc-textfield/index.dart' as textField;
import 'package:mdc_dart/src/mdc-top-app-bar/index.dart' as topAppBar;

// Register all components

@Error{autoInit.register('MDCCheckbox', checkbox.MDCCheckbox);
autoInit.register('MDCChip', chips.MDCChip);
autoInit.register('MDCChipSet', chips.MDCChipSet);
autoInit.register('MDCCircularProgress', circularProgress.MDCCircularProgress);
autoInit.register('MDCDataTable', dataTable.MDCDataTable);
autoInit.register('MDCDialog', dialog.MDCDialog);
autoInit.register('MDCDrawer', drawer.MDCDrawer);
autoInit.register('MDCFloatingLabel', floatingLabel.MDCFloatingLabel);
autoInit.register('MDCFormField', formField.MDCFormField);
autoInit.register('MDCIconButtonToggle', iconButton.MDCIconButtonToggle);
autoInit.register('MDCLineRipple', lineRipple.MDCLineRipple);
autoInit.register('MDCLinearProgress', linearProgress.MDCLinearProgress);
autoInit.register('MDCList', list.MDCList);
autoInit.register('MDCMenu', menu.MDCMenu);
autoInit.register('MDCMenuSurface', menuSurface.MDCMenuSurface);
autoInit.register('MDCNotchedOutline', notchedOutline.MDCNotchedOutline);
autoInit.register('MDCRadio', radio.MDCRadio);
autoInit.register('MDCRipple', ripple.MDCRipple);
autoInit.register('MDCSelect', select.MDCSelect);
autoInit.register('MDCSlider', slider.MDCSlider);
autoInit.register('MDCSnackbar', snackbar.MDCSnackbar);
autoInit.register('MDCSwitch', switchControl.MDCSwitch);
autoInit.register('MDCTabBar', tabBar.MDCTabBar);
autoInit.register('MDCTextField', textField.MDCTextField);
autoInit.register('MDCTopAppBar', topAppBar.MDCTopAppBar);

// Export all components.
export {
  autoInit,
  base,
  checkbox,
  chips,
  circularProgress,
  dataTable,
  dialog,
  dom,
  drawer,
  floatingLabel,
  formField,
  iconButton,
  lineRipple,
  linearProgress,
  list,
  menu,
  menuSurface,
  notchedOutline,
  radio,
  ripple,
  select,
  slider,
  snackbar,
  switchControl,
  tab,
  tabBar,
  tabIndicator,
  tabScroller,
  textField,
  topAppBar,
};
}