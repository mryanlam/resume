// Resume in Typst (recreated from LaTeX res.cls + resume.tex)

#set document(
  title: "Matthew Lam - Resume",
  author: "Matthew Lam",
)

#set page(
  paper: "us-letter",
  margin: 1in,
  numbering: none,
)

#set text(
  font: "Source Sans 3",
  size: 10pt,
  lang: "en",
)

#set par(
  justify: true,
  leading: 0.54em,
  spacing: 1.25em,
)

#set list(
  indent: 0pt,
  body-indent: 0.65em,
  spacing: 0.85em,
)

// Letterspaced small caps matching LaTeX \sc \lsstyle (microtype letterspace=85)
#let sc(body) = text(tracking: 0.085em, smallcaps(body))

#show heading.where(level: 1): it => text(
  size: 10pt,
  weight: "regular",
  sc(it.body),
)

// Left-margin section layout matching \documentclass[margin]{res} with \newsectionwidth{0.8in}
#let section(title, body) = block(
  above: 1.65em,
  below: 1.65em,
  grid(
    columns: (0.8in, 1fr),
    align(left, heading(level: 1, title)),
    body,
  ),
)

// Resume entry helper for work, internships, and education
#let entry(
  organization,
  url: none,
  dates: none,
  title: none,
  subtitle: none,
  location: none,
  ..body,
) = block(
  above: 1.35em,
  below: 1.35em,
  {
    let org = strong(organization)
    if url != none {
      org = link(url, org)
    }

    let has-subroles = title == none and subtitle == none and body.pos().len() > 0

    // Header lines inside a non-breakable block so titles aren't orphaned from bullets
    block(
      breakable: false,
      below: if has-subroles { 0.54em } else if body.pos().len() > 0 { 0.55em } else { 0pt },
      {
        org
        if location != none {
          h(1fr)
          location
        } else if title == none and dates != none {
          h(1fr)
          sc(dates)
        }
        if title != none {
          linebreak()
          emph(title)
          if dates != none {
            h(1fr)
            sc(dates)
          }
        }
        if subtitle != none {
          linebreak()
          subtitle
          if title == none and location != none and dates != none {
            h(1fr)
            sc(dates)
          }
        }
      },
    )

    for b in body.pos() {
      b
    }
  },
)

// Sub-role helper for multiple teams/roles under the same organization
#let role(
  title,
  dates: none,
  ..body,
) = block(
  above: 0pt,
  below: 0.9em,
  {
    block(
      breakable: false,
      below: if body.pos().len() > 0 { 0.55em } else { 0pt },
      {
        emph(title)
        if dates != none {
          h(1fr)
          sc(dates)
        }
      },
    )

    for b in body.pos() {
      b
    }
  },
)

// --- Header ---

#block(below: 2.6em, {
  text(size: 14.4pt, weight: "bold")[Matthew Lam]
  v(6mm, weak: true)
  sc({
    // link("https://mryanlam.com")[https://mryanlam.com]
    // h(1fr)
    link("mailto:matt@mryanlam.com")[matt\@mryanlam.com]
    h(1fr)
    [253-237-4129]
    h(1fr)
    [New York, NY]
    // linebreak()
    // link("https://github.com/dllu")[https://github.com/dllu]
  })
})

// --- Sections ---

#section("work")[
  #entry(
    "Google",
    url: "https://about.google/",
    location: "New York, NY",
  )[
    #role(
      [Software Engineer, SRE --- Core Hybrid Developer SRE],
      dates: [2026/10 -- present],
    )[
      - Developing reusable AI agent skills and automated incident triage workflows to streamline alert diagnostics and root-cause analysis for an internal container and remote execution platform.
      // TODO: Add service reliability/launch details and measurable impact once on-call begins.
    ]

    #role(
      [Software Engineer, SRE --- Corp Compute and Storage SRE],
      dates: [2022/02 -- 2026/10],
    )[
      - Architected and implemented provisioning, resizing, and deletion APIs and backend lifecycle workflows in Python for an internal Compute Service.
      - Developed custom Terraform Providers (Go, Terraform Plugin Framework & SDKv2) and CLI to enable self-service Infrastructure-as-Code (IaC) management of corporate VM infrastructure.
      - Designed and implemented a Kubernetes authorization webhook service in Golang to enforce corporate RBAC policies, with automated deployment pipelines, monitoring, and alerting for high availability on the API server critical path.
    ]
  ]

  #entry(
    "Oracle Cloud Infrastructure",
    url: "https://www.oracle.com/cloud/",
    dates: [2020/01 -- 2022/02],
    title: [Senior Member of Technical Staff --- Developer Services Analytics],
    location: "Seattle, WA",
  )[
    - Built an internal analytics service in Python and Java to ingest and aggregate OCI API telemetry, providing vital usage insights and executive reporting for leadership.
    - Re-architected the ingestion pipeline from a cron-based scheduler to an asynchronous distributed message queue using the competing consumer pattern, eliminating processing bottlenecks and enabling horizontal worker scaling.
    - Automated end-to-end infrastructure and deployments to Oracle Kubernetes Engine (OKE) using Terraform and Helm, instrumenting full observability with OCI Monitoring, Alarming, and Logging.
  ]

  #entry(
    "F5 Networks",
    url: "https://www.f5.com/",
    dates: [2016/03 -- 2020/01],
    title: [Software Engineer III --- Rapid Development Team],
    location: "Seattle, WA",
  )[
    - Debugged customer-facing production issues and implemented C fixes in BIG-IP's Traffic Management Microkernel (TMM), improving data-plane stability and resolving critical defects.
    - Designed and implemented a core dump management feature for BIG-IP, retaining multiple crash dumps with storage caps to preserve critical diagnostic traces during crash loops while preventing disk saturation.
    - Built a Python data pipeline to ingest, synchronize, and write bug data to a database for the customer-facing F5 Bug Tracker, enabling self-service status checks and deflecting support tickets.
    - Built automated Python tooling to generate the public F5 Log Messages Reference, publishing conditions, operational impacts, and remediation guidance for system log events.
    - Contributed to the official F5 Ansible collection by developing the bigip\_device\_dns and bigip\_hostname modules to automate network device configuration management.
  ]
]

#section("intern")[
  #entry(
    "F5 Networks",
    dates: [2015/06 -- 2016/03],
    title: [Rapid Development Team],
    location: "Seattle, WA",
  )
  // [
  //   - Researched security vulnerabilities and how they affect the BIG-IP platform.
  //   - Developed Proof of Concept for F5 Bug Tracker using Python-Flask and MSSQL.
  //   - Developed various scripts that interface with Perforce, Bugzilla, and MSSQL in Perl.
  // ]

  #entry(
    "GoldSim Technology Group",
    dates: [2013/06 -- 2013/09],
    title: [Intern],
    location: "Issaquah, WA",
  )
  // [
  //   - Automated and Manual testing of GoldSim software
  // ]
]

#section("school")[
  #entry(
    "Western Washington University",
    dates: [2011 -- 2015],
    subtitle: [Computer Science, BS],
  )
]

// #section("skills")[
//   *Languages:* Python, Java, Golang \
//   *Technologies:* Ansible, Docker, Flask, GDB, Helm, Kubernetes, Networking, REST API, Linux
// ]

#align(right, text(size: 9pt, sc[updated #datetime.today().display("[year]-[month]-[day]")]))
