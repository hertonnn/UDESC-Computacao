/**
     * Lógica e Máquina de Estados para o Ciclo de Vida em Estrela
     */
let isStarted = false;
let actionsLog = [];

// Flags do estado do sistema
let flags = {
  hasForm: false,       // fixed by Implementação
  hasButton: false,     // fixed by Prototipação
  hasDate: false,       // fixed by Especificação de Requisitos (State 2)
  dateIsSlider: true,   // fixed by Projeto Conceitual (State 3/4)
  hasCreep: true        // fixed by Especificação de Requisitos (State 3/4)
};

// Elementos do DOM
const card = document.getElementById('card');
const reportBtn = document.getElementById('report-btn');
const modalOverlay = document.getElementById('modal-overlay');
const modalTitle = document.getElementById('modal-title');
const modalBody = document.getElementById('modal-body');

// Nós do Ciclo de Vida em Estrela
const nodes = [
  "Avaliação",
  "Análise de Tarefas",
  "Projeto Conceitual",
  "Especificação de Requisitos",
  "Prototipação",
  "Implementação"
];

// Inicializa a aplicação
renderState();

function updateSliderDate(days) {
  const display = document.getElementById('sliderDateDisplay');
  if (!display) return;
  const date = new Date(1900, 0, 1);
  date.setDate(date.getDate() + parseInt(days));
  const day = String(date.getDate()).padStart(2, '0');
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const year = date.getFullYear();
  display.innerText = `Data: ${day}/${month}/${year}`;
}

function resetSimulation() {
  isStarted = false;
  actionsLog = [];
  flags = {
    hasForm: false,
    hasButton: false,
    dateIsSlider: true,
    hasCreep: true
  };
  transitionToState();
}

function renderState() {
  if (!isStarted) {
    card.innerHTML = `
          <div class="text-center">
            <h1 class="title">Ciclo de Vida em Estrela</h1>
            <p class="subtitle">Interação Humano-Computador</p>
            <button class="btn btn-primary mt-4 w-full" onclick="startSimulation()">Iniciar questionário</button>
          </div>
        `;
    reportBtn.classList.add('hidden');
    reportBtn.classList.remove('pulse');
    return;
  }

  if (!flags.hasForm) {
    card.innerHTML = `
          <div class="empty-state">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
              <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
              <line x1="9" y1="9" x2="15" y2="15"></line>
              <line x1="15" y1="9" x2="9" y2="15"></line>
            </svg>
            <h2 class="title text-center" style="font-size: 20px;">Não existe uma implementação de questionário.</h2>
            <p class="subtitle text-center mt-4">Parece que pulamos alguma etapa...</p>
          </div>
        `;
    reportBtn.classList.remove('hidden');
    setTimeout(() => reportBtn.classList.add('pulse'), 800);
    return;
  }

  // Render the form based on flags
  let dateFieldHTML = '';
  if (flags.dateIsSlider) {
    dateFieldHTML = `
          <div class="form-group">
            <label>Data de Nascimento (Deslize para selecionar o dia do seu nascimento, a partir de 1900):</label>
            <input type="range" id="userDateSlider" min="0" max="45000" value="20000" style="width: 100%; margin-top: 8px; cursor: pointer;" oninput="updateSliderDate(this.value)">
            <div class="text-center mt-2" id="sliderDateDisplay" style="font-size: 13px; color: var(--slate-500)">Data: 04/10/1954</div>
          </div>
        `;
  } else {
    dateFieldHTML = `
          <div class="form-group">
            <label>Data de Nascimento:</label>
            <input type="date" id="userDate" class="input">
          </div>
        `;
  }

  let creepFieldsHTML = '';
  if (flags.hasCreep) {
    creepFieldsHTML = `
          <div class="form-group">
            <label>Endereço Completo (Obrigatório):</label>
            <input type="text" id="userAddress" placeholder="Rua, Número, Bairro, Cidade" class="input">
          </div>
          <div class="form-group">
            <label>CEP (Obrigatório):</label>
            <input type="text" id="userCEP" placeholder="00000-000" class="input">
          </div>
          <div class="form-group">
            <label>Nome do seu primeiro animal de estimação (Para segurança):</label>
            <input type="text" id="userPet" class="input">
          </div>
          <div class="form-group">
            <label>Sua cor favorita (Obrigatório):</label>
            <input type="text" id="userColor" class="input">
          </div>
        `;
  }

  card.innerHTML = `
        <h2 class="title">Questionário</h2>
        <p class="subtitle" style="margin-bottom: 24px;">Preencha os dados abaixo:</p>
        
        <div class="form-group">
          <label>Nome:</label>
          <input type="text" id="userName" placeholder="Digite seu nome completo" class="input">
        </div>
        
        ${dateFieldHTML}
        ${creepFieldsHTML}

        <div class="form-group">
          <label>Por quem o ciclo de vida em estrela foi proposto inicialmente?</label>
          <select id="q1" class="input">
            <option>Selecione uma opção...</option>
            <option>Deborah Hix e Rex Hartson</option>
            <option>Bonnie Parker e Clyde Barrow</option>
            <option>Bud Abbott e Lou Costello</option>
            <option>Han Solo & Chewbacca</option>
          </select>
        </div>
        <div class="form-group">
          <label>Qual a atividade essencial do ciclo estrela?</label>
          <select id="q2" class="input">
            <option>Selecione uma opção...</option>
            <option>Implementação</option>
            <option>Avaliação</option>
            <option>Prototipação</option>
          </select>
        </div>
        <div class="form-group">
          <label>Em relação ao seu fluxo de trabalho, como o Ciclo de Vida em Estrela é classificado?</label>
          <select id="q3" class="input">
            <option>Selecione uma opção...</option>
            <option>Linear e rígido (estilo cascata).</option>
            <option>Iterativo e altamente flexível.</option>
            <option>Exclusivamente voltado para a codificação.</option>
          </select>
        </div>
        <div class="form-group">
          <label>Qual data foi proposto o modelo?</label>
          <select id="q4" class="input">
            <option>Selecione uma opção...</option>
            <option>1985</option>
            <option>1989</option>
            <option>1993</option>
            <option>1997</option>
          </select>
        </div>

        ${flags.hasButton ? `<button class="btn btn-primary mt-6 w-full" onclick="attemptSubmit()">Enviar Formulário</button>` : ''}
      `;

  reportBtn.classList.remove('hidden');

  // Checa se o form está perfeito (A atividade está completa)
  if (flags.hasForm && flags.hasButton && !flags.dateIsSlider && !flags.hasCreep) {
    reportBtn.classList.add('hidden'); // Oculta o reportBtn, pois não há mais erros
  } else {
    reportBtn.classList.add('pulse');
  }
}

