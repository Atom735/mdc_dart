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

import 'package:mdc_dart/src/mdc-base/component.dart' show MDCComponent;
import 'package:mdc_dart/src/mdc-dom/events.dart' show applyPassive;
import 'package:mdc_dart/src/mdc-dom/ponyfill.dart' show matches;
import './adapter.dart' show MDCRippleAdapter;
import './foundation.dart' show MDCRippleFoundation;
import './types.dart' show MDCRippleAttachOpts, MDCRippleCapableSurface;
import './util.dart' as util;

@Error{export type MDCRippleFactory = (el: Element, foundation?: MDCRippleFoundation) => MDCRipple;

export class MDCRipple extends MDCComponent<MDCRippleFoundation> implements MDCRippleCapableSurface {
  static attachTo(root: Element, opts: MDCRippleAttachOpts = {isUnbounded: undefined}): MDCRipple {
    const ripple = new MDCRipple(root);
    // Only override unbounded behavior if option is explicitly specified
    if (opts.isUnbounded !== undefined) {
      ripple.unbounded = opts.isUnbounded;
    }
    return ripple;
  }

  static createAdapter(instance: MDCRippleCapableSurface): MDCRippleAdapter {
    return {
      addClass: (className) => instance.root.classList.add(className),
      browserSupportsCssVars: () => util.supportsCssVariables(window),
      computeBoundingRect: () => instance.root.getBoundingClientRect(),
      containsEventTarget: (target) => instance.root.contains(target as Node),
      deregisterDocumentInteractionHandler: (evtType, handler) =>
          document.documentElement.removeEventListener(
              evtType, handler, applyPassive()),
      deregisterInteractionHandler: (evtType, handler) =>
          (instance.root as HTMLElement)
              .removeEventListener(evtType, handler, applyPassive()),
      deregisterResizeHandler: (handler) =>
          window.removeEventListener('resize', handler),
      getWindowPageOffset: () =>
          ({x: window.pageXOffset, y: window.pageYOffset}),
      isSurfaceActive: () => matches(instance.root, ':active'),
      isSurfaceDisabled: () => Boolean(instance.disabled),
      isUnbounded: () => Boolean(instance.unbounded),
      registerDocumentInteractionHandler: (evtType, handler) =>
          document.documentElement.addEventListener(
              evtType, handler, applyPassive()),
      registerInteractionHandler: (evtType, handler) =>
          (instance.root as HTMLElement)
              .addEventListener(evtType, handler, applyPassive()),
      registerResizeHandler: (handler) =>
          window.addEventListener('resize', handler),
      removeClass: (className) => instance.root.classList.remove(className),
      updateCssVariable: (varName, value) =>
          (instance.root as HTMLElement).style.setProperty(varName, value),
    };
  }

  disabled = false;

  private unbounded_?: boolean;

  get unbounded(): boolean {
    return Boolean(this.unbounded_);
  }

  set unbounded(unbounded: boolean) {
    this.unbounded_ = Boolean(unbounded);
    this.setUnbounded_();
  }

  activate() {
    this.foundation.activate();
  }

  deactivate() {
    this.foundation.deactivate();
  }

  layout() {
    this.foundation.layout();
  }

  getDefaultFoundation() {
    return new MDCRippleFoundation(MDCRipple.createAdapter(this));
  }

  initialSyncWithDOM() {
    const root = this.root as HTMLElement;
    this.unbounded = 'mdcRippleIsUnbounded' in root.dataset;
  }

  /**
   * Closure Compiler throws an access control error when directly accessing a
   * protected or private property inside a getter/setter, like unbounded above.
   * By accessing the protected property inside a method, we solve that problem.
   * That's why this function exists.
   */
  private setUnbounded_() {
    this.foundation.setUnbounded(Boolean(this.unbounded_));
  }
}
}