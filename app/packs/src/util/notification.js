import $ from 'cash-dom';
import { fadeOut } from './animations';

$(function() {
  $('.notification').each((_, e) => {
    const notification = $(e);

    const timerID = setTimeout(() => {
      notification.off('click');
      fadeOut(notification);
    }, 5000);

    notification
      .find('.notification__close')
      .one('click', () => {
        clearTimeout(timerID);
        fadeOut(notification);
      });
  });
});
