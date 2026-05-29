const App = {
    stats: { xp: 0, level: 0 },
    jobs: [],
    activeJob: null,
    currentTab: 'dashboard',

    init() {
        console.log("ZN Tablet: Sistema de interface inicializado.");
        
        fetch(`https://${GetParentResourceName()}/nuiLoaded`, {
            method: 'POST',
            body: JSON.stringify({})
        }).catch(err => console.error("ZN Tablet: Erro no Handshake!", err));

        window.addEventListener('message', (event) => {
            const data = event.data;
            switch (data.action) {
                case 'open':
                    this.open(data);
                    break;
                case 'updateStats':
                    if (data.stats) {
                        this.stats = data.stats;
                        this.updateStatsUI();
                    }
                    break;
            }
        });

        const closeBtn = document.getElementById('close-tablet');
        if (closeBtn) closeBtn.addEventListener('click', () => this.close());
        
        document.querySelectorAll('.nav-tab').forEach(tab => {
            tab.addEventListener('click', (e) => {
                const target = e.currentTarget.getAttribute('data-tab');
                this.switchTab(target);
            });
        });

        const startTerminalBtn = document.getElementById('nui-start-terminal-btn');
        if (startTerminalBtn) {
            startTerminalBtn.addEventListener('click', () => {
                const jobData = this.jobs[0];
                if (jobData) {
                    fetch(`https://${GetParentResourceName()}/startJob`, {
                        method: 'POST',
                        body: JSON.stringify({ event: jobData.event, job: jobData.id })
                    });
                    this.close();
                }
            });
        }

        const uniformBtn = document.getElementById('nui-uniform-btn');
        if (uniformBtn) {
            uniformBtn.addEventListener('click', () => {
                const topBar = document.querySelector('.top-bar');
                const isTerminal = topBar ? topBar.style.display === 'none' : false;
                const jobToApply = (isTerminal && this.jobs.length > 0) ? this.jobs[0].id : this.activeJob;
                
                if (jobToApply) {
                    fetch(`https://${GetParentResourceName()}/applyUniform`, {
                        method: 'POST',
                        body: JSON.stringify({ job: jobToApply })
                    });
                }
            });
        }

        const removeUniformBtn = document.getElementById('nui-remove-uniform-btn');
        if (removeUniformBtn) {
            removeUniformBtn.addEventListener('click', () => {
                fetch(`https://${GetParentResourceName()}/removeUniform`, {
                    method: 'POST',
                    body: JSON.stringify({})
                });
            });
        }

        const cancelBtn = document.getElementById('nui-cancel-btn');
        if (cancelBtn) {
            cancelBtn.addEventListener('click', () => {
                fetch(`https://${GetParentResourceName()}/endJob`, {
                    method: 'POST',
                    body: JSON.stringify({})
                });
                this.activeJob = null;
                this.updateActiveJobUI();
            });
        }

        window.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') this.close();
        });
    },

    open(data) {
        console.log("ZN Tablet: Abrindo interface...");
        const app = document.getElementById('app');
        if (app) {
            app.style.display = 'flex';
            app.style.opacity = "1";
        }

        try {
            this.stats = data.stats || { xp: 0, level: 0 };
            this.jobs = data.jobs || [];
            this.activeJob = data.activeJob || null;
            
            const topBar = document.querySelector('.top-bar');
            if (topBar) {
                topBar.style.display = data.isFiltered ? 'none' : 'flex';
            }

            this.updateStatsUI();
            this.renderJobs();
            this.updateActiveJobUI();
            this.switchTab('dashboard');
        } catch (err) {
            console.error("ZN Tablet: Erro ao abrir interface", err);
        }
    },

    close() {
        const app = document.getElementById('app');
        if (app) app.style.display = 'none';
        fetch(`https://${GetParentResourceName()}/close`, {
            method: 'POST',
            body: JSON.stringify({})
        });
    },

    switchTab(tabId) {
        this.currentTab = tabId;
        document.querySelectorAll('.nav-tab').forEach(tab => {
            tab.classList.toggle('active', tab.getAttribute('data-tab') === tabId);
        });
        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.toggle('active', content.getAttribute('id') === tabId);
        });
    },

    updateStatsUI() {
        try {
            const level = Number(this.stats.level) || 0;
            const xp = Number(this.stats.xp) || 0;
            
            const levelEl = document.getElementById('player-level');
            if (levelEl) levelEl.innerText = `NÍVEL ${level}`;
            
            const nextLevelStartXP = Math.pow(level + 1, 2) * 100;
            const xpTextEl = document.getElementById('xp-text');
            if (xpTextEl) xpTextEl.innerText = `${xp} / ${nextLevelStartXP} XP`;
            
            const progressPercent = Math.min(100, (xp / nextLevelStartXP) * 100);
            const xpFillEl = document.getElementById('xp-fill');
            if (xpFillEl) xpFillEl.style.width = `${progressPercent}%`;
            
            const bonusEl = document.getElementById('bonus-value');
            if (bonusEl) bonusEl.innerText = `+${level * 2}%`;
        } catch (e) {
            console.error("ZN Tablet: Erro Stats UI", e);
        }
    },

    updateActiveJobUI() {
        const noJob = document.getElementById('no-active-job');
        const activeJobUI = document.getElementById('job-active');
        const startBtn = document.getElementById('nui-start-terminal-btn');
        const uniformBtn = document.getElementById('nui-uniform-btn');
        const removeBtn = document.getElementById('nui-remove-uniform-btn');
        const cancelBtn = document.getElementById('nui-cancel-btn');

        if (!noJob || !activeJobUI) return;

        const topBar = document.querySelector('.top-bar');
        const isTerminal = topBar ? topBar.style.display === 'none' : false;
        
        if (isTerminal && this.jobs.length > 0) {
            // Modo Terminal (NPC específico)
            const terminalJob = this.jobs[0];
            noJob.style.display = 'none';
            activeJobUI.style.display = 'block';
            
            document.getElementById('active-job-name').innerText = terminalJob.name;
            document.getElementById('active-job-icon').className = terminalJob.icon;

            const isCurrentActive = this.activeJob === terminalJob.id;

            if (startBtn) {
                startBtn.style.display = isCurrentActive ? 'none' : 'block';
                startBtn.innerHTML = '<i class="fa-solid fa-play"></i> INICIAR TRABALHO';
            }
            if (uniformBtn) uniformBtn.style.display = 'block';
            if (removeBtn) removeBtn.style.display = 'block';
            if (cancelBtn) cancelBtn.style.display = isCurrentActive ? 'block' : 'none';

        } else if (this.activeJob) {
            // Modo Dashboard (Vendo meu serviço atual)
            noJob.style.display = 'none';
            activeJobUI.style.display = 'block';
            
            const jobData = this.jobs.find(j => j.id === this.activeJob || (j.id && j.id.includes(this.activeJob)));
            if (jobData) {
                document.getElementById('active-job-name').innerText = jobData.name;
                document.getElementById('active-job-icon').className = jobData.icon;
            }

            if (startBtn) startBtn.style.display = 'none';
            if (uniformBtn) uniformBtn.style.display = 'block';
            if (removeBtn) removeBtn.style.display = 'block';
            if (cancelBtn) cancelBtn.style.display = 'block';
        } else {
            // Sem serviço e sem terminal aberto
            noJob.style.display = 'block';
            activeJobUI.style.display = 'none';
        }
    },

    renderJobs() {
        const container = document.getElementById('jobs-list');
        if (!container) return;
        container.innerHTML = '';

        this.jobs.forEach(job => {
            if (!job.enabled) return;

            const card = document.createElement('div');
            card.className = 'job-card';
            if (this.activeJob === job.id) card.classList.add('job-card-active');

            card.innerHTML = `
                <i class="${job.icon}"></i>
                <h3>${job.name}</h3>
                <p>Trabalhe como ${job.name.toLowerCase()} para ganhar XP e dinheiro.</p>
                <div class="job-actions">
                    <button class="btn btn-primary start-job-btn" data-event="${job.event}" data-id="${job.id}">
                        <i class="fa-solid fa-play"></i> ${this.activeJob === job.id ? 'ATIVO' : 'SOLICITAR'}
                    </button>
                    <button class="btn btn-secondary uniform-job-btn" data-id="${job.id}">
                        <i class="fa-solid fa-shirt"></i> PEGAR ROUPA
                    </button>
                </div>
                <div class="badge ${job.enabled ? 'badge-active' : 'badge-inactive'}">
                    ${job.enabled ? 'DISPONÍVEL' : 'BLOQUEADO'}
                </div>
            `;

            card.querySelector('.start-job-btn').addEventListener('click', (e) => {
                e.stopPropagation();
                const event = e.currentTarget.getAttribute('data-event');
                const id = e.currentTarget.getAttribute('data-id');
                fetch(`https://${GetParentResourceName()}/startJob`, {
                    method: 'POST',
                    body: JSON.stringify({ event: event, job: id })
                });
                this.close();
            });

            card.querySelector('.uniform-job-btn').addEventListener('click', (e) => {
                e.stopPropagation();
                const id = e.currentTarget.getAttribute('data-id');
                fetch(`https://${GetParentResourceName()}/applyUniform`, {
                    method: 'POST',
                    body: JSON.stringify({ job: id })
                });
                this.close();
            });

            container.appendChild(card);
        });
    }
};

document.addEventListener('DOMContentLoaded', () => App.init());
