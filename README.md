<h1 align="center">Saeed Adel Ramadan</h1>

<p align="center">
  <b>.NET Backend Developer</b> — ASP.NET Core · C# · SQL Server · Entity Framework Core
</p>

<p align="center">
  Computer Engineering, The University of Jordan &nbsp;·&nbsp; Amman, Jordan &nbsp;·&nbsp; Open to Jordan &amp; GCC
</p>

<p align="center">
  <a href="mailto:saeed.ramadan.cv@gmail.com"><img src="https://img.shields.io/badge/Email-D14836?style=flat-square&logo=gmail&logoColor=white" alt="Email"/></a>
  <a href="https://www.linkedin.com/in/saeedramadan-dotnet"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=flat-square&logo=linkedin&logoColor=white" alt="LinkedIn"/></a>
  <img src="https://img.shields.io/badge/Open_to_work-2ea44f?style=flat-square" alt="Open to work"/>
</p>

---

I build **.NET web applications and ship them** — the projects below are running on live
public URLs right now, not sitting in a folder.

I graduated in Computer Engineering from the University of Jordan in January 2026 and
went deep on the Microsoft stack: C#, ASP.NET Core (Web API & MVC), Entity Framework Core
and SQL Server, with Angular, Docker and CI/CD around them. What I care about is the part that
doesn't show in a demo — validating input at the boundary, protecting every write path,
and putting a unique index behind the code that assumes uniqueness.

**Looking for:** a .NET / Backend Developer role where I can learn from an
experienced team and own real features. **In Kuwait for in-person interviews from early October 2026**; open across the GCC.

---

## 🚀 Live projects

