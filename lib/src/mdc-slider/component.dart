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

import 'package:mdc_dart/src/mdc-base/component.dart' show MDCComponent;
import 'package:mdc_dart/src/mdc-dom/events.dart' show applyPassive;
import './adapter.dart' show MDCSliderAdapter;
import './constants.dart' show strings;
import './foundation.dart' show MDCSliderFoundation;

class MDCSlider
    implements MDCComponent<MDCSliderFoundation> {
  @Error{static attachTo(root: Element) {
    return new MDCSlider(root);
  }

  private thumbContainer_!: HTMLElement;        // assigned in initialize()
  private track_!: HTMLElement;                 // assigned in initialize()
  private pinValueMarker_!: HTMLElement;        // assigned in initialize()
  private trackMarkerContainer_!: HTMLElement;  // assigned in initialize()

  get value(): number {
    return this.foundation.getValue();
  }

  set value(value: number) {
    this.foundation.setValue(value);
  }

  get min(): number {
    return this.foundation.getMin();
  }

  set min(min: number) {
    this.foundation.setMin(min);
  }

  get max(): number {
    return this.foundation.getMax();
  }

  set max(max: number) {
    this.foundation.setMax(max);
  }

  get step(): number {
    return this.foundation.getStep();
  }

  set step(step: number) {
    this.foundation.setStep(step);
  }

  get disabled(): boolean {
    return this.foundation.isDisabled();
  }

  set disabled(disabled: boolean) {
    this.foundation.setDisabled(disabled);
  }

  initialize() {
    this.thumbContainer_ =
        this.root.querySelector<HTMLElement>(strings.THUMB_CONTAINER_SELECTOR)!;
    this.track_ = this.root.querySelector<HTMLElement>(strings.TRACK_SELECTOR)!;
    this.pinValueMarker_ = this.root.querySelector<HTMLElement>(
        strings.PIN_VALUE_MARKER_SELECTOR)!;
    this.trackMarkerContainer_ = this.root.querySelector<HTMLElement>(
        strings.TRACK_MARKER_CONTAINER_SELECTOR)!;
  }

  getDefaultFoundation() {
    // DO NOT INLINE this variable. For backward compatibility, foundations take
    // a Partial<MDCFooAdapter>. To ensure we don't accidentally omit any
    // methods, we need a separate, strongly typed adapter variable.
    // tslint:disable:object-literal-sort-keys Methods should be in the same
    // order as the adapter interface.
    const adapter: MDCSliderAdapter = {
      hasClass: (className) => this.root.classList.contains(className),
      addClass: (className) => this.root.classList.add(className),
      removeClass: (className) => this.root.classList.remove(className),
      getAttribute: (name) => this.root.getAttribute(name),
      setAttribute: (name, value) => this.root.setAttribute(name, value),
      removeAttribute: (name) => this.root.removeAttribute(name),
      computeBoundingRect: () => this.root.getBoundingClientRect(),
      getTabIndex: () => (this.root as HTMLElement).tabIndex,
      registerInteractionHandler: (evtType, handler) =>
          this.listen(evtType, handler, applyPassive()),
      deregisterInteractionHandler: (evtType, handler) =>
          this.unlisten(evtType, handler, applyPassive()),
      registerThumbContainerInteractionHandler: (evtType, handler) => {
        this.thumbContainer_.addEventListener(evtType, handler, applyPassive());
      },
      deregisterThumbContainerInteractionHandler: (evtType, handler) => {
        this.thumbContainer_.removeEventListener(
            evtType, handler, applyPassive());
      },
      registerBodyInteractionHandler: (evtType, handler) =>
          document.body.addEventListener(evtType, handler),
      deregisterBodyInteractionHandler: (evtType, handler) =>
          document.body.removeEventListener(evtType, handler),
      registerResizeHandler: (handler) =>
          window.addEventListener('resize', handler),
      deregisterResizeHandler: (handler) =>
          window.removeEventListener('resize', handler),
      notifyInput: () => this.emit<MDCSlider>(
          strings.INPUT_EVENT,
          this),  // TODO(acdvorak): Create detail interface
      notifyChange: () => this.emit<MDCSlider>(
          strings.CHANGE_EVENT,
          this),  // TODO(acdvorak): Create detail interface
      setThumbContainerStyleProperty: (propertyName, value) => {
        this.thumbContainer_.style.setProperty(propertyName, value);
      },
      setTrackStyleProperty: (propertyName, value) =>
          this.track_.style.setProperty(propertyName, value),
      setMarkerValue: (value) => this.pinValueMarker_.innerText =
          value.toLocaleString(),
      setTrackMarkers: (step, max, min) => {
        const stepStr = step.toLocaleString();
        const maxStr = max.toLocaleString();
        const minStr = min.toLocaleString();
        // keep calculation in css for better rounding/subpixel behavior
        const markerAmount = `((${maxStr} - ${minStr}) / ${stepStr})`;
        const markerWidth = `2px`;
        const markerBkgdImage = `linear-gradient(to right, currentColor ${
            markerWidth}, transparent 0)`;
        const markerBkgdLayout = `0 center / calc((100% - ${markerWidth}) / ${
            markerAmount}) 100% repeat-x`;
        const markerBkgdShorthand = `${markerBkgdImage} ${markerBkgdLayout}`;
        this.trackMarkerContainer_.style.setProperty(
            'background', markerBkgdShorthand);
      },
      isRTL: () => getComputedStyle(this.root).direction === 'rtl',
    };
    // tslint:enable:object-literal-sort-keys
    return new MDCSliderFoundation(adapter);
  }

  initialSyncWithDOM() {
    const origValueNow = this.parseFloat_(
        this.root.getAttribute(strings.ARIA_VALUENOW), this.value);
    const min = this.parseFloat_(
        this.root.getAttribute(strings.ARIA_VALUEMIN), this.min);
    const max = this.parseFloat_(
        this.root.getAttribute(strings.ARIA_VALUEMAX), this.max);

    // min and max need to be set in the right order to avoid throwing an error
    // when the new min is greater than the default max.
    if (min >= this.max) {
      this.max = max;
      this.min = min;
    } else {
      this.min = min;
      this.max = max;
    }

    this.step = this.parseFloat_(
        this.root.getAttribute(strings.STEP_DATA_ATTR), this.step);
    this.value = origValueNow;
    this.disabled =
        (this.root.hasAttribute(strings.ARIA_DISABLED) &&
         this.root.getAttribute(strings.ARIA_DISABLED) !== 'false');
    this.foundation.setupTrackMarker();
  }

  layout() {
    this.foundation.layout();
  }

  stepUp(amount = (this.step || 1)) {
    this.value += amount;
  }

  stepDown(amount = (this.step || 1)) {
    this.value -= amount;
  }

  private parseFloat_(str: string|null, defaultValue: number) {
    const num = parseFloat(str!);  // tslint:disable-line:ban
    const isNumeric = typeof num === 'number' && isFinite(num);
    return isNumeric ? num : defaultValue;
  }
}
}