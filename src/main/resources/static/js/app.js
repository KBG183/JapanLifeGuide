(() => {
  const scrollKey = 'japan-life-guide:checklist-scroll';

  document.querySelectorAll('[data-confirm]').forEach((button) => {
    button.addEventListener('click', (event) => {
      if (!window.confirm(button.dataset.confirm)) event.preventDefault();
    });
  });

  document.addEventListener('submit', (event) => {
    if (event.target.matches('.check-row form')) {
      sessionStorage.setItem(scrollKey, String(window.scrollY));
    }
  });

  const savedScrollY = sessionStorage.getItem(scrollKey);
  if (savedScrollY !== null && document.querySelector('.check-row')) {
    sessionStorage.removeItem(scrollKey);
    requestAnimationFrame(() => {
      window.scrollTo(0, Number.parseInt(savedScrollY, 10) || 0);
    });
  }

  const calendar = document.querySelector('.calendar-grid');
  const eventDate = document.querySelector('#event-date');
  if (calendar && eventDate) {
    calendar.addEventListener('click', (event) => {
      const day = event.target.closest('.calendar-day');
      if (!day || day.classList.contains('outside')) return;
      event.preventDefault();
      calendar.querySelectorAll('.calendar-cell.is-open').forEach((cell) => cell.classList.remove('is-open'));
      day.parentElement.classList.add('is-open');
      eventDate.value = day.dataset.calendarDate;
    });
    document.addEventListener('click', (event) => {
      if (!event.target.closest('.calendar-cell')) {
        calendar.querySelectorAll('.calendar-cell.is-open').forEach((cell) => cell.classList.remove('is-open'));
      }
    });
  }

  const loginId = document.querySelector('#loginId');
  const loginIdCheck = document.querySelector('#check-login-id');
  const loginIdChecked = document.querySelector('#loginIdChecked');
  const loginIdStatus = document.querySelector('#login-id-status');
  if (loginId && loginIdCheck && loginIdChecked && loginIdStatus) {
    const setStatus = (message, type) => {
      loginIdStatus.textContent = message;
      loginIdStatus.className = `form-status${type ? ` is-${type}` : ''}`;
    };
    const resetCheck = () => {
      loginIdChecked.value = 'false';
      setStatus('', '');
    };
    loginId.addEventListener('input', resetCheck);
    loginIdCheck.addEventListener('click', async () => {
      const value = loginId.value.trim();
      if (!/^[A-Za-z0-9._-]{4,60}$/.test(value)) {
        loginIdChecked.value = 'false';
        setStatus(loginIdCheck.dataset.invalid, 'error');
        return;
      }
      loginIdCheck.disabled = true;
      setStatus(loginIdCheck.dataset.checking, '');
      try {
        const url = `${loginIdCheck.dataset.checkUrl}?loginId=${encodeURIComponent(value)}`;
        const response = await fetch(url, { headers: { Accept: 'application/json' } });
        const result = await response.json();
        if (result.available === true) {
          loginIdChecked.value = 'true';
          setStatus(loginIdCheck.dataset.available, 'success');
        } else {
          loginIdChecked.value = 'false';
          setStatus(result.reason === 'invalid' ? loginIdCheck.dataset.invalid : loginIdCheck.dataset.duplicate, 'error');
        }
      } catch (error) {
        loginIdChecked.value = 'false';
        setStatus(loginIdCheck.dataset.error, 'error');
      } finally {
        loginIdCheck.disabled = false;
      }
    });
    loginId.form?.addEventListener('submit', (event) => {
      if (loginIdChecked.value !== 'true') {
        event.preventDefault();
        setStatus(loginIdCheck.dataset.required, 'error');
        loginId.focus();
      }
    });
  }

  const registerForm = document.querySelector('form[data-email-invalid]');
  const email = document.querySelector('#email');
  const emailCheck = document.querySelector('#check-email');
  const emailStatus = document.querySelector('#email-status');
  const sendEmailCode = document.querySelector('#send-email-code');
  const verifyEmailCode = document.querySelector('#verify-email-code');
  const emailCode = document.querySelector('#email-code');
  const emailCodeStatus = document.querySelector('#email-code-status');
  let emailChecked = false;
  let emailVerified = document.querySelector('#emailVerified')?.value === 'true';
  const csrf = registerForm?.querySelector('input[name="_csrf"]');
  const setFormStatus = (element, message, type) => {
    if (!element) return;
    element.textContent = message || '';
    element.className = `form-status${type ? ` is-${type}` : ''}`;
  };
  const startResendCooldown = (button, seconds = 60) => {
    button.disabled = true;
    window.setTimeout(() => { button.disabled = false; }, seconds * 1000);
  };
  const emailValue = () => email?.value.trim().toLowerCase() || '';
  const validEmail = (value) => value.length <= 254 && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
  const postForm = async (url, values) => {
    const body = new URLSearchParams(values);
    if (csrf) body.set(csrf.name, csrf.value);
    const response = await fetch(url, { method: 'POST', headers: { Accept: 'application/json', 'Content-Type': 'application/x-www-form-urlencoded' }, body });
    return response.json();
  };
  const registerError = registerForm?.querySelector('.form-error');
  if (registerError) registerError.scrollIntoView({ behavior: 'auto', block: 'center' });
  if (emailVerified && emailCodeStatus && verifyEmailCode) {
    setFormStatus(emailCodeStatus, verifyEmailCode.dataset.success, 'success');
  }
  if (email && emailCheck && emailStatus) {
    const resetEmail = () => { emailChecked = false; emailVerified = false; setFormStatus(emailStatus, '', ''); setFormStatus(emailCodeStatus, '', ''); };
    email.addEventListener('input', resetEmail);
    emailCheck.addEventListener('click', async () => {
      const value = emailValue();
      if (!validEmail(value)) { resetEmail(); setFormStatus(emailStatus, registerForm.dataset.emailInvalid, 'error'); return; }
      try {
        const response = await fetch(`${emailCheck.dataset.checkUrl}?email=${encodeURIComponent(value)}`, { headers: { Accept: 'application/json' } });
        const result = await response.json();
        emailChecked = result.available === true;
        setFormStatus(emailStatus, emailChecked ? emailCheck.dataset.available : emailCheck.dataset.duplicate, emailChecked ? 'success' : 'error');
      } catch (error) { emailChecked = false; setFormStatus(emailStatus, registerForm.dataset.emailInvalid, 'error'); }
    });
  }
  if (sendEmailCode && email && emailCodeStatus) {
    sendEmailCode.addEventListener('click', async () => {
      const value = emailValue();
      if (!emailChecked || !validEmail(value)) { setFormStatus(emailCodeStatus, registerForm.dataset.emailInvalid, 'error'); return; }
      sendEmailCode.disabled = true;
      try {
        const result = await postForm(sendEmailCode.dataset.sendUrl, { email: value });
        if (result.sent) {
          setFormStatus(emailCodeStatus, sendEmailCode.dataset.sent, 'success');
          startResendCooldown(sendEmailCode);
        } else {
          setFormStatus(emailCodeStatus, result.reason === 'cooldown' ? sendEmailCode.dataset.cooldown : sendEmailCode.dataset.error, 'error');
          if (result.reason === 'cooldown') startResendCooldown(sendEmailCode);
          else sendEmailCode.disabled = false;
        }
      } catch (error) { sendEmailCode.disabled = false; setFormStatus(emailCodeStatus, sendEmailCode.dataset.error, 'error'); }
    });
  }
  if (verifyEmailCode && email && emailCode && emailCodeStatus) {
    verifyEmailCode.addEventListener('click', async () => {
      verifyEmailCode.disabled = true;
      try {
        const result = await postForm(verifyEmailCode.dataset.verifyUrl, { email: emailValue(), code: emailCode.value.trim() });
        emailVerified = result.verified === true;
        setFormStatus(emailCodeStatus, emailVerified ? verifyEmailCode.dataset.success : verifyEmailCode.dataset.error, emailVerified ? 'success' : 'error');
        if (!emailVerified) verifyEmailCode.disabled = false;
      } catch (error) { emailVerified = false; verifyEmailCode.disabled = false; setFormStatus(emailCodeStatus, verifyEmailCode.dataset.error, 'error'); }
    });
  }
  if (registerForm) {
    registerForm.addEventListener('submit', (event) => {
      if (!emailVerified) { event.preventDefault(); setFormStatus(emailCodeStatus, verifyEmailCode?.dataset.required, 'error'); email?.focus(); }
    });
  }

  const resetForm = document.querySelector('#password-reset-form');
  const resetLoginId = document.querySelector('#reset-login-id');
  const resetEmail = document.querySelector('#reset-email');
  const sendResetCode = document.querySelector('#send-reset-code');
  const verifyResetCode = document.querySelector('#verify-reset-code');
  const resetCode = document.querySelector('#reset-code');
  const resetStatus = document.querySelector('#password-reset-status');
  let resetVerified = false;
  if (resetForm && resetLoginId && resetEmail && sendResetCode && verifyResetCode && resetCode && resetStatus) {
    const resetCsrf = resetForm.querySelector('input[name="_csrf"]');
    const resetPost = async (url, values) => {
      const body = new URLSearchParams(values);
      if (resetCsrf) body.set(resetCsrf.name, resetCsrf.value);
      const response = await fetch(url, { method: 'POST', headers: { Accept: 'application/json', 'Content-Type': 'application/x-www-form-urlencoded' }, body });
      return response.json();
    };
    const resetValues = () => ({ loginId: resetLoginId.value.trim(), email: resetEmail.value.trim().toLowerCase() });
    const clearReset = () => { resetVerified = false; setFormStatus(resetStatus, '', ''); };
    resetLoginId.addEventListener('input', clearReset);
    resetEmail.addEventListener('input', clearReset);
    sendResetCode.addEventListener('click', async () => {
      sendResetCode.disabled = true;
      try {
        const result = await resetPost(sendResetCode.dataset.sendUrl, resetValues());
        if (result.sent) {
          setFormStatus(resetStatus, sendResetCode.dataset.sent, 'success');
          startResendCooldown(sendResetCode);
        } else {
          setFormStatus(resetStatus, result.reason === 'cooldown' ? sendResetCode.dataset.cooldown : sendResetCode.dataset.error, 'error');
          if (result.reason === 'cooldown') startResendCooldown(sendResetCode);
          else sendResetCode.disabled = false;
        }
      } catch (error) { sendResetCode.disabled = false; setFormStatus(resetStatus, sendResetCode.dataset.error, 'error'); }
    });
    verifyResetCode.addEventListener('click', async () => {
      verifyResetCode.disabled = true;
      try {
        const result = await resetPost(verifyResetCode.dataset.verifyUrl, { ...resetValues(), code: resetCode.value.trim() });
        resetVerified = result.verified === true;
        setFormStatus(resetStatus, resetVerified ? verifyResetCode.dataset.success : verifyResetCode.dataset.error, resetVerified ? 'success' : 'error');
        if (!resetVerified) verifyResetCode.disabled = false;
      } catch (error) { resetVerified = false; verifyResetCode.disabled = false; setFormStatus(resetStatus, verifyResetCode.dataset.error, 'error'); }
    });
    resetForm.addEventListener('submit', (event) => {
      if (!resetVerified) { event.preventDefault(); setFormStatus(resetStatus, verifyResetCode.dataset.required, 'error'); }
    });
  }

  const findLoginIdForm = document.querySelector('#find-login-id-form');
  const findLoginIdEmail = document.querySelector('#find-login-id-email');
  const sendFindLoginIdCode = document.querySelector('#send-find-login-id-code');
  const verifyFindLoginIdCode = document.querySelector('#verify-find-login-id-code');
  const findLoginIdCode = document.querySelector('#find-login-id-code');
  const findLoginIdStatus = document.querySelector('#find-login-id-status');
  const foundLoginId = document.querySelector('#found-login-id');
  if (findLoginIdForm && findLoginIdEmail && sendFindLoginIdCode && verifyFindLoginIdCode && findLoginIdCode && findLoginIdStatus && foundLoginId) {
    const findCsrf = findLoginIdForm.querySelector('input[name="_csrf"]');
    const findPost = async (url, values) => {
      const body = new URLSearchParams(values);
      if (findCsrf) body.set(findCsrf.name, findCsrf.value);
      const response = await fetch(url, { method: 'POST', headers: { Accept: 'application/json', 'Content-Type': 'application/x-www-form-urlencoded' }, body });
      return response.json();
    };
    const findEmail = () => findLoginIdEmail.value.trim().toLowerCase();
    sendFindLoginIdCode.addEventListener('click', async () => {
      sendFindLoginIdCode.disabled = true;
      try {
        const result = await findPost(sendFindLoginIdCode.dataset.sendUrl, { email: findEmail() });
        setFormStatus(findLoginIdStatus, result.sent ? sendFindLoginIdCode.dataset.sent : (result.reason === 'cooldown' ? sendFindLoginIdCode.dataset.cooldown : sendFindLoginIdCode.dataset.error), result.sent ? 'success' : 'error');
        if (result.sent || result.reason === 'cooldown') startResendCooldown(sendFindLoginIdCode);
        else sendFindLoginIdCode.disabled = false;
      } catch (error) { sendFindLoginIdCode.disabled = false; setFormStatus(findLoginIdStatus, sendFindLoginIdCode.dataset.error, 'error'); }
    });
    verifyFindLoginIdCode.addEventListener('click', async () => {
      verifyFindLoginIdCode.disabled = true;
      try {
        const result = await findPost(verifyFindLoginIdCode.dataset.verifyUrl, { email: findEmail(), code: findLoginIdCode.value.trim() });
        if (result.verified && result.loginId) {
          setFormStatus(findLoginIdStatus, verifyFindLoginIdCode.dataset.success, 'success');
          foundLoginId.textContent = verifyFindLoginIdCode.dataset.result.replace('{0}', result.loginId);
          foundLoginId.hidden = false;
        } else {
          setFormStatus(findLoginIdStatus, verifyFindLoginIdCode.dataset.error, 'error');
          foundLoginId.hidden = true;
          verifyFindLoginIdCode.disabled = false;
        }
      } catch (error) { verifyFindLoginIdCode.disabled = false; setFormStatus(findLoginIdStatus, verifyFindLoginIdCode.dataset.error, 'error'); foundLoginId.hidden = true; }
    });
  }

  const likeButton = document.querySelector('[data-like-button]');
  if (likeButton) {
    likeButton.addEventListener('click', async () => {
      if (likeButton.disabled) return;
      likeButton.disabled = true;
      const body = new URLSearchParams();
      body.set(likeButton.dataset.csrfName, likeButton.dataset.csrfToken);
      try {
        const response = await fetch(likeButton.dataset.likeUrl, { method: 'POST', headers: { Accept: 'application/json', 'Content-Type': 'application/x-www-form-urlencoded' }, body });
        if (!response.ok) throw new Error('like request failed');
        const result = await response.json();
        const count = likeButton.querySelector('[data-like-count]');
        if (count) count.textContent = result.likeCount;
        likeButton.classList.toggle('is-liked', result.liked === true);
        likeButton.setAttribute('aria-pressed', result.liked === true ? 'true' : 'false');
      } catch (error) {
        window.alert(likeButton.dataset.error);
      } finally {
        likeButton.disabled = false;
      }
    });
  }

  const bookmarkButton = document.querySelector('[data-bookmark-button]');
  if (bookmarkButton) {
    bookmarkButton.addEventListener('click', async () => {
      if (bookmarkButton.disabled) return;
      bookmarkButton.disabled = true;
      const body = new URLSearchParams();
      body.set(bookmarkButton.dataset.csrfName, bookmarkButton.dataset.csrfToken);
      try {
        const response = await fetch(bookmarkButton.dataset.bookmarkUrl, { method: 'POST', headers: { Accept: 'application/json', 'Content-Type': 'application/x-www-form-urlencoded' }, body });
        if (!response.ok) throw new Error('bookmark request failed');
        const result = await response.json();
        bookmarkButton.classList.toggle('is-bookmarked', result.bookmarked === true);
        bookmarkButton.setAttribute('aria-pressed', result.bookmarked === true ? 'true' : 'false');
      } finally {
        bookmarkButton.disabled = false;
      }
    });
  }
})();
