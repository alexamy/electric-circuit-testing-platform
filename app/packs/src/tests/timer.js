$(function() {
  const timer = $('#timer');
  const submit = $('input[type="submit"][name="commit"]');

  function tick() {
    const count = Number(timer.text());

    if(count <= 10) {
      timer.parent().addClass('timer-warning');
    }

    if(count === 0) {
      submit.trigger('click');
    }
    else {
      timer.text(count - 1);
    }
  }

  if(timer.length) {
    const interalID = setInterval(tick, 1000);
  }
});
