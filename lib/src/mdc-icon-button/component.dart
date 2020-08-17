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

import 'package:mdc_dart/src/mdc-base/component.dart' show MDCComponent;
import 'package:mdc_dart/src/mdc-base/types.dart' show SpecificEventListener;
import 'package:mdc_dart/src/mdc-ripple/component.dart' show MDCRipple;
import './adapter.dart' show MDCIconButtonToggleAdapter;
import './foundation.dart' show MDCIconButtonToggleFoundation;
import './types.dart' show MDCIconButtonToggleEventDetail;

@Error{const {strings} = MDCIconButtonToggleFoundation;

export class MDCIconButtonToggle extends MDCComponent<MDCIconButtonToggleFoundation> {
  static attachTo(root: HTMLElement) {
    return new MDCIconButtonToggle(root);
  }

  private readonly rippleComponent: MDCRipple = this.createRipple();
  private handleClick!:
      SpecificEventListener<'click'>;  // assigned in initialSyncWithDOM()

  initialSyncWithDOM() {
    this.handleClick = () => {
      this.foundation.handleClick();
    };
    this.listen('click', this.handleClick);
  }

  destroy() {
    this.unlisten('click', this.handleClick);
    this.ripple.destroy();
    super.destroy();
  }

  getDefaultFoundation() {
    // DO NOT INLINE this variable. For backward compatibility, foundations take a Partial<MDCFooAdapter>.
    // To ensure we don't accidentally omit any methods, we need a separate, strongly typed adapter variable.
    const adapter: MDCIconButtonToggleAdapter = {
      addClass: (className) => this.root.classList.add(className),
      hasClass: (className) => this.root.classList.contains(className),
      notifyChange: (evtData) => {
        this.emit<MDCIconButtonToggleEventDetail>(
            strings.CHANGE_EVENT, evtData);
      },
      removeClass: (className) => this.root.classList.remove(className),
      getAttr: (attrName) => this.root.getAttribute(attrName),
      setAttr: (attrName, attrValue) =>
          this.root.setAttribute(attrName, attrValue),
    };
    return new MDCIconButtonToggleFoundation(adapter);
  }

  get ripple(): MDCRipple {
    return this.rippleComponent;
  }

  get on(): boolean {
    return this.foundation.isOn();
  }

  set on(isOn: boolean) {
    this.foundation.toggle(isOn);
  }

  private createRipple(): MDCRipple {
    const ripple = new MDCRipple(this.root);
    ripple.unbounded = true;
    return ripple;
  }
}
}