<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="CAST – Clinical Appointment Scheduling & Tracking with advanced features">
  <meta name="keywords" content="healthcare, appointment, scheduler, clinical tracking">
  <title>CAST · Pro Edition</title>
  <!-- Preconnect & Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
  <!-- Bootstrap Icons & utilities -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <!-- Chart.js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
  <style>
    /* ---------- ENHANCED STYLING with modern touches ---------- */
    :root {
      --primary: #2A7F62;
      --primary-light: #3A9F7A;
      --primary-dark: #1E5F4A;
      --secondary-bg: #F4F7F9;
      --text-dark: #1A2B3C;
      --text-muted: #5F6C7A;
      --bg-light: #FFFFFF;
      --card-bg: rgba(255, 255, 255, 0.85);
      --border-light: #E2E8F0;
      --error: #D9534F;
      --success: #5CB85C;
      --warning: #F0AD4E;
      --info: #5BC0DE;
      --transition-speed: 0.25s;
      --border-radius: 16px;
      --border-radius-sm: 12px;
      --shadow-sm: 0 4px 6px -2px rgba(0,0,0,0.05), 0 2px 4px -1px rgba(0,0,0,0.03);
      --shadow-md: 0 12px 24px -8px rgba(0,0,0,0.1);
      --shadow-lg: 0 24px 48px -12px rgba(0,0,0,0.15);
      --font-sans: 'Inter', system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      --gradient-bg: linear-gradient(135deg, #F6F9FC 0%, #EDF2F7 100%);
      --glass-bg: rgba(255, 255, 255, 0.7);
      --glass-border: 1px solid rgba(255, 255, 255, 0.3);
      --blur: blur(10px);
    }
    body.dark {
      --primary: #3A9F7A;
      --primary-light: #4FB493;
      --primary-dark: #2A7F62;
      --secondary-bg: #1E2A36;
      --text-dark: #EDF2F7;
      --text-muted: #A0B3C9;
      --bg-light: #121E2A;
      --card-bg: rgba(30, 42, 54, 0.85);
      --border-light: #2D3F4E;
      --error: #E57373;
      --success: #81C784;
      --warning: #FFB74D;
      --info: #64B5F6;
      --shadow-sm: 0 4px 6px -2px rgba(0,0,0,0.3);
      --shadow-md: 0 12px 24px -8px rgba(0,0,0,0.5);
      --gradient-bg: linear-gradient(135deg, #1E2A36 0%, #16222E 100%);
      --glass-bg: rgba(30, 42, 54, 0.7);
      --glass-border: 1px solid rgba(255, 255, 255, 0.08);
    }
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: var(--font-sans);
      background: var(--gradient-bg);
      color: var(--text-dark);
      margin: 0;
      padding: 1.5rem;
      transition: background-color var(--transition-speed), color var(--transition-speed);
      line-height: 1.6;
      min-height: 100vh;
    }
    /* Skip link */
    .skip-link {
      position: absolute;
      left: -999px;
      top: 0;
      background: var(--primary);
      color: white;
      padding: 0.75rem 1.5rem;
      border-radius: 0 0 var(--border-radius-sm) 0;
      z-index: 1000;
      text-decoration: none;
      font-weight: 500;
    }
    .skip-link:focus { left: 0; outline: 2px solid white; }
    /* Container */
    .container-custom {
      max-width: 1600px;
      margin: 0 auto;
      width: calc(100% - 2rem);
    }
    /* Cards with glassmorphism */
    .card {
      background: var(--glass-bg);
      backdrop-filter: var(--blur);
      -webkit-backdrop-filter: var(--blur);
      border: var(--glass-border);
      border-radius: var(--border-radius);
      padding: 1.75rem;
      box-shadow: var(--shadow-md);
      transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s;
    }
    .card:hover {
      transform: translateY(-4px);
      box-shadow: var(--shadow-lg);
      background: rgba(255, 255, 255, 0.8);
    }
    body.dark .card:hover {
      background: rgba(40, 55, 70, 0.8);
    }
    /* Buttons with glow effect */
    .btn {
      border: none;
      border-radius: var(--border-radius-sm);
      padding: 0.7rem 1.5rem;
      font-weight: 600;
      background: var(--primary);
      color: white;
      cursor: pointer;
      transition: all 0.2s ease;
      display: inline-flex;
      align-items: center;
      gap: 0.6rem;
      font-size: 0.95rem;
      letter-spacing: 0.01em;
      box-shadow: 0 4px 12px rgba(42, 127, 98, 0.3);
      position: relative;
      overflow: hidden;
    }
    .btn::after {
      content: '';
      position: absolute;
      top: 50%;
      left: 50%;
      width: 0;
      height: 0;
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.4);
      transform: translate(-50%, -50%);
      transition: width 0.4s, height 0.4s;
    }
    .btn:hover::after {
      width: 200px;
      height: 200px;
    }
    .btn:hover {
      background: var(--primary-light);
      transform: translateY(-2px);
      box-shadow: 0 8px 18px rgba(42, 127, 98, 0.4);
    }
    .btn:active {
      transform: translateY(0);
      box-shadow: 0 2px 8px rgba(42, 127, 98, 0.3);
    }
    .btn-secondary {
      background: var(--glass-bg);
      backdrop-filter: var(--blur);
      color: var(--text-dark);
      border: var(--glass-border);
      box-shadow: var(--shadow-sm);
    }
    .btn-secondary:hover {
      background: rgba(255, 255, 255, 0.9);
      box-shadow: var(--shadow-md);
    }
    body.dark .btn-secondary:hover {
      background: rgba(50, 65, 80, 0.9);
    }
    .btn-error {
      background: var(--error);
      box-shadow: 0 4px 12px rgba(217, 83, 79, 0.3);
    }
    .btn-sm {
      padding: 0.4rem 1rem;
      font-size: 0.85rem;
    }
    /* Form elements with floating label effect (simplified) */
    .form-group {
      margin-bottom: 1.5rem;
      position: relative;
    }
    label {
      display: block;
      margin-bottom: 0.4rem;
      font-weight: 600;
      font-size: 0.85rem;
      text-transform: uppercase;
      letter-spacing: 0.02em;
      color: var(--text-muted);
    }
    input, select, textarea {
      width: 100%;
      padding: 0.8rem 1rem;
      border: 2px solid transparent;
      border-radius: var(--border-radius-sm);
      background: var(--bg-light);
      color: var(--text-dark);
      font-family: inherit;
      font-size: 0.95rem;
      transition: border 0.2s, box-shadow 0.2s;
      box-shadow: var(--shadow-sm);
    }
    input:focus, select:focus, textarea:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 4px rgba(42, 127, 98, 0.15);
    }
    /* Validation styling */
    input:invalid:not(:placeholder-shown) {
      border-color: var(--error);
    }
    .error-message {
      color: var(--error);
      font-size: 0.8rem;
      margin-top: 0.3rem;
      display: flex;
      align-items: center;
      gap: 0.3rem;
    }
    /* Appointments grid */
    .appointments-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
      gap: 1.5rem;
      margin-top: 1.5rem;
    }
    .appointment-card {
      background: var(--glass-bg);
      backdrop-filter: var(--blur);
      border: var(--glass-border);
      border-radius: var(--border-radius);
      padding: 1.25rem;
      transition: all 0.2s ease;
      cursor: grab;
      box-shadow: var(--shadow-sm);
      animation: fadeInUp 0.4s ease;
    }
    .appointment-card:active { cursor: grabbing; }
    .appointment-card:hover {
      transform: scale(1.02);
      box-shadow: var(--shadow-md);
      border-color: var(--primary);
    }
    @keyframes fadeInUp {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }
    /* Status badges */
    .status {
      display: inline-block;
      padding: 0.25rem 0.8rem;
      border-radius: 30px;
      font-size: 0.7rem;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.03em;
      box-shadow: var(--shadow-sm);
    }
    .status-scheduled { background: var(--warning); color: #1A2B3C; }
    .status-completed { background: var(--success); color: white; }
    .status-cancelled { background: var(--error); color: white; }
    /* Tracking stats with gradient */
    .tracking-stats {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 1.2rem;
      margin: 1.5rem 0;
    }
    .stat-card {
      background: var(--glass-bg);
      backdrop-filter: var(--blur);
      border: var(--glass-border);
      border-radius: var(--border-radius);
      padding: 1.2rem;
      text-align: center;
      font-weight: 600;
      box-shadow: var(--shadow-sm);
      transition: all 0.2s;
    }
    .stat-card:hover {
      transform: translateY(-3px);
      box-shadow: var(--shadow-md);
    }
    .stat-card strong {
      display: block;
      font-size: 1.8rem;
      font-weight: 700;
      color: var(--primary);
      margin-bottom: 0.3rem;
    }
    /* Filter bar */
    .filter-bar {
      display: flex;
      gap: 1rem;
      flex-wrap: wrap;
      align-items: flex-end;
      background: var(--glass-bg);
      backdrop-filter: var(--blur);
      border: var(--glass-border);
      border-radius: var(--border-radius);
      padding: 1.5rem;
      margin: 1.5rem 0;
    }
    .filter-bar > div {
      min-width: 150px;
      flex: 1 1 auto;
    }
    /* Modal */
    .modal {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0,0,0,0.5);
      backdrop-filter: blur(5px);
      align-items: center;
      justify-content: center;
      z-index: 2000;
    }
    .modal.show { display: flex; animation: fadeIn 0.3s; }
    .modal-content {
      background: var(--glass-bg);
      backdrop-filter: var(--blur);
      border: var(--glass-border);
      border-radius: var(--border-radius);
      padding: 2rem;
      max-width: 500px;
      width: 90%;
      max-height: 80vh;
      overflow: auto;
      box-shadow: var(--shadow-lg);
    }
    @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    /* Toast */
    .toast {
      position: fixed;
      bottom: 20px;
      right: 20px;
      background: var(--primary);
      color: white;
      padding: 1rem 1.5rem;
      border-radius: var(--border-radius-sm);
      box-shadow: var(--shadow-lg);
      z-index: 2100;
      animation: slideInRight 0.3s ease, fadeOut 0.3s ease 2.7s forwards;
      font-weight: 500;
    }
    @keyframes slideInRight {
      from { transform: translateX(100%); opacity: 0; }
      to { transform: translateX(0); opacity: 1; }
    }
    @keyframes fadeOut {
      to { opacity: 0; transform: translateY(20px); }
    }
    /* Chart container */
    .chart-container {
      background: var(--glass-bg);
      backdrop-filter: var(--blur);
      border: var(--glass-border);
      border-radius: var(--border-radius);
      padding: 1rem;
      margin: 1rem 0;
    }
    /* Offline banner */
    #offlineBanner {
      background: var(--warning);
      color: #1A2B3C;
      padding: 0.75rem;
      text-align: center;
      border-radius: var(--border-radius);
      margin-bottom: 1rem;
      font-weight: 600;
      display: none;
    }
    /* Responsive */
    @media (max-width: 768px) {
      .tracking-stats { grid-template-columns: 1fr 1fr; }
      .filter-bar > div { min-width: 100%; }
      .container-custom { width: 100%; }
      body { padding: 0.75rem; }
    }
    /* Utility classes */
    .hidden { display: none !important; }
    .text-muted { color: var(--text-muted); }
    .mt-2 { margin-top: 0.5rem; }
    .mt-4 { margin-top: 1.5rem; }
    .me-2 { margin-right: 0.5rem; }
    .ms-2 { margin-left: 0.5rem; }
    /* Table styling */
    .clinic-table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 1rem;
      border-radius: var(--border-radius);
      overflow: hidden;
      box-shadow: var(--shadow-sm);
    }
    .clinic-table th {
      background: var(--primary);
      color: white;
      padding: 0.75rem;
      font-weight: 600;
    }
    .clinic-table td {
      padding: 0.5rem;
      border: 1px solid var(--border-light);
      text-align: center;
    }
  </style>