function startSimulation() {
  actionsLog.push("Início: O usuário decidiu iniciar o questionário.");
  isStarted = true;
  transitionToState();
}

function attemptSubmit() {
  if (flags.dateIsSlider || flags.hasCreep) {
    const wantsToSubmit = confirm("O formulário parece ter problemas de usabilidade (campos difíceis ou desnecessários). Deseja enviar assim mesmo ou prefere relatar um problema?");
    if (wantsToSubmit) {
      showFinalSuccess();
    }
  } else {
    showFinalSuccess();
  }
}

function transitionToState() {
  card.classList.remove('card-fade-in');
  card.classList.add('card-fade-out');

  setTimeout(() => {
    renderState();
    card.classList.remove('card-fade-out');
    card.classList.add('card-fade-in');
  }, 300);
}

function openModal() {
  reportBtn.classList.remove('pulse');
  modalOverlay.classList.add('active');

  if (!flags.hasForm) {
    renderModalContent(
      "Uhmm... parece que não temos um questionário pronto. Qual passo você acha que devemos tomar?",
      `<div class="btn-grid" id="modal-btns">
            ${nodes.map(n => `<button class="btn btn-outline" onclick="handleDefect('no_form', '${n}')">${n}</button>`).join('')}
          </div>
          <div id="modal-message"></div>`
    );
    return;
  }

  let optionsHTML = '';
  if (!flags.hasButton) {
    optionsHTML += `<button class="btn btn-outline w-full" style="text-align: left; padding-left: 16px;" onclick="selectProblem('no_btn')">• Falta opções de formulário.</button>`;
  }
  if (flags.dateIsSlider) {
    optionsHTML += `<button class="btn btn-outline w-full" style="text-align: left; padding-left: 16px;" onclick="selectProblem('bad_date')">• Tenho dificuldade em usar um campo específico do formulário.</button>`;
  }
  if (flags.hasCreep) {
    optionsHTML += `<button class="btn btn-outline w-full" style="text-align: left; padding-left: 16px;" onclick="selectProblem('creep')">• Não quero informar todos os dados pedidos no formulário.</button>`;
  }

  renderModalContent(
    "Qual o problema principal que você encontrou?",
    `<div class="flex-col gap-3">${optionsHTML}</div>`
  );
}

function selectProblem(problemType) {
  let title = "Qual atividade usar para resolver esse problema?";
  renderModalContent(
    title,
    `<div class="btn-grid" id="modal-btns">
          ${nodes.map(n => `<button class="btn btn-outline" onclick="handleDefect('${problemType}', '${n}')">${n}</button>`).join('')}
        </div>
        <div id="modal-message"></div>`
  );
}

function handleDefect(problemType, node) {
  if (problemType === 'no_form') {
    if (node === 'Implementação') {
      actionsLog.push("Avaliação: Usuário identificou que não havia sistema.");
      actionsLog.push("Implementação: A equipe de desenvolvimento criou o sistema inicial do questionário para avaliação.");
      flags.hasForm = true;
      showSuccessAndReRender('Excelente! Um questionário básico foi implementado.');
    } else if (node === 'Prototipação') {
      actionsLog.push("Avaliação: Usuário identificou que não havia sistema.");
      actionsLog.push("Prototipação: O designer criou o protótipo inicial da tela (nota: prototipar antes de codificar é uma ótima prática de IHC!).");
      actionsLog.push("Implementação: A equipe de desenvolvimento implementou o protótipo em seguida.");
      flags.hasForm = true;
      showSuccessAndReRender('Excelente escolha! Prototipar antes de implementar é uma ótima prática de IHC. O layout foi desenhado e logo implementado de forma básica.');
    } else if (node === 'Avaliação') {
      showModalMessage('warning', 'Acho que estamos andando em círculos! Você já está Avaliando. Que tal começarmos construindo algo? (Dica: Implementação ou Prototipação)');
    } else {
      showModalMessage('error', 'Oops! Precisamos de um rascunho visual ou de código rodando primeiro. (Dica: Implementação ou Prototipação)');
    }
  }

  if (problemType === 'no_btn') {
    if (node === 'Prototipação') {
      actionsLog.push("Avaliação: Usuário detectou a ausência de um botão de envio.");
      actionsLog.push("Prototipação: O designer desenhou o layout do botão de envio que estava faltando.");
      flags.hasButton = true;
      showSuccessAndReRender('Muito bem! O layout do botão foi desenhado e o protótipo ajustado.');
    } else {
      showModalMessage('error', 'Hum, quase! Lembre-se que desenhar elementos visuais e testar o layout de um botão novo faz parte da criação de protótipos. (Dica: Prototipação)');
    }
  }

  if (problemType === 'bad_date') {
    if (node === 'Projeto Conceitual') {
      actionsLog.push("Avaliação: Usuário identificou que a entrada da data causava alta carga cognitiva.");
      actionsLog.push("Projeto Conceitual: A equipe de design de interação alterou o modelo mental da data (Slider -> Calendário/Texto).");
      flags.dateIsSlider = false;
      showSuccessAndReRender('Genial! O modelo mental agora é condizente com a tarefa.');
    } else if (node === 'Implementação') {
      showModalMessage('warning', 'Calma lá! Não adianta codificar algo que tem um modelo mental ruim desde a base. Precisamos reprojetar a ideia primeiro. (Dica: Projeto Conceitual)');
    } else {
      showModalMessage('error', 'Para alterar a forma como o usuário compreende e interage com o dado (o modelo mental), precisamos focar nos conceitos base. (Dica: Projeto Conceitual)');
    }
  }

  if (problemType === 'creep') {
    if (node === 'Especificação de Requisitos') {
      actionsLog.push("Avaliação: Usuário notou que havia perguntas irrelevantes e invasivas.");
      actionsLog.push("Especificação de Requisitos: O analista de requisitos cortou os campos desnecessários do escopo do projeto.");
      flags.hasCreep = false;
      showSuccessAndReRender('Requisitos revisados: Menos é mais! A carga cognitiva foi aliviada.');
    } else {
      showModalMessage('error', 'Não é bem aí! Onde nós definimos (ou cortamos) o escopo e as funções que o sistema deve ou não ter? (Dica: Especificação de Requisitos)');
    }
  }
}

function showSuccessAndReRender(msg) {
  showModalMessage('success', msg);
  const btns = document.querySelectorAll('#modal-btns button');
  btns.forEach(b => { b.disabled = true; b.style.pointerEvents = 'none'; });

  setTimeout(() => {
    closeModal();
    transitionToState();
  }, 2000);
}

