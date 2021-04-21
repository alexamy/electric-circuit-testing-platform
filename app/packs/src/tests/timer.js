function setupTimer() {
  const timer = $('#timer');
  const form = $('#answer-form');

  console.log('hi')
  form.on('submit', () => console.log('submitted'))

  function tick(intervalID) {
    const count = Number(timer.text());

    if(count <= 10) {
      timer.parent().addClass('timer-warning');
    }

    if(count === 0) {
      clearInterval(intervalID);
      form.trigger('submit');
    }
    else {
      timer.text(count - 1);
    }
  }

  if(timer.length) {
    const intervalID = setInterval(() => tick(intervalID), 1000);
  }
}

$(document).on('turbolinks:load', setupTimer);