</head>
<body>
  <a href="#main" class="skip-link">Skip to main content</a>
  <div id="offlineBanner">📡 You are offline. Some features may be limited.</div>
  <div class="container-custom">
    <!-- LOGIN -->
    <div id="loginContainer">
      <div class="card" style="max-width:440px; margin:3rem auto;">
        <div class="flex-between">
          <h2 style="display: flex; align-items: center; gap:0.5rem;"><i class="bi bi-shield-check" style="color:var(--primary);"></i> CAST Login</h2>
          <button id="themeToggleLogin" class="btn btn-secondary btn-sm"><i class="bi bi-moon-stars"></i></button>
        </div>
        <form id="loginForm">
          <div class="form-group"><label for="username">Username</label><input type="text" id="username" placeholder="e.g., admin" required minlength="3"></div>
          <div class="form-group"><label for="password">Password</label><input type="password" id="password" placeholder="••••" required minlength="3"></div>
          <div class="form-group"><button type="submit" class="btn"><i class="bi bi-box-arrow-in-right"></i> Sign in</button></div>
          <div id="loginError" class="error-message"></div>
          <p class="text-muted"><small>Demo: any credentials length ≥3</small></p>
        </form>
      </div>
    </div>

    <!-- MAIN APP -->
    <div id="appContainer" class="hidden">
      <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; flex-wrap: wrap; gap:1rem;">
        <div style="display: flex; align-items: center; gap:1rem;">
          <div style="background: var(--primary); padding:0.5rem; border-radius:50%;">
            <i class="bi bi-calendar2-week" style="font-size:1.8rem; color:white;"></i>
          </div>
          <h1 style="font-size:1.8rem; font-weight:700; background: linear-gradient(135deg, var(--primary), var(--primary-light)); -webkit-background-clip:text; -webkit-text-fill-color:transparent;">CAST · Pro</h1>
        </div>
        <div style="display: flex; gap:0.5rem; align-items:center;">
          <span id="roleBadge" class="status" style="background:var(--info); color:#fff;">Admin</span>
          <select id="roleSelect" aria-label="Switch role" class="btn btn-secondary btn-sm" style="width:auto;">
            <option value="Admin">Admin</option>
            <option value="Doctor">Doctor</option>
            <option value="Receptionist">Receptionist</option>
          </select>
          <button id="themeToggleApp" class="btn btn-secondary btn-sm"><i class="bi bi-moon-stars"></i></button>
          <button id="logoutBtn" class="btn btn-error btn-sm"><i class="bi bi-door-closed"></i> Logout</button>
        </div>
      </header>

      <!-- Admin panel -->
      <div id="adminPanel" class="card" style="margin-bottom:1.5rem;">
        <h2 class="h5" style="display:flex; align-items:center; gap:0.5rem;"><i class="bi bi-gear"></i> Admin Tools</h2>
        <div style="display:flex; gap:0.5rem; flex-wrap:wrap;">
          <button id="exportCsvBtn" class="btn btn-secondary btn-sm"><i class="bi bi-file-earmark-spreadsheet"></i> Export to CSV</button>
          <button id="sampleReminderBtn" class="btn btn-secondary btn-sm"><i class="bi bi-bell"></i> Send test reminder</button>
        </div>
      </div>

      <!-- Stats & Chart -->
      <div style="display: flex; gap:1.5rem; flex-wrap:wrap; align-items:center;">
        <div class="tracking-stats" style="flex:2;">
          <div class="stat-card"><strong id="totalAppts">0</strong>Total</div>
          <div class="stat-card"><strong id="scheduledAppts">0</strong>Scheduled</div>
          <div class="stat-card"><strong id="completedAppts">0</strong>Completed</div>
          <div class="stat-card"><strong id="cancelledAppts">0</strong>Cancelled</div>
        </div>
        <div class="chart-container" style="flex:1; min-width:200px;">
          <canvas id="statsChart"></canvas>
        </div>
      </div>

      <!-- Filter Bar -->
      <div class="filter-bar">
        <div><label>Doctor</label><select id="filterDoctor"><option value="">All</option></select></div>
        <div><label>Status</label><select id="filterStatus"><option value="">All</option><option value="Scheduled">Scheduled</option><option value="Completed">Completed</option><option value="Cancelled">Cancelled</option></select></div>
        <div><label>From</label><input type="date" id="filterDateFrom"></div>
        <div><label>To</label><input type="date" id="filterDateTo"></div>
        <div style="display:flex; gap:0.5rem; align-items:flex-end;">
          <button id="applyFilter" class="btn btn-secondary btn-sm">Apply</button>
          <button id="clearFilter" class="btn btn-secondary btn-sm">Clear</button>
        </div>
      </div>

      <!-- Main grid -->
      <div style="display:grid; grid-template-columns:1fr 2fr; gap:1.8rem; margin-top:1.5rem;">
        <!-- New appointment form -->
        <section class="card" aria-labelledby="new-appt-heading">
          <h2 id="new-appt-heading" style="display:flex; align-items:center; gap:0.5rem; margin-bottom:1.5rem;"><i class="bi bi-plus-circle" style="color:var(--primary);"></i> New appointment</h2>
          <form id="appointmentForm">
            <div class="form-group"><label for="patientName">Patient *</label><input type="text" id="patientName" placeholder="Full name" required minlength="2"></div>
            <div class="form-group"><label for="doctorSelect">Doctor *</label><select id="doctorSelect" required><option value="">-- loading --</option></select><small id="doctorLoading" class="text-muted"><i class="bi bi-arrow-repeat"></i> loading...</small></div>
            <div class="form-group"><label for="appointmentDate">Date *</label><input type="date" id="appointmentDate" required></div>
            <div class="form-group"><label for="appointmentTime">Time *</label><input type="time" id="appointmentTime" required></div>
            <div class="form-group"><label for="reason">Reason</label><textarea id="reason" rows="2" placeholder="Optional notes"></textarea></div>
            <div class="form-group"><label for="status">Initial status</label><select id="status"><option value="Scheduled">Scheduled</option><option value="Completed">Completed</option><option value="Cancelled">Cancelled</option></select></div>
            <button type="submit" class="btn"><i class="bi bi-calendar-plus"></i> Schedule</button>
            <div id="formError" class="error-message mt-2"></div>
          </form>
        </section>

        <!-- Appointments list -->
        <section class="card" aria-labelledby="appt-list-heading">
          <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:1rem;">
            <h2 id="appt-list-heading" style="display:flex; align-items:center; gap:0.5rem;"><i class="bi bi-list-check" style="color:var(--primary);"></i> Appointments</h2>
            <div>
              <button id="addSampleBtn" class="btn btn-secondary btn-sm"><i class="bi bi-file-earmark-plus"></i> Sample</button>
              <button id="refreshAppointments" class="btn btn-secondary btn-sm"><i class="bi bi-arrow-repeat"></i></button>
            </div>
          </div>
          <div id="appointmentsList" class="appointments-grid" role="list" aria-label="Appointment cards"></div>
          <!-- Weekly schedule table (detail) -->
          <details class="mt-4" aria-label="Clinic schedule details">
            <summary style="cursor:pointer; color:var(--primary); font-weight:600;"><i class="bi bi-table"></i> View weekly schedule (example table)</summary>
            <table class="clinic-table" aria-label="Doctors' weekly hours">
              <thead><tr><th>Doctor</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th></tr></thead>
              <tbody>
                <tr><td>Dr. Smith</td><td>9-12</td><td>2-5</td><td>9-12</td><td>2-5</td><td>9-12</td></tr>
                <tr><td>Dr. Johnson</td><td>2-5</td><td>9-12</td><td>2-5</td><td>9-12</td><td>-</td></tr>
                <tr><td>Dr. Williams</td><td>9-12</td><td>9-12</td><td>2-5</td><td>9-12</td><td>2-5</td></tr>
              </tbody>
            </table>
          </details>
        </section>
      </div>

      <!-- Patient history modal -->
      <div id="historyModal" class="modal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
        <div class="modal-content">
          <h3 id="modalTitle" style="display:flex; align-items:center; gap:0.5rem;"><i class="bi bi-clock-history"></i> Patient History</h3>
          <div id="historyContent">Loading...</div>
          <button id="closeModal" class="btn btn-secondary btn-sm mt-2">Close</button>
        </div>
      </div>
    </div>
  </div>

  <script>
    // (JavaScript unchanged – all features preserved)
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
  </script>
</body>
</html>
