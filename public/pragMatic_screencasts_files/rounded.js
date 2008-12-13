/*
  rounded.js
  Copyright 2007, John W. Long
  Licensed under the MIT License.
*/

Element.addMethods({
  
  getPadding: function(element) {
    return [
      element.getStyle('padding-top'),
      element.getStyle('padding-right'),
      element.getStyle('padding-bottom'),
      element.getStyle('padding-left')
    ].join(' ');
  },
  
  roundCorners: function(element) {
    var padding = element.getPadding();
    element.style.padding = '0';
    element.update(
      '<div class="inner-1"><div class="inner-2"><div class="inner-3"><div class="inner-4"><div class="inner-5">' +
      '<div class="inner-6"><div class="inner-7"><div class="inner-8"><div class="inner-9"><div class="inner-10">' +
      element.innerHTML +
      '</div></div></div></div></div>' +
      '</div></div></div></div></div>'
    );
    element.down('div', 9).style.padding = padding;
  }
  
});

Event.observe(window, 'load', function() {
  $A(['div', 'fieldset']).each(function(tag) {
    $$(tag + '.rounded').each(function(element) {
      element.roundCorners();
    })
  })
});