<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>BanglaCLI · APT Repository</title>
  <!-- Font & basic styling -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background: #0b0e14;
      color: #e8edf5;
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
      padding: 2rem 1.5rem;
      line-height: 1.6;
    }

    .container {
      max-width: 1100px;
      margin: 0 auto;
    }

    /* header / logo area */
    .repo-header {
      display: flex;
      flex-direction: column;
      align-items: center;
      text-align: center;
      margin-bottom: 3rem;
    }

    .repo-header a {
      text-decoration: none;
    }

    .repo-header img {
      height: 140px;
      width: auto;
      margin-bottom: 0.5rem;
      filter: drop-shadow(0 8px 16px rgba(0,0,0,0.6));
      transition: transform 0.2s ease;
    }

    .repo-header img:hover {
      transform: scale(1.02);
    }

    .repo-header h1 {
      font-size: 2.5rem;
      font-weight: 700;
      letter-spacing: -0.02em;
      background: linear-gradient(135deg, #b7e4ff, #7aa9ff);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      margin-top: 0.25rem;
    }

    .repo-header p {
      font-size: 1.1rem;
      color: #a0b3d9;
      max-width: 650px;
      margin: 0.5rem auto 1rem;
    }

    .badge-group {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 0.75rem;
      margin: 0.75rem 0 0.25rem;
    }

    .badge-group a {
      display: inline-block;
    }

    .badge-group img {
      height: 28px;
      width: auto;
    }

    /* card style */
    .card {
      background: #141a24;
      border-radius: 24px;
      padding: 1.8rem 2rem;
      margin: 2rem 0;
      border: 1px solid #29303e;
      box-shadow: 0 12px 30px rgba(0,0,0,0.5);
      transition: border 0.2s;
    }

    .card:hover {
      border-color: #3d4a60;
    }

    h2 {
      font-size: 1.8rem;
      font-weight: 600;
      margin-bottom: 1rem;
      letter-spacing: -0.01em;
      color: #d6e3ff;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    h2 small {
      font-size: 1rem;
      font-weight: 400;
      color: #7f93bf;
      margin-left: 0.5rem;
    }

    h3 {
      font-size: 1.3rem;
      font-weight: 600;
      margin: 1.5rem 0 0.75rem;
      color: #c8d7f5;
    }

    hr {
      border: 0;
      height: 1px;
      background: #262e3d;
      margin: 1.8rem 0;
    }

    code, .code-block {
      background: #0f141e;
      padding: 0.2rem 0.6rem;
      border-radius: 8px;
      font-family: 'JetBrains Mono', 'Fira Code', monospace;
      font-size: 0.9rem;
      color: #b7d0ff;
      border: 1px solid #28303f;
    }

    .code-block {
      display: block;
      padding: 1rem 1.2rem;
      overflow-x: auto;
      margin: 0.8rem 0;
      background: #0b1019;
      border-left: 3px solid #4d7aff;
    }

    .code-block .cmd {
      color: #b7e0ff;
    }

    .code-block .out {
      color: #9bb3e0;
    }

    .btn {
      display: inline-block;
      background: #1f2a3a;
      padding: 0.5rem 1.4rem;
      border-radius: 60px;
      font-weight: 500;
      color: #d3e2ff;
      border: 1px solid #3b4862;
      text-decoration: none;
      transition: all 0.2s;
    }

    .btn:hover {
      background: #2a374d;
      border-color: #5f78a5;
      color: white;
    }

    .btn-primary {
      background: #2b4bff;
      border-color: #2b4bff;
      color: white;
      font-weight: 600;
    }

    .btn-primary:hover {
      background: #1d3dd9;
      border-color: #1d3dd9;
    }

    .grid-2 {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1.5rem;
      margin: 1.2rem 0;
    }

    .feature-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 0.8rem 1.2rem;
      margin: 1.2rem 0;
    }

    .feature-item {
      background: #111922;
      padding: 0.6rem 1rem;
      border-radius: 40px;
      border: 1px solid #28303f;
      font-size: 0.95rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .feature-item strong {
      color: #b7d0ff;
    }

    /* details / summary */
    details {
      background: #111a25;
      padding: 0.8rem 1.2rem;
      border-radius: 18px;
      margin: 0.8rem 0;
      border: 1px solid #29323f;
    }

    summary {
      font-weight: 600;
      cursor: pointer;
      color: #c3d6fc;
      font-size: 1.05rem;
      padding: 0.2rem 0;
    }

    summary:hover {
      color: #e0ecff;
    }

    details p, details ul, details .code-block {
      margin-top: 0.8rem;
    }

    ul {
      padding-left: 1.5rem;
      color: #c9d8f2;
    }

    li {
      margin: 0.4rem 0;
    }

    .support-links {
      display: flex;
      justify-content: center;
      gap: 1.2rem;
      flex-wrap: wrap;
      margin: 1.5rem 0 0.5rem;
    }

    .support-links a {
      display: inline-flex;
      align-items: center;
      gap: 0.4rem;
      background: #1b2535;
      padding: 0.6rem 1.8rem;
      border-radius: 60px;
      text-decoration: none;
      color: #dae6ff;
      font-weight: 500;
      border: 1px solid #31405a;
      transition: all 0.2s;
    }

    .support-links a:hover {
      background: #253244;
      border-color: #5274b0;
      color: white;
    }

    .footer-note {
      text-align: center;
      margin-top: 3rem;
      color: #6a7d9e;
      font-size: 0.95rem;
      border-top: 1px solid #1d2533;
      padding-top: 2rem;
    }

    .footer-note a {
      color: #8aa5dd;
      text-decoration: none;
    }

    .footer-note a:hover {
      text-decoration: underline;
    }

    @media (max-width: 640px) {
      body { padding: 1.2rem; }
      .repo-header h1 { font-size: 2rem; }
      .card { padding: 1.2rem; }
      .grid-2 { grid-template-columns: 1fr; }
      .support-links a { padding: 0.5rem 1.2rem; }
    }
  </style>
</head>
<body>
<div class="container">

  <!-- header with updated image -->
  <div class="repo-header">
    <a href="https://termuxvoid.github.io/">
      <img src="https://banglacli.edgeone.dev/file.png" alt="BanglaCLI logo">
      <h1>BanglaCLI APT Repository</h1>
    </a>
    <p><b>Unofficial APT Repository: 220+ Ethical Hacking &amp; Pentesting Packages</b></p>
    <div class="badge-group">
      <a href="https://github.com/zarifsikder/BanglaCLI/stargazers"><img src="https://img.shields.io/github/stars/TermuxVoid/repo?style=for-the-badge&logo=github&color=ffd700&labelColor=0d1117" alt="GitHub Stars"></a>
      <a href="https://github.com/zarifsikder/BanglaCLI/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-BSD_3--Clause-blue?style=for-the-badge&logo=opensourceinitiative" alt="License"></a>
      <a href="https://github.com/zarifsikder/BanglaCLI/issues"><img src="https://img.shields.io/github/issues/zarifsikder/BanglaCLI?style=for-the-badge&logo=github&color=orange&labelColor=0d1117" alt="GitHub Issues"></a>
    </div>
  </div>

  <!-- QUICK INSTALL -->
  <div class="card">
    <h2>🚀 Quick Installation</h2>
    <p>Add the repository and install any tool with a single command:</p>
    <div class="code-block">
      <span class="cmd"># Add repository</span><br>
      curl -sL https://github.com/zarifsikder/BanglaCLI/raw/main/install.sh | bash
    </div>
    <div class="code-block">
      <span class="cmd"># Install any tool (example)</span><br>
      pkg install metasploit-framework
    </div>
    <p style="margin-top:0.5rem;">👉 After adding, run <code>pkg update</code> to refresh the package list.</p>
  </div>

  <!-- FEATURED TOOLS -->
  <div class="card">
    <h2>✨ Featured Tools</h2>
    <div class="grid-2">
      <div><strong>Metasploit Framework</strong> <span style="color:#889fc9;">· Exploitation</span><br><span style="color:#b3c7ed;">World's most used pentesting framework.</span></div>
      <div><strong>Burp Suite</strong> <span style="color:#889fc9;">· Web Security</span><br><span style="color:#b3c7ed;">Leading web application security toolkit.</span></div>
      <div><strong>Ghidra</strong> <span style="color:#889fc9;">· Reverse Eng.</span><br><span style="color:#b3c7ed;">NSA's high‑end reverse engineering suite.</span></div>
      <div><strong>THC Hydra</strong> <span style="color:#889fc9;">· Password Cracking</span><br><span style="color:#b3c7ed;">Fast network logon cracker (many protocols).</span></div>
      <div><strong>SQLMap</strong> <span style="color:#889fc9;">· Web Security</span><br><span style="color:#b3c7ed;">Automatic SQL injection &amp; takeover.</span></div>
    </div>
    <div style="margin-top:1rem; text-align:center;">
      <a href="assets/PACKAGES.md" class="btn btn-primary">📦 Browse all 220+ packages</a>
    </div>
  </div>

  <!-- AI AGENTS (quick list) -->
  <div class="card">
    <h2>🧠 AI Agents</h2>
    <div class="feature-grid">
      <div class="feature-item"><strong>opencode</strong> AI‑powered coding assistant</div>
      <div class="feature-item"><strong>claude‑code</strong> Anthropic AI assistant</div>
      <div class="feature-item"><strong>antigravity‑cli</strong> glibc wrapper</div>
      <div class="feature-item"><strong>copilot‑cli</strong> GitHub Copilot terminal</div>
      <div class="feature-item"><strong>codex‑cli</strong> OpenAI lightweight agent</div>
      <div class="feature-item"><strong>mimocode</strong> autonomous AI engineer</div>
      <div class="feature-item"><strong>openclaude</strong> open‑source coding agent</div>
      <div class="feature-item"><strong>hermes‑agent</strong> workflow automation</div>
      <div class="feature-item"><strong>kimi‑code</strong> Moonshot AI assistant</div>
      <div class="feature-item"><strong>mmx‑cli</strong> MiniMax AI (chat/completion)</div>
    </div>
  </div>

  <!-- FAQ (collapsed) -->
  <div class="card">
    <h2>❓ Frequently Asked Questions</h2>

    <details>
      <summary>Are these tools safe to use on a personal device?</summary>
      <p>Yes. All packages are built from source directly on your device — no pre‑compiled binaries are shipped. However, these are powerful tools; always understand what a tool does before executing it to avoid unintended system changes.</p>
    </details>

    <details>
      <summary>Are these tools legal to use?</summary>
      <p>All tools are for <strong>legal security research and ethical hacking only</strong>. Always obtain proper authorization before testing systems you do not own.</p>
    </details>

    <details>
      <summary>Why aren't these in the official Termux repo?</summary>
      <p>Many tools (Metasploit, Ghidra, etc.) have heavy dependencies, large sizes, or licensing complexities that make them difficult to maintain in the core repositories. We handle the heavy lifting.</p>
    </details>

    <details>
      <summary>How often are tools updated?</summary>
      <ul>
        <li>Security patches: within 24h</li>
        <li>Version updates: every Sunday</li>
        <li>Emergency fixes: as needed</li>
      </ul>
    </details>

    <details>
      <summary>How do I request a new package?</summary>
      <p>Open a <a href="https://github.com/zarifsikder/BanglaCLI/issues" style="color:#7aa9ff;">GitHub Issue</a> or contact us via Telegram (see Support section).</p>
    </details>

    <details>
      <summary>How do I uninstall the BanglaCLI repository?</summary>
      <div class="code-block">
        curl -sL https://github.com/zarifsikder/BanglaCLI/raw/main/uninstall.sh | bash
      </div>
      <p>This removes the repository source and GPG key, but <strong>does not</strong> remove already installed packages.</p>
    </details>

    <details>
      <summary>I get "package not found" — what should I do?</summary>
      <p>Run <code>pkg update</code> after adding the repo. If it persists, try <code>apt update &amp;&amp; pkg search &lt;tool-name&gt;</code>. Check the <a href="assets/PACKAGES.md">full package list</a> for exact names.</p>
    </details>
  </div>

  <!-- SUPPORT & COMMUNITY: ONLY TELEGRAM remains -->
  <div class="card" style="text-align:center;">
    <h2 style="justify-content:center;">🌐 Support &amp; Community</h2>
    <p style="color:#b0c6ed; max-width:500px; margin:0 auto 1rem;">Join our community of security researchers and mobile hackers.</p>
    <div class="support-links">
      <a href="https://telegram.me/nullxvoid">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 2L11 13M22 2l-7 20-4-9-9-4 20-7z"/></svg>
        Telegram
      </a>
      <!-- removed YouTube & GitHub from support block as requested -->
    </div>
    <p style="color:#6f88b0; font-size:0.9rem; margin-top:1.2rem;">✉️ <a href="mailto:BanglaCLI@gmail.com" style="color:#8aa5dd;">BanglaCLI@gmail.com</a></p>
  </div>

  <!-- footer -->
  <div class="footer-note">
    Built with ❤️ for security researchers by <a href="https://github.com/Anon4You">Alienkrishn</a> &middot; Built on-device for best compatibility<br>
    <span style="font-size:0.85rem; color:#4f6385;">📄 <a href="https://github.com/zarifsikder/BanglaCLI/blob/main/LICENSE" style="color:#6e88b5;">BSD 3‑Clause License</a></span>
  </div>

</div>
</body>
</html>