### 📡 [NetWatch](https://github.com/saeedramadancv-sys/netwatch) — network &amp; service availability monitoring
[**▶ Try it live**](https://netwatch-rbmr.onrender.com) · ASP.NET Core 9 Web API · EF Core 9 · Identity + JWT · SignalR · Redis · Angular 19 · xUnit

My most complete project — built the way a production monitoring tool is built, with
every non-obvious decision documented in the code.

- **Clean Architecture** — Domain / Application / Infrastructure / Api, an Angular 19 SPA,
  and **100+ automated tests** (xUnit + Karma) enforced in a GitHub Actions CI pipeline.
- **Real authentication** — ASP.NET Core Identity + JWT with refresh-token rotation
  (SHA-256-hashed, single-use, whole-chain revocation on replay), lockout, and login
  responses that don't leak whether an email exists.
- **A real scheduler** — a `BackgroundService` on a drift-free `PeriodicTimer`, a DI scope
  per check, a `SemaphoreSlim` concurrency cap, and a debounced Down/Up state machine so
  one dropped packet never raises a false incident.
- **Provider-agnostic data** — EF Core 9 with separate SQLite / SQL Server migration
  assemblies; live updates pushed to the dashboard over SignalR; bilingual EN / AR (RTL).
- **Event-driven caching** — the dashboard summary is cached in Redis and retired the
  moment a probe changes state, not left to a TTL: a monitoring wall showing "all up"
  thirty seconds into an outage is worse than no wall at all. Cache failures cost
  latency, never availability.
- **Infrastructure as code** — a Bicep template provisioning App Service, Azure Cache for
  Redis and Azure SQL, with an OIDC-authenticated deployment workflow, plus Serilog
  structured logging throughout.

### 🔗 [ShortLink](https://github.com/saeedramadancv-sys/url-shortener) — URL shortener with click analytics
[**▶ Try it live**](https://url-shortener-cc59.onrender.com) · ASP.NET Core MVC (.NET 9) · EF Core 9 · SQL Server / SQLite · Docker

A full-stack URL shortener with a per-link analytics dashboard: a 14-day click time
series, top-referrer ranking and a recent-clicks log, aggregated with LINQ over a
normalized two-table schema.

- **Provider-agnostic data layer** — EF Core provider chosen at runtime from configuration.
  SQL Server in production, SQLite for a zero-setup local run, no code changes.
- **Security-first write paths** — anti-forgery (CSRF) tokens on every POST, server-side
  URL scheme allow-listing, regex-validated aliases, bounded untrusted input.
- **Collision-free codes** — a cryptographically secure RNG over a 56-character
  ambiguity-free alphabet (`0/O` and `1/l/I` removed), guarded by a unique index and a retry loop.
- **One-push deploys** — multi-stage Dockerfile (SDK build → slim ASP.NET runtime) plus an
  Infrastructure-as-Code blueprint.

### 🕌 [QuranVerse](https://github.com/saeedramadancv-sys/quranverse) — Arabic transcription &amp; verification engine
[**▶ Try it live**](https://saeedramadancv-sys.github.io/quranverse) · JavaScript (ES6+) · Web Audio API · PWA / Offline · Capacitor · GitHub Actions

My graduation project. Front-end lead on a two-person team — I designed and wrote the
entire client application, ~2,200 lines of dependency-free ES6 across 8 modules.

- **Levenshtein alignment engine** — O(n×m) dynamic programming with backtracking,
  classifying every word as match, substitution, deletion or insertion.
- **Arabic normalization pipeline** — 7 classes of orthographic variance (diacritics,
  tatweel, alef / ya / ta-marbuta / hamza), so undiacritized input scores fairly against
  diacritized Uthmani text.
- **Resilient REST layer** — timeouts, explicit status handling and response-shape
  validation, with automatic fallback to the local engine. The app stayed fully functional
  while the partner backend was still being built.
- **Works fully offline** — the complete Juz Amma corpus (37 surahs, 564 ayahs) bundled locally.

---

## 🔌 Digital design

### [verilog-digital-design](https://github.com/saeedramadancv-sys/verilog-digital-design) — RTL and verification
Verilog · VHDL · Icarus Verilog · GHDL · GTKWave · CI

Computer Engineering is where I started, and this is me coming back to it. A
parameterised ALU and a Moore finite state machine, written twice - once in
Verilog and once in VHDL - and held to the same test vectors.

- **Self-checking testbenches, not waveform-watching.** 51 assertions compare
  every output against an independently computed value and exit non-zero on
  failure, so both languages simulate in CI on every push.
- **Carry and overflow are kept separate**, because they answer different
  questions: `100 + 50` sets overflow with no carry, `-1 + 1` sets carry with
  none. Two test vectors exist only to pin that down.
- **One adder, not two.** Subtraction is `a + (~b) + 1`, so `ADD`, `SUB` and
  `SLT` share a single carry chain instead of inferring one each.
- **Overlapping detection.** After a match the FSM falls back to the longest
  suffix that is also a prefix of the pattern, so `1011011` yields two
  detections rather than one.

Every design decision is written up in
[docs](https://github.com/saeedramadancv-sys/verilog-digital-design/blob/main/docs/%D8%B4%D8%B1%D8%AD_%D8%A7%D9%84%D8%AA%D8%B5%D9%85%D9%8A%D9%85.md).

---

## 🛠 Tech

**Backend**

![C#](https://img.shields.io/badge/C%23-239120?style=flat-square&logo=csharp&logoColor=white)
![.NET](https://img.shields.io/badge/.NET_9-512BD4?style=flat-square&logo=dotnet&logoColor=white)
![ASP.NET Core](https://img.shields.io/badge/ASP.NET_Core_MVC-512BD4?style=flat-square&logo=dotnet&logoColor=white)
![EF Core](https://img.shields.io/badge/Entity_Framework_Core-512BD4?style=flat-square)
![REST](https://img.shields.io/badge/REST_APIs-005571?style=flat-square)
![SignalR](https://img.shields.io/badge/SignalR-512BD4?style=flat-square)
![JWT](https://img.shields.io/badge/JWT_Auth-000000?style=flat-square&logo=jsonwebtokens&logoColor=white)
![xUnit](https://img.shields.io/badge/xUnit-512BD4?style=flat-square)

**Data**

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=flat-square&logo=microsoftsqlserver&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=flat-square&logo=sqlite&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-CC2927?style=flat-square)
![Redis](https://img.shields.io/badge/Redis-DC382D?style=flat-square&logo=redis&logoColor=white)

**Hardware description**

![Verilog](https://img.shields.io/badge/Verilog-1A1A1A?style=flat-square)
![VHDL](https://img.shields.io/badge/VHDL-4B0082?style=flat-square)
![Quartus](https://img.shields.io/badge/Intel_Quartus-0071C5?style=flat-square&logo=intel&logoColor=white)
![ModelSim](https://img.shields.io/badge/ModelSim-005386?style=flat-square)
![GHDL](https://img.shields.io/badge/GHDL-2C3E50?style=flat-square)
![LTspice](https://img.shields.io/badge/LTspice-CC0000?style=flat-square)

**DevOps &amp; Tools**

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat-square&logo=githubactions&logoColor=white)
![Azure](https://img.shields.io/badge/Azure-0078D4?style=flat-square&logo=microsoftazure&logoColor=white)
![Bicep](https://img.shields.io/badge/Bicep-0078D4?style=flat-square)
![Serilog](https://img.shields.io/badge/Serilog-1F425F?style=flat-square)
![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white)
![Postman](https://img.shields.io/badge/Postman-FF6C37?style=flat-square&logo=postman&logoColor=white)
![Visual Studio](https://img.shields.io/badge/Visual_Studio-5C2D91?style=flat-square&logo=visualstudio&logoColor=white)

**Front-end**

![Angular](https://img.shields.io/badge/Angular_19-DD0031?style=flat-square&logo=angular&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black)
![Bootstrap](https://img.shields.io/badge/Bootstrap_5-7952B3?style=flat-square&logo=bootstrap&logoColor=white)
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=flat-square&logo=css3&logoColor=white)

_Also studied: Java, Python, C++, C · Computer Networks · Operating Systems · Computer Architecture_

---

## 🎓 Background

**B.Sc. Computer Engineering — The University of Jordan** · Graduated January 2026
Data Structures &amp; Algorithms · Database Systems · Object-Oriented Programming ·
Software Engineering · Operating Systems · Computer Networks · Computer Architecture

**Full-Stack .NET Developer, Intern — Tuned Applications, Amman** · Nov 2025 – Jan 2026
Delivered a full-stack ASP.NET Core MVC application to written specification over an
Entity Framework Core data layer on SQL Server, secured every non-public endpoint with
ASP.NET Core Identity sign-in and role-based authorization, and shipped each feature
inside a one-week Agile iteration across eight review cycles.

---

<p align="center">
  Arabic (native) · English (professional working proficiency)<br/>
  <b>Open to .NET / Backend Developer roles — Jordan &amp; GCC.</b><br/>
  <a href="mailto:saeed.ramadan.cv@gmail.com">saeed.ramadan.cv@gmail.com</a>
</p>