function closeModal() {
  modalOverlay.classList.remove('active');
  setTimeout(() => {
    modalTitle.innerText = '';
    modalBody.innerHTML = '';
  }, 300);
}

function renderModalContent(title, bodyHTML) {
  modalTitle.innerText = title;
  modalBody.innerHTML = bodyHTML;
}

function showModalMessage(type, text) {
  const msgDiv = document.getElementById('modal-message');
  let icon = '';
  if (type === 'error') icon = `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>`;
  if (type === 'warning') icon = `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"></path><line x1="12" y1="9" x2="12" y2="13"></line><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>`;
  if (type === 'success') icon = `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>`;

  msgDiv.innerHTML = `
        <div class="message-box message-${type}">
          ${icon} <span>${text}</span>
        </div>
      `;
}

function showFinalSuccess() {
  if (flags.dateIsSlider || flags.hasCreep) {
    actionsLog.push("Conclusão: O usuário forçou o envio de um questionário com problemas de usabilidade.");
  } else {
    actionsLog.push("Conclusão: Questionário final perfeitamente usável foi preenchido e enviado.");
  }

  const userNameEl = document.getElementById('userName');
  const userDateSliderEl = document.getElementById('userDateSlider');
  const userDateEl = document.getElementById('userDate');
  const userAddressEl = document.getElementById('userAddress');
  const userCEPEl = document.getElementById('userCEP');
  const userPetEl = document.getElementById('userPet');
  const userColorEl = document.getElementById('userColor');

  const nameVal = userNameEl && userNameEl.value ? userNameEl.value : "(Não preenchido)";
  let dateVal = "(Não preenchido)";
  if (userDateEl && userDateEl.value) {
    const rawDate = userDateEl.value; // Formato YYYY-MM-DD
    const parts = rawDate.split('-');
    if (parts.length === 3) {
      dateVal = `${parts[2]}/${parts[1]}/${parts[0]}`;
    } else {
      dateVal = rawDate;
    }
  } else if (userDateSliderEl) {
    const date = new Date(1900, 0, 1);
    date.setDate(date.getDate() + parseInt(userDateSliderEl.value));
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();
    dateVal = `${day}/${month}/${year} (Forçado pelo Slider)`;
  }

  let extraDataHTML = '';
  if (flags.hasCreep) {
    extraDataHTML = `
      <p style="font-size: 14px; margin-bottom: 4px;"><strong>Endereço:</strong> ${userAddressEl && userAddressEl.value ? userAddressEl.value : "(Não preenchido)"}</p>
      <p style="font-size: 14px; margin-bottom: 4px;"><strong>CEP:</strong> ${userCEPEl && userCEPEl.value ? userCEPEl.value : "(Não preenchido)"}</p>
      <p style="font-size: 14px; margin-bottom: 4px;"><strong>Pet:</strong> ${userPetEl && userPetEl.value ? userPetEl.value : "(Não preenchido)"}</p>
      <p style="font-size: 14px; margin-bottom: 4px;"><strong>Cor Favorita:</strong> ${userColorEl && userColorEl.value ? userColorEl.value : "(Não preenchido)"}</p>
    `;
  }

  const q1El = document.getElementById('q1');
  const q2El = document.getElementById('q2');
  const q3El = document.getElementById('q3');
  const q4El = document.getElementById('q4');
  const q1Val = q1El && q1El.value !== "Selecione uma opção..." ? q1El.value : "";
  const q2Val = q2El && q2El.value !== "Selecione uma opção..." ? q2El.value : "";
  const q3Val = q3El && q3El.value !== "Selecione uma opção..." ? q3El.value : "";
  const q4Val = q4El && q4El.value !== "Selecione uma opção..." ? q4El.value : "";

  const correctQ1 = "Deborah Hix e Rex Hartson";
  const correctQ2 = "Avaliação";
  const correctQ3 = "Iterativo e altamente flexível.";
  const correctQ4 = "1993";

  let hits = 0;
  if (q1Val === correctQ1) hits++;
  if (q2Val === correctQ2) hits++;
  if (q3Val === correctQ3) hits++;
  if (q4Val === correctQ4) hits++;
  const hitRate = (hits / 4) * 100;

  let logHTML = actionsLog.map(action => `<li style="margin-bottom: 6px;">${action}</li>`).join('');

  card.classList.remove('card-fade-in');
  card.classList.add('card-fade-out');

  setTimeout(() => {
    card.innerHTML = `
          <div class="text-left mt-4" style="max-height: 440px; overflow-y: auto; padding-right: 8px;">
            <div class="success-icon" style="margin: 0 auto 16px auto; width: 60px; height: 60px;">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                <polyline points="20 6 9 17 4 12"></polyline>
              </svg>
            </div>
            <h2 class="title text-center">Atividade Concluída!</h2>
            
            <div style="margin-top: 24px; padding: 16px; background: var(--slate-100); border-radius: 8px;">
              <h3 style="font-size: 16px; margin-bottom: 12px; color: var(--slate-800);">Resumo de Ações (Fluxo Percorrido)</h3>
              <ul style="font-size: 14px; color: var(--slate-700); padding-left: 20px; margin-bottom: 24px;">
                ${logHTML}
              </ul>

              <h3 style="font-size: 16px; margin-bottom: 12px; color: var(--slate-800);">Dados Pessoais Preenchidos</h3>
              <div style="margin-bottom: 24px; padding: 12px; background: var(--branco); border-radius: 6px; border: 1px solid var(--slate-400);">
                <p style="font-size: 14px; margin-bottom: 4px;"><strong>Nome:</strong> ${nameVal}</p>
                <p style="font-size: 14px; margin-bottom: 4px;"><strong>Data de Nascimento:</strong> ${dateVal}</p>
                ${extraDataHTML}
              </div>

              <h3 style="font-size: 16px; margin-bottom: 12px; color: var(--slate-800);">Resultado do Questionário</h3>
              
              <div style="margin-bottom: 16px;">
                <p style="font-size: 14px; font-weight: 600; margin-bottom: 4px;">Q1: Quem propôs o ciclo inicialmente?</p>
                <p style="font-size: 14px; margin-bottom: 4px; color: ${q1Val === correctQ1 ? 'var(--verde-udesc)' : '#e25555'}">Sua resposta: ${q1Val || "Nenhuma"}</p>
                <p style="font-size: 14px; margin-bottom: 4px; color: var(--slate-500)">Correta: ${correctQ1}</p>
              </div>

              <div style="margin-bottom: 16px;">
                <p style="font-size: 14px; font-weight: 600; margin-bottom: 4px;">Q2: Qual a atividade essencial?</p>
                <p style="font-size: 14px; margin-bottom: 4px; color: ${q2Val === correctQ2 ? 'var(--verde-udesc)' : '#e25555'}">Sua resposta: ${q2Val || "Nenhuma"}</p>
                <p style="font-size: 14px; margin-bottom: 4px; color: var(--slate-500)">Correta: ${correctQ2}</p>
              </div>

              <div style="margin-bottom: 16px;">
                <p style="font-size: 14px; font-weight: 600; margin-bottom: 4px;">Q3: Fluxo de trabalho do ciclo?</p>
                <p style="font-size: 14px; margin-bottom: 4px; color: ${q3Val === correctQ3 ? 'var(--verde-udesc)' : '#e25555'}">Sua resposta: ${q3Val || "Nenhuma"}</p>
                <p style="font-size: 14px; margin-bottom: 4px; color: var(--slate-500)">Correta: ${correctQ3}</p>
              </div>

              <div style="margin-bottom: 16px;">
                <p style="font-size: 14px; font-weight: 600; margin-bottom: 4px;">Q4: Quando foi proposto o modelo?</p>
                <p style="font-size: 14px; margin-bottom: 4px; color: ${q4Val === correctQ4 ? 'var(--verde-udesc)' : '#e25555'}">Sua resposta: ${q4Val || "Nenhuma"}</p>
                <p style="font-size: 14px; margin-bottom: 4px; color: var(--slate-500)">Correta: ${correctQ4}</p>
              </div>

              <div style="font-weight: 700; font-size: 18px; text-align: center; margin-top: 24px; color: var(--verde-udesc)">
                Taxa de acerto: ${hitRate}%
              </div>
            </div>
            
            <button class="btn btn-primary mt-6 w-full" onclick="resetSimulation()">Reiniciar Simulação</button>
          </div>
        `;
    card.classList.remove('card-fade-out');
    card.classList.add('card-fade-in');
  }, 300);
}

modalOverlay.addEventListener('click', (e) => {
  if (e.target === modalOverlay) closeModal();
});
