import $ from 'cash-dom';
import { createPopper } from '@popperjs/core';

$(function() {
  const elements = $('[data-tooltip-image]');

  elements.each((_, e) => {
    const element = $(e);
    const { hoverClass, tooltipImage } = element.data();

    const image = $('<img/>').attr({ src: tooltipImage });
    const tooltip = $('<div/>').addClass('tooltip scheme').attr({ role: 'tooltip' }).append(image).appendTo(document.body);
    const popperInstance = createPopper(element[0], tooltip[0], { placement: 'right' });

    element.on('mouseenter focus', () => {
      element.addClass(hoverClass);
      tooltip.attr({ 'data-show': '' });
      popperInstance.update();
    });

    element.on('mouseleave blur', () => {
      element.removeClass(hoverClass);
      tooltip.removeAttr('data-show');
    });
  });
});
