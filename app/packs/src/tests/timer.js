function setupTimer() {
  const timer = $('#timer');
  const submit = $('input[type="submit"][name="commit"]');

  function tick(intervalID) {
    const count = Number(timer.text());

    if(count <= 10) {
      timer.parent().addClass('timer-warning');
    }

    if(count === 0) {
      clearInterval(intervalID);
      submit.trigger('click');
    }
    else {
      timer.text(count - 1);
    }
  }

  if(timer.length) {
    const intervalID = setInterval(() => tick(intervalID), 1000);
  }
}

$(setupTimer);
