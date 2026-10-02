(() => {
  const slides = Array.from(document.querySelectorAll('.slide'));
  const previous = document.getElementById('prev-button');
  const next = document.getElementById('next-button');
  const status = document.getElementById('slide-status');
  const progress = document.getElementById('progress-bar');
  let current = 0;

  function indexFromHash() {
    const match = window.location.hash.match(/^#slide-(\d+)$/);
    const number = match ? Number(match[1]) : 1;
    return Math.max(0, Math.min(slides.length - 1, number - 1));
  }

  function show(index, updateHash = true) {
    current = Math.max(0, Math.min(slides.length - 1, index));
    slides.forEach((slide, slideIndex) => {
      const active = slideIndex === current;
      slide.classList.toggle('active', active);
      slide.setAttribute('aria-hidden', String(!active));
      if (active) slide.scrollTop = 0;
    });
    previous.disabled = current === 0;
    next.disabled = current === slides.length - 1;
    status.textContent = `${current + 1} / ${slides.length}　${slides[current].dataset.title}`;
    progress.style.width = `${((current + 1) / slides.length) * 100}%`;
    if (updateHash) history.replaceState(null, '', `#slide-${current + 1}`);
  }

  previous.addEventListener('click', () => show(current - 1));
  next.addEventListener('click', () => show(current + 1));
  window.addEventListener('hashchange', () => show(indexFromHash(), false));
  window.addEventListener('keydown', (event) => {
    if (event.altKey || event.ctrlKey || event.metaKey) return;
    if (event.key === 'ArrowRight' || event.key === 'PageDown') { event.preventDefault(); show(current + 1); }
    if (event.key === 'ArrowLeft' || event.key === 'PageUp') { event.preventDefault(); show(current - 1); }
    if (event.key === 'Home') { event.preventDefault(); show(0); }
    if (event.key === 'End') { event.preventDefault(); show(slides.length - 1); }
  });
  show(indexFromHash(), false);
})();
