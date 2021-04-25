import anime from 'animejs';

window.anim = {
  fadeOut: (target, opts = {}) => anime({
    targets: target[0],
    ...opts,
    opacity: 0,
    duration: 300,
    easing: 'linear',
    complete: () => target.remove(),
  })
};
