$(function() {
  $('.notification').each((_, e) => {
    const notification = $(e);

    const timerID = setTimeout(() => {
      notification.off('click');
      anim.fadeOut(notification);
    }, 5000);

    notification
      .find('.notification__close')
      .one('click', () => {
        clearTimeout(timerID);
        anim.fadeOut(notification);
      });
  });
});
