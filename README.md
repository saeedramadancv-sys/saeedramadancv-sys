<h1 align="center">Saeed Ramadan</h1>

<p align="center">
  .NET backend developer · Amman, Jordan<br/>
  Computer Engineering, University of Jordan (graduated January 2026)
</p>

<p align="center">
  <a href="mailto:saeed.ramadan.cv@gmail.com"><img src="https://img.shields.io/badge/Email-D14836?style=flat-square&logo=gmail&logoColor=white" alt="Email"/></a>
  <a href="https://www.linkedin.com/in/saeedramadan-dotnet"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=flat-square&logo=linkedin&logoColor=white" alt="LinkedIn"/></a>
  <img src="https://img.shields.io/badge/Open_to_work-2ea44f?style=flat-square" alt="Open to work"/>
</p>

I mostly write C# and ASP.NET Core, with SQL Server and EF Core underneath and Angular on top
when a project needs a UI. Three of the projects below are live, so you can click around
instead of taking my word for it.

I'm looking for a junior .NET or backend role in Amman or the UAE, and I can start right away
(I'm eligible for the UAE job-seeker visa). I'm also studying for the CCNA, so a junior network
role interests me too.

## Projects

### [SlotLock](https://github.com/saeedramadancv-sys/slotlock): booking API · Sep 2026
[![CI](https://github.com/saeedramadancv-sys/slotlock/actions/workflows/ci.yml/badge.svg)](https://github.com/saeedramadancv-sys/slotlock/actions/workflows/ci.yml) · ASP.NET Core 9 · EF Core 9 · SQL Server · xUnit · Serilog · Prometheus

A booking API built around one problem: two people trying to book the last seat at the same
moment. Counting bookings and inserting one more if there's room passes every test you write by
hand, and then oversells the first time two requests arrive together. I wanted a version that
doesn't.

- I sent 50 requests for one seat at the same time. 1 booking went through, 49 got a conflict,
  and the database agreed.
- The seat count lives on the slot row with a SQL Server `rowversion`, so a stale write updates
  nothing and retries against fresh data. A `CHECK` constraint refuses an oversell if that ever
  fails.
- Retrying a request is safe. An `Idempotency-Key` is claimed through a unique index before any
  work runs, so two retries can't both go through.
- Holds expire, and an expired hold can't be confirmed even if the cleanup job hasn't run yet.
- Notifications go through a transactional outbox, so nothing goes out for a booking that rolled
  back.
- 85 tests, 25 of them against a real SQL Server. The in-memory provider has no rowversion or
  CHECK constraints, and those are exactly what I needed to test.
- The README writes up three bugs the tests caught. My favourite: `"24:00:00"` in appsettings
  means 24 days, not 24 hours.

### [NetWatch](https://github.com/saeedramadancv-sys/netwatch): network and service monitoring · Jul 2026
[Try it live](https://netwatch-rbmr.onrender.com) · ASP.NET Core 9 · EF Core 9 · Identity + JWT · SignalR · Redis · Angular 19 · xUnit

My biggest project. You add devices (routers, servers, websites), attach ping, TCP or HTTP
checks, and watch status, response times and incidents update live. It works in English and
Arabic.

- Clean Architecture backend and an Angular 19 front end, with 144 automated tests (125 xUnit +
  19 Karma) running in GitHub Actions.
- Login uses ASP.NET Core Identity and JWT. Refresh tokens are hashed and single-use, and reusing
  one revokes the whole chain.
- Checks run in a `BackgroundService` on a `PeriodicTimer`, with a limit on how many run at once.
  A device is only marked down after several failures in a row, so one lost packet doesn't open
  an incident.
- The dashboard summary is cached in Redis and cleared the moment a probe changes state, instead
  of waiting for a timeout. A monitoring screen that says "all up" during an outage is worse than
  no screen.
- There's also a Bicep template for Azure. I haven't deployed it yet; the live demo runs on Render.

### [ShortLink](https://github.com/saeedramadancv-sys/url-shortener): URL shortener with click stats · Jul 2026
[Try it live](https://url-shortener-cc59.onrender.com) · ASP.NET Core MVC (.NET 9) · EF Core 9 · SQL Server / SQLite · Docker

Shortens links and shows how each one gets used: clicks over the last 14 days, top referrers and
the latest clicks.

- The database provider is a config setting: SQL Server by default, SQLite with one switch. The
  live demo runs on SQLite.
- Every form has CSRF protection, links are checked against a list of allowed schemes, and custom
  aliases are validated.
- Short codes come from a cryptographic random generator over a 57-character alphabet with the
  look-alikes removed (`0/O`, `1/l/I`), and a unique index backs that up.
- Packaged with a multi-stage Dockerfile.

### [QuranVerse](https://github.com/saeedramadancv-sys/quranverse): recitation checker · graduation project · Sep 2025 – Jan 2026
[Try it live](https://saeedramadancv-sys.github.io/quranverse) · JavaScript · PWA · Capacitor · GitHub Actions

My graduation project at the University of Jordan. You recite or type a passage from Juz' Amma
and it compares it word by word with the Quran text, marking each word as right, wrong, missing
or extra.

- We were a team of two. I led the front end and wrote the whole client in plain JavaScript.
- The matching is a word-level Levenshtein alignment, with Arabic text cleanup first, so missing
  diacritics or different letter forms don't count as mistakes.
- The text of Juz' Amma (37 surahs, 564 ayahs) ships with the app, so checking typed text works
  offline. Voice input uses the browser's speech recognition, which needs a connection.

## The computer engineering side

### [TechNova network design](https://github.com/saeedramadancv-sys/technova-network-design) · Aug 2026
Cisco IOS · OSPFv2 · VLSM · VLANs · NAT/PAT · ACLs

A network design for a made-up company with a head office in Amman and branches in Irbid and
Aqaba. It's a design on paper: the nine IOS configurations and a 60-case test plan are ready,
but I haven't built it in Packet Tracer yet.

- Every address comes from one `172.16.0.0/16` block using VLSM, so each site is one
  contiguous range.
- Multi-area OSPFv2 with MD5 authentication and summarisation at the area border.
- Each of the 60 test cases names the command to run and the exact output to expect.

### [verilog-digital-design](https://github.com/saeedramadancv-sys/verilog-digital-design) · Sep 2026
Verilog · VHDL · Icarus Verilog · GHDL · CI

Going back to the hardware half of my degree. A parameterised ALU (8-bit by default) written
twice, once in Verilog and once in VHDL-2008, both held to the same test vectors, plus a Moore
state machine that detects the pattern 1011.

- 72 self-checking checks run in CI on every push.
- Carry and overflow are separate flags, with test cases just for the difference: `100 + 50`
  overflows without a carry, and `-1 + 1` carries without overflowing.
- The state machine handles overlaps, so `1011011` gives two detections.

## Tech

**Backend**

![C#](https://img.shields.io/badge/C%23-239120?style=flat-square&logo=csharp&logoColor=white)
![.NET](https://img.shields.io/badge/.NET_9-512BD4?style=flat-square&logo=dotnet&logoColor=white)
![ASP.NET Core](https://img.shields.io/badge/ASP.NET_Core_MVC-512BD4?style=flat-square&logo=dotnet&logoColor=white)
![EF Core](https://img.shields.io/badge/Entity_Framework_Core-512BD4?style=flat-square)
![REST](https://img.shields.io/badge/REST_APIs-005571?style=flat-square)
![SignalR](https://img.shields.io/badge/SignalR-512BD4?style=flat-square)
![JWT](https://img.shields.io/badge/JWT_Auth-000000?style=flat-square&logo=jsonwebtokens&logoColor=white)
![xUnit](https://img.shields.io/badge/xUnit-512BD4?style=flat-square)
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=flat-square&logo=prometheus&logoColor=white)

**Data**

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=flat-square&logo=microsoftsqlserver&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=flat-square&logo=sqlite&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-CC2927?style=flat-square)
![Redis](https://img.shields.io/badge/Redis-DC382D?style=flat-square&logo=redis&logoColor=white)

**Networking**

![Cisco IOS](https://img.shields.io/badge/Cisco_IOS-1BA0D7?style=flat-square&logo=cisco&logoColor=white)
![OSPF](https://img.shields.io/badge/OSPFv2-1BA0D7?style=flat-square)
![VLSM](https://img.shields.io/badge/VLSM_%2F_Subnetting-1BA0D7?style=flat-square)
![VLAN](https://img.shields.io/badge/VLANs_%2F_802.1Q-1BA0D7?style=flat-square)
![NAT](https://img.shields.io/badge/NAT_%2F_PAT-1BA0D7?style=flat-square)
![Packet Tracer](https://img.shields.io/badge/Packet_Tracer-1BA0D7?style=flat-square&logo=cisco&logoColor=white)

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
![Bicep](https://img.shields.io/badge/Bicep-0078D4?style=flat-square)
![Serilog](https://img.shields.io/badge/Serilog-1F425F?style=flat-square)
![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white)
![Visual Studio](https://img.shields.io/badge/Visual_Studio-5C2D91?style=flat-square&logo=visualstudio&logoColor=white)

**Front-end**

![Angular](https://img.shields.io/badge/Angular_19-DD0031?style=flat-square&logo=angular&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black)
![Bootstrap](https://img.shields.io/badge/Bootstrap_5-7952B3?style=flat-square&logo=bootstrap&logoColor=white)
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=flat-square&logo=css3&logoColor=white)

_Also studied: Java, Python, C++, C · Computer Networks · Operating Systems · Computer Architecture_

## Background

**B.Sc. Computer Engineering, University of Jordan**, graduated January 2026. The courses I use
most: data structures and algorithms, databases, OOP, operating systems and computer networks.

**Independent developer, Amman** · Jul 2026 to now. SlotLock, NetWatch and the two engineering
projects above.

**Full-Stack .NET Developer (Intern), Tuned Applications, Amman** · Nov 2025 to Apr 2026. I built
a full ASP.NET Core MVC app from a written spec on EF Core and SQL Server, and added sign-in and
role-based access with ASP.NET Core Identity. We worked in one-week iterations with code review
on everything.

<p align="center">
  Arabic (native) · English (professional working proficiency)<br/>
  saeed.ramadan.cv@gmail.com
</p>
