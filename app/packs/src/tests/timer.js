import $ from 'cash-dom';

function secondsToMinSec(seconds) {
  if(seconds <= 0) return '00:00'

  const part = count => count.toString().padStart(2, '0');

  const minutes = Math.floor(seconds / 60);
  const secondsLeft = seconds - minutes * 60;

  return `${part(minutes)}:${part(secondsLeft)}`;
}

function setupTimer() {
  const timer = $('#timer');

  if(timer.length) {
    function tick(intervalID) {
      if(count <= 10) {
        timer.parent().addClass('timer-warning');
      }

      if(count === 0) {
        clearInterval(intervalID);
        submit.trigger('click');
      }
      else {
        count -= 1;
        timer.text(secondsToMinSec(count));
      }
    }

    let count = Number(timer.data('count'));
    const submit = $('input[type="submit"][name="commit"]');
    const intervalID = setInterval(() => tick(intervalID), 1000);
  }
}

$(setupTimer);
