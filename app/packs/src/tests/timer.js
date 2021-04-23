function secToPart(seconds) {
  return seconds.toString().padStart(2, '0');
}

function secToMS(seconds) {
  if(seconds <= 0) return '00:00'

  const minutes = Math.floor(seconds / 60);
  const secondsLeft = seconds - (minutes * 60);

  return `${secToPart(minutes)}:${secToPart(secondsLeft)}`;
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
        timer.text(secToMS(count));
      }
    }

    let count = Number(timer.data('count'));
    const submit = $('input[type="submit"][name="commit"]');
    const intervalID = setInterval(() => tick(intervalID), 1000);
  }
}

$(setupTimer);
