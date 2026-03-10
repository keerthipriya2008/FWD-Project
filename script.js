(function() {
  const STORAGE_KEYS = { APPOINTMENTS: 'clinical_appts', LOGGED_IN: 'clinical_logged_in', THEME: 'clinical_theme', ROLE: 'clinical_role' };
  class Entity { constructor(id) { this.id = id; } }
  class Appointment extends Entity {
    constructor(id, patientName, doctor, date, time, reason, status) {
      super(id); this.patientName = patientName; this.doctor = doctor; this.date = date; this.time = time; this.reason = reason||''; this.status = status||'Scheduled';
    }
  }
  let doctorsList = [], allAppointments = [], filteredAppointments = [], chartInstance = null, dragSrcElement = null;
  function getAppointments() { return Promise.resolve(JSON.parse(localStorage.getItem(STORAGE_KEYS.APPOINTMENTS) || '[]')); }
  function saveAppointments(apps) { localStorage.setItem(STORAGE_KEYS.APPOINTMENTS, JSON.stringify(apps)); return Promise.resolve(apps); }
  async function fetchDoctors() {
    const select = document.getElementById('doctorSelect');
    const loadingSpan = document.getElementById('doctorLoading');
    loadingSpan.classList.remove('hidden');
    try {
      const res = await fetch('https://jsonplaceholder.typicode.com/users');
      if (!res.ok) throw new Error();
      const users = await res.json();
      doctorsList = users.map(u => ({ id: u.id, name: u.name }));
    } catch {
      doctorsList = [{ id:1, name:'Dr. Smith' }, { id:2, name:'Dr. Johnson' }, { id:3, name:'Dr. Williams' }];
    } finally {
      select.innerHTML = '<option value="">-- select doctor --</option>';
      doctorsList.forEach(d => { let opt = document.createElement('option'); opt.value = d.name; opt.textContent = d.name; select.appendChild(opt); });
      const filterDoc = document.getElementById('filterDoctor');
      filterDoc.innerHTML = '<option value="">All</option>';
      doctorsList.forEach(d => { let opt = document.createElement('option'); opt.value = d.name; opt.textContent = d.name; filterDoc.appendChild(opt); });
      loadingSpan.classList.add('hidden');
    }
  }
  async function renderAppointments() {
    const container = document.getElementById('appointmentsList');
    container.innerHTML = '<div class="spinner"></div>';
    try {
      allAppointments = await getAppointments();
      applyFilterAndRender();
      updateStatsAndChart(allAppointments);
    } catch (e) { container.innerHTML = `<p class="error-message">${e.message}</p>`; }
  }
  function applyFilterAndRender() {
    const doctor = document.getElementById('filterDoctor').value;
    const status = document.getElementById('filterStatus').value;
    const from = document.getElementById('filterDateFrom').value;
    const to = document.getElementById('filterDateTo').value;
    filteredAppointments = allAppointments.filter(a => {
      if (doctor && a.doctor !== doctor) return false;
      if (status && a.status !== status) return false;
      if (from && a.date < from) return false;
      if (to && a.date > to) return false;
      return true;
    });
    renderList(filteredAppointments);
  }
  function renderList(apps) {
    const container = document.getElementById('appointmentsList');
    if (!apps.length) { container.innerHTML = '<p class="text-muted">📭 No appointments match.</p>'; return; }
    container.innerHTML = apps.map(a => `<div class="appointment-card" draggable="true" data-id="${a.id}" role="listitem">
      <div class="flex-between"><strong class="patient-name" style="cursor:pointer; color:var(--primary);" data-patient="${a.patientName}">${a.patientName}</strong> <span class="status status-${a.status.toLowerCase()}">${a.status}</span></div>
      <p><i class="bi bi-person-badge"></i> ${a.doctor}</p>
      <p><i class="bi bi-calendar-event"></i> ${a.date} @ ${a.time}</p>
      ${a.reason ? `<p><i class="bi bi-chat"></i> ${a.reason.substring(0,30)}</p>` : ''}
      <div class="flex-between mt-2">
        <button class="btn btn-secondary btn-sm complete-btn" data-id="${a.id}" ${a.status==='Completed'?'disabled':''}><i class="bi bi-check-lg"></i> Complete</button>
        <button class="btn btn-secondary btn-sm cancel-btn" data-id="${a.id}" ${a.status==='Cancelled'?'disabled':''}><i class="bi bi-x-lg"></i> Cancel</button>
        <button class="btn btn-secondary btn-sm reminder-btn" data-id="${a.id}" data-patient="${a.patientName}" aria-label="Send reminder"><i class="bi bi-bell"></i></button>
      </div>
    </div>`).join('');
    attachCardListeners();
    document.querySelectorAll('.appointment-card').forEach(card => {
      card.addEventListener('dragstart', handleDragStart);
      card.addEventListener('dragover', handleDragOver);
      card.addEventListener('drop', handleDrop);
    });
  }
  function handleDragStart(e) { dragSrcElement = this; e.dataTransfer.setData('text/plain', this.dataset.id); this.style.opacity = '0.5'; }
  function handleDragOver(e) { e.preventDefault(); }
  function handleDrop(e) {
    e.preventDefault();
    if (!dragSrcElement || !this.classList.contains('appointment-card')) return;
    const parent = document.getElementById('appointmentsList');
    const children = Array.from(parent.children);
    const srcIndex = children.indexOf(dragSrcElement);
    const tgtIndex = children.indexOf(this);
    if (srcIndex < tgtIndex) parent.insertBefore(dragSrcElement, this.nextSibling);
    else parent.insertBefore(dragSrcElement, this);
    dragSrcElement.style.opacity = '1';
    dragSrcElement = null;
  }
  function showPatientHistory(patientName) {
    const modal = document.getElementById('historyModal');
    const content = document.getElementById('historyContent');
    const patientApps = allAppointments.filter(a => a.patientName === patientName);
    content.innerHTML = patientApps.length ? patientApps.map(a => `<p><strong>${a.date}</strong> with ${a.doctor} – ${a.status}</p>`).join('') : `<p>No past appointments for ${patientName}.</p>`;
    modal.classList.add('show');
  }
  function showReminderToast(patient) {
    const toast = document.createElement('div'); toast.className = 'toast'; toast.setAttribute('role', 'alert');
    toast.innerText = `📲 Reminder sent to ${patient} (simulated).`;
    document.body.appendChild(toast);
    setTimeout(() => toast.remove(), 3000);
  }
  function updateStatsAndChart(apps) {
    const total = apps.length, scheduled = apps.filter(a => a.status === 'Scheduled').length, completed = apps.filter(a => a.status === 'Completed').length, cancelled = apps.filter(a => a.status === 'Cancelled').length;
    document.getElementById('totalAppts').innerText = total;
    document.getElementById('scheduledAppts').innerText = scheduled;
    document.getElementById('completedAppts').innerText = completed;
    document.getElementById('cancelledAppts').innerText = cancelled;
    if (chartInstance) chartInstance.destroy();
    const ctx = document.getElementById('statsChart').getContext('2d');
    chartInstance = new Chart(ctx, { type: 'doughnut', data: { labels: ['Scheduled','Completed','Cancelled'], datasets: [{ data: [scheduled,completed,cancelled], backgroundColor: ['#F0AD4E','#5CB85C','#D9534F'] }] }, options: { responsive: true, plugins: { legend: { position: 'bottom' } } } });
  }
  async function updateStatus(id, newStatus) {
    let apps = await getAppointments(); const app = apps.find(a => a.id == id);
    if (app) { app.status = newStatus; await saveAppointments(apps); renderAppointments(); }
  }
  function exportToCsv() {
    const apps = filteredAppointments.length ? filteredAppointments : allAppointments;
    if (!apps.length) { alert('No data to export'); return; }
    const headers = ['Patient','Doctor','Date','Time','Reason','Status'];
    const rows = apps.map(a => [a.patientName, a.doctor, a.date, a.time, a.reason, a.status].map(v => `"${v}"`).join(','));
    const csv = [headers.join(','), ...rows].join('\n');
    const blob = new Blob([csv], { type: 'text/csv' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a'); a.href = url; a.download = 'appointments.csv'; a.click();
    URL.revokeObjectURL(url);
  }
  function setRole(role) {
    localStorage.setItem(STORAGE_KEYS.ROLE, role);
    document.getElementById('roleBadge').innerText = role;
    document.getElementById('adminPanel').style.display = role === 'Admin' ? 'block' : 'none';
  }
  function updateOnlineStatus() {
    const banner = document.getElementById('offlineBanner');
    banner.style.display = navigator.onLine ? 'none' : 'block';
  }
  window.addEventListener('online', updateOnlineStatus);
  window.addEventListener('offline', updateOnlineStatus);
  updateOnlineStatus();
  if ('serviceWorker' in navigator) {
    const swCode = `self.addEventListener('install', e => e.waitUntil(caches.open('cast-v1').then(c => c.addAll(['./', 'index.html'])))); self.addEventListener('fetch', e => e.respondWith(caches.match(e.request).then(r => r || fetch(e.request))));`;
    const blob = new Blob([swCode], { type: 'application/javascript' });
    const url = URL.createObjectURL(blob);
    navigator.serviceWorker.register(url).catch(console.warn);
  }
  function attachCardListeners() {
    document.querySelectorAll('.patient-name').forEach(el => el.addEventListener('click', () => showPatientHistory(el.dataset.patient)));
    document.querySelectorAll('.complete-btn').forEach(btn => btn.addEventListener('click', () => updateStatus(btn.dataset.id, 'Completed')));
    document.querySelectorAll('.cancel-btn').forEach(btn => btn.addEventListener('click', () => updateStatus(btn.dataset.id, 'Cancelled')));
    document.querySelectorAll('.reminder-btn').forEach(btn => btn.addEventListener('click', () => showReminderToast(btn.dataset.patient)));
  }
  function login(username, password) {
    if (username.length >= 3 && password.length >= 3) { localStorage.setItem(STORAGE_KEYS.LOGGED_IN, 'true'); showApp(); return true; }
    document.getElementById('loginError').innerText = 'Username & password min 3 characters.'; return false;
  }
  function logout() { localStorage.removeItem(STORAGE_KEYS.LOGGED_IN); showLogin(); }
  function showApp() {
    document.getElementById('loginContainer').classList.add('hidden');
    document.getElementById('appContainer').classList.remove('hidden');
    fetchDoctors(); renderAppointments();
    const savedRole = localStorage.getItem(STORAGE_KEYS.ROLE) || 'Admin';
    document.getElementById('roleSelect').value = savedRole; setRole(savedRole);
  }
  function showLogin() {
    document.getElementById('loginContainer').classList.remove('hidden');
    document.getElementById('appContainer').classList.add('hidden');
  }
  document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('loginForm').addEventListener('submit', (e) => { e.preventDefault(); login(document.getElementById('username').value, document.getElementById('password').value); });
    document.getElementById('logoutBtn').addEventListener('click', logout);
    document.getElementById('themeToggleLogin').addEventListener('click', toggleTheme);
    document.getElementById('themeToggleApp').addEventListener('click', toggleTheme);
    document.getElementById('addSampleBtn').addEventListener('click', async () => {
      if (!doctorsList.length) { alert('Doctors not loaded.'); return; }
      let apps = await getAppointments();
      apps.push(new Appointment(Date.now(), 'Sample Patient', doctorsList[0].name, new Date().toISOString().split('T')[0], '11:00', 'Demo', 'Scheduled'));
      await saveAppointments(apps); renderAppointments();
    });
    document.getElementById('refreshAppointments').addEventListener('click', renderAppointments);
    document.getElementById('applyFilter').addEventListener('click', () => { applyFilterAndRender(); updateStatsAndChart(filteredAppointments); });
    document.getElementById('clearFilter').addEventListener('click', () => {
      document.getElementById('filterDoctor').value = ''; document.getElementById('filterStatus').value = '';
      document.getElementById('filterDateFrom').value = ''; document.getElementById('filterDateTo').value = '';
      renderAppointments();
    });
    document.getElementById('exportCsvBtn').addEventListener('click', exportToCsv);
    document.getElementById('sampleReminderBtn').addEventListener('click', () => showReminderToast('All Patients (test)'));
    document.getElementById('closeModal').addEventListener('click', () => document.getElementById('historyModal').classList.remove('show'));
    document.getElementById('roleSelect').addEventListener('change', (e) => setRole(e.target.value));
    document.getElementById('appointmentDate').setAttribute('min', new Date().toISOString().split('T')[0]);
    document.getElementById('appointmentForm').addEventListener('submit', async (e) => {
      e.preventDefault();
      const errDiv = document.getElementById('formError');
      errDiv.innerText = '';
      const patient = document.getElementById('patientName').value.trim();
      const doctor = document.getElementById('doctorSelect').value;
      const date = document.getElementById('appointmentDate').value;
      const time = document.getElementById('appointmentTime').value;
      const reason = document.getElementById('reason').value.trim();
      const status = document.getElementById('status').value;
      if (!patient || !doctor || !date || !time) { errDiv.innerText = 'Please fill required fields.'; return; }
      if (new Date(date) < new Date().setHours(0,0,0,0)) { errDiv.innerText = 'Date cannot be in the past.'; return; }
      let apps = await getAppointments();
      apps.push(new Appointment(Date.now() + Math.random(), patient, doctor, date, time, reason, status));
      await saveAppointments(apps);
      document.getElementById('appointmentForm').reset();
      document.getElementById('appointmentDate').setAttribute('min', new Date().toISOString().split('T')[0]);
      renderAppointments();
    });
    if (localStorage.getItem(STORAGE_KEYS.LOGGED_IN) === 'true') showApp(); else showLogin();
    if (localStorage.getItem(STORAGE_KEYS.THEME) === 'dark') document.body.classList.add('dark');
  });
  function toggleTheme() { document.body.classList.toggle('dark'); localStorage.setItem(STORAGE_KEYS.THEME, document.body.classList.contains('dark') ? 'dark' : 'light'); }
})();