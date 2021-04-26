import anime from 'animejs';

function fadeOut(target, opts = {}) {
  return anime({
    targets: target[0],
    ...opts,
    opacity: 0,
    duration: 300,
    easing: 'linear',
    complete: () => target.remove(),
  });
}

export { fadeOut };
