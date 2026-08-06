/**
 * The behaviour of this plugin's own field type
 *
 * Registered through `Dpress.addInit`, so it runs on load and again after every partial
 * navigation - an admin screen arrives without a page load, and a listener bound to
 * `DOMContentLoaded` would never fire a second time.
 */
(function (global) {
    'use strict';

    if (!global.Dpress || !global.Dpress.addInit) {
        return; // not in the admin
    }

    global.Dpress.addInit(function (root) {
        root.querySelectorAll('[data-reading-time]').forEach(function (field) {
            if (field.dataset.readingTimeBound) {
                return;
            }
            field.dataset.readingTimeBound = '1';
            var clear = field.querySelector('[data-reading-time-clear]');
            var input = field.querySelector('[data-reading-time-input]');
            if (clear && input) {
                clear.addEventListener('click', function () {
                    input.value = '';   // empty means "work it out from the text"
                    input.focus();
                });
            }
        });
    });
}(window));
