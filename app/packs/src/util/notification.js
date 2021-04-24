$(function() {
  $('.notification').each((_, e) => {
    const notification = $(e);
    const timerID = setTimeout(() => notification.remove(), 5000);

    notification
      .find('.notification__close')
      .one('click', () => {
        clearTimeout(timerID);
        notification.remove();
      });
  });
});
