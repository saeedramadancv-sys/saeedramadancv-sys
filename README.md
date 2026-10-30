<h1 align="center">Saeed Ramadan</h1>

<p align="center">
  .Net Developer · Amman, Jordan<br/>
  Computer Engineering, University of Jordan (graduated January 2026)
</p>

<p align="center">
  <a href="mailto:saeed.ramadan.cv@gmail.com"><img src="https://img.shields.io/badge/Email-D14836?style=flat-square&logo=gmail&logoColor=white" alt="Email"/></a>
  <a href="https://www.linkedin.com/in/saeedramadan-dotnet"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=flat-square&logo=linkedin&logoColor=white" alt="LinkedIn"/></a>
  <img src="https://img.shields.io/badge/Open_to_work-2ea44f?style=flat-square" alt="Open to work"/>
</p>

I mostly write C# and ASP.NET Core, with SQL Server and EF Core underneath and Angular on top
when a project needs a UI. Two of the backend projects below are live, so you can click around
instead of taking my word for it.

I'm looking for a .Net Developer role, or an internship, in Amman, and I can start right
away. My degree is in Computer Engineering, so I also like the network side of things, and
TechNova below is where that shows.

## Projects

### [NetWatch](https://github.com/saeedramadancv-sys/netwatch): network and service monitoring · Jul 2026
[Try it live](https://netwatch-rbmr.onrender.com) (press **Try the demo** for read-only access) · ASP.NET Core 9 · EF Core 9 · Identity + JWT · SignalR · Redis · Angular 19 · xUnit

My biggest project. You add devices (routers, servers, websites), attach ping, TCP or HTTP
checks, and watch status, response times and incidents update live. It works in English and
Arabic.

- Clean Architecture backend and an Angular 19 front end, with 147 automated tests (128 xUnit +
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

### [ShortLink](https://github.com/saeedramadancv-sys/url-shortener): URL shortener with click stats · Internship training project at Tuned Applications, Nov 2025 – Apr 2026
[Try it live](https://url-shortener-cc59.onrender.com) · ASP.NET Core MVC (.NET 9) · EF Core 9 · SQL Server / SQLite · Docker

Shortens links and shows how each one gets used: clicks over the last 14 days, top referrers and
the latest clicks.

- The database provider is a config setting: SQL Server by default, SQLite with one switch. The
  live demo runs on SQLite.
- Every form has CSRF protection, links are checked against a list of allowed schemes, and custom
  aliases are validated.
- Short codes come from a cryptographic random generator over a 57-character alphabet with the
  look-alikes removed (`0/O`, `1/l/I`), and a unique index backs that up.
- 11 integration tests on a real SQLite database, run by GitHub Actions.
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

## Networking

### [TechNova network design](https://github.com/saeedramadancv-sys/technova-network-design) · Aug 2026
Cisco IOS · OSPFv2 · VLSM · VLANs · NAT/PAT · ACLs

A network design for a made-up company with a head office in Amman and branches in Irbid and
Aqaba. It's a design on paper: the nine IOS configurations and a 60-case test plan are ready,
but I haven't built it in Packet Tracer yet.

- Every address comes from one `172.16.0.0/16` block using VLSM, so each site is one
  contiguous range.
- Multi-area OSPFv2 with MD5 authentication and summarisation at the area border.
- Each of the 60 test cases names the command to run and the exact output to expect.

## Hardware

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

**Backend:** C#, .NET 9, ASP.NET Core (MVC and Web API), EF Core, REST, SignalR, JWT, xUnit

**Data:** SQL Server, T-SQL, SQLite, Redis

**Networking:** Cisco IOS, OSPFv2, VLSM, VLANs and 802.1Q, NAT/PAT, ACLs, Packet Tracer

**DevOps and tools:** Docker, GitHub Actions, Serilog, Prometheus, Git, Visual Studio

**Front end:** Angular 19, TypeScript, JavaScript, Bootstrap 5, HTML, CSS

**Hardware:** Verilog, VHDL, Icarus Verilog, GHDL

## Background

**B.Sc. Computer Engineering, University of Jordan**, graduated January 2026. The courses I use
most: data structures and algorithms, databases, OOP, operating systems and computer networks.

**Independent developer, Amman** · Jul 2026 to now. SlotLock, NetWatch and the two engineering
projects above.

**Full-Stack .NET Developer (Intern), Tuned Applications, Amman** · Nov 2025 to Apr 2026. I built
a full ASP.NET Core MVC app from a written spec on EF Core and SQL Server, and added sign-in and
role-based access with ASP.NET Core Identity. ShortLink was my training project there. We worked in one-week iterations with code review
on everything.

<p align="center">
  Arabic (native) · English (professional working proficiency)<br/>
  saeed.ramadan.cv@gmail.com
</p>
