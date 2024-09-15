# Hackathon PortoHack 2024 - DockDash

![Build Status](https://img.shields.io/badge/Build-Passing-brightgreen)
![Platform](https://img.shields.io/badge/Platform-Web-blue)
![License](https://img.shields.io/badge/License-MIT-green)

---

> **MVP**: [Frontend DockDash](https://frontend-dash.vercel.app)

---

## 🌐 Introdução

O **DockDash** é uma plataforma help desk criada para otimizar o fluxo de informações entre a (APS) e o sistema de (DTE), garantindo a integridade dos dados e disparando alertas automáticos em caso de erros. Nossa solução ajuda a:

- Prevenir erros nas operações portuárias.
- Garantir a confiabilidade das análises futuras.
- Reduzir o SLA (Service Level Agreement).

**Como fazemos isso?**

1. **Integração via API com o sistema APS**: Capturamos dados diretamente da API da APS, que são cruzados e validados com o sistema DTE.
2. **Validação de dados**: A cada solicitação, o sistema compara as informações da APS com o banco de dados da ABTRA, identificando inconsistências.
3. **Monitoramento contínuo**: O DockDash realiza três testes principais:
   - **Teste de conectividade da API da APS**.
   - **Validação de dados entre Supervias e ABTRA**.
   - **Verificação de viagens inexistentes ou falhas de registro**.

Para cada problema encontrado, um ticket é gerado automaticamente, enviado para a equipe responsável, e o tempo de resolução é monitorado diretamente no dashboard.

---

### 🌟 Funcionalidades

🔹 **Integração com APIs**: Conecta-se periodicamente à API da APS para obter dados atualizados.

🔹 **Validação automática de dados**: Verifica inconsistências entre os sistemas APS e DTE, disparando alertas automáticos quando necessário.

🔹 **Geração automática de tickets**: Quando inconsistências são identificadas, o sistema gera tickets automaticamente para as equipes responsáveis.

🔹 **Monitoramento do SLA**: Exibe tempos médios de resolução de problemas e status de tickets no dashboard.

🔹 **Interface intuitiva**: Uma interface simples e amigável, permitindo a visualização clara das operações e informações.

---

## 🛠 Instalação (Mobile)

1. **Pré-requisitos**:
    - Certifique-se de que você tem Dart e Flutter instalados em sua máquina.

2. **Clonar o Repositório**:

    ```bash
    git clone https://github.com/bellujrb/hackathon_portosantos/frontend
    ```

3. **Instalar Dependências**:

    ```bash
    flutter pub get
    ```

4. **Executar o App**:

    ```bash
    flutter run
    ```

## 🛠 Instalação (Jupiter)

1. **Clone o repositório**:

    ```bash
    git clone https://github.com/bellujrb/hackathon_portosantos
    ```

2. **Criação do ambiente virtual**:

    ```bash
    python3 -m venv venv
    source venv/bin/activate  # No Windows, usar: venv\Scripts\activate
    ```

3. **Executar o notebook Jupyter**:

    ```bash
    jupyter notebook portohack.ipynb
    ```

---

---

## 📂 Estrutura do Projeto
    
```
hackathon_portosantos
├── frontend
│   └── ...
├── frontend-abtra
│   └── ...
├── portohack.py
├── README.MD
│   └── ...
```

---

#### `hackathon_portosantos`

- **`frontend`**:
    - Aplicação frontend que exibe os dados coletados e os tickets gerados.
- **`frontend-abtra`**:
    - Website mockado da ABTRA para demonstrar API
- **`portohack.py`**:
    - Algoritmo de analise de dados com API da APS
- **`README.md`**:
    - Documentação do projeto.

---

## 🛠 Tech Stack Mobile

### Design Patterns (Mobile)
- Singleton

### Pacotes Externos (Mobile)
- Flutter Modular
- Flutter SVG
- Google Fonts

### Arquitetura (Mobile)
- Clean Architecture
- Modular

---

## 🙏 Agradecimentos

Agradecimento especial ao Porto de Santos pela oportunidade ambiciosa de transformar o setor portuário.
