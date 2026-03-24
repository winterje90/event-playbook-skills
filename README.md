# B2B SaaS Event Playbook — Claude Code Skills

A suite of 5 Claude Code skills that help B2B SaaS companies run better events. Covers the full lifecycle: evaluating whether to attend, planning the event, briefing the team, executing post-event follow-up, and tracking everything across multiple concurrent events.

Built for marketing teams at early-stage B2B SaaS companies who need a repeatable system for events but don't have a dedicated events person.

## What's Inside

| Skill | Command | When to Use |
|-------|---------|-------------|
| **Event Evaluate** | `/event-evaluate` | "Should we do this event?" — Scores across 6 dimensions, runs break-even math, produces a go/no-go recommendation |
| **Event Plan** | `/event-plan` | "We're committed, plan everything" — 12-week countdown, budget, outreach sequences, MOPS setup, booth strategy |
| **Event Brief** | `/event-brief` | "Event is next week" — Team briefing doc, 60-second talk track, coverage schedule, lead scoring, demo script |
| **Event Debrief** | `/event-debrief` | "We're back" — Follow-up sequences by lead tier, routing rules, SLAs, debrief agenda, 30-day ROI report |
| **Event Dashboard** | `/event-dashboard` | "Show me all events" — Cross-event status view, overdue items, upcoming milestones, budget summary |

## How It Works

Each skill asks intake questions about your company and event, then generates:

- **Local markdown files** in `~/.claude/data/events/{event-name}/` — the source of truth for each event
- **Google Docs** — shareable plans, briefs, and playbooks for the team (requires gws CLI)
- **Google Sheets** — budget trackers and ROI reports with formulas (requires gws CLI)

Events are tracked independently. You can run multiple events concurrently — planning for one while debriefing another — and the dashboard shows status across all of them.

## Installation

### Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and configured
- (Optional) [gws CLI](https://github.com/nicholasgasior/gws) for Google Docs and Sheets output

### Install the Skills

Clone this repo and copy the skill directories into your Claude Code skills folder:

```bash
git clone https://github.com/winterje90/event-playbook-skills.git
cp -r event-playbook-skills/event-evaluate ~/.claude/skills/
cp -r event-playbook-skills/event-plan ~/.claude/skills/
cp -r event-playbook-skills/event-brief ~/.claude/skills/
cp -r event-playbook-skills/event-debrief ~/.claude/skills/
cp -r event-playbook-skills/event-dashboard ~/.claude/skills/
```

Create the data directory:

```bash
mkdir -p ~/.claude/data/events
```

That's it. The skills will appear in your Claude Code session immediately.

### One-Liner Install

```bash
git clone https://github.com/winterje90/event-playbook-skills.git && \
cp -r event-playbook-skills/event-{evaluate,plan,brief,debrief,dashboard} ~/.claude/skills/ && \
mkdir -p ~/.claude/data/events && \
rm -rf event-playbook-skills && \
echo "Done. Skills installed."
```

### Google Docs/Sheets Setup (Optional)

If you want the skills to generate shareable Google Docs and Sheets, install and authenticate the gws CLI:

```bash
npm install -g @googleworkspace/cli
gws auth login -s drive,docs,sheets
```

The skills will work without gws — you just won't get the Google Docs/Sheets output. All content is also saved as local markdown files.

## Usage

### Typical Workflow

```
/event-evaluate    →    /event-plan    →    /event-brief    →    /event-debrief
  "Should we go?"     "Plan everything"   "Get us ready"      "We're back"
  (12+ weeks out)     (8-12 weeks out)    (1-2 weeks out)     (day 1-30 after)
```

Run `/event-dashboard` at any time to see status across all your events.

### Example: Evaluating an Event

Just tell Claude about the event:

```
Should we do SaaStr Annual 2026?
```

or

```
/event-evaluate
```

The skill will ask you about:
- The event (name, dates, type, size)
- Your company (ACV, ICP, sales cycle)
- Event fit (audience overlap, budget, goals, competitors)

Then it scores the event across 6 dimensions and tells you whether to go.

### Example: Planning an Event

```
We're committed to SaaStr Annual — build the plan
```

or

```
/event-plan
```

Generates a master plan with:
- 12-week countdown with milestones and owners
- Budget breakdown with line items
- Target account list building guide
- 6-touch pre-event outreach sequence (email + LinkedIn templates)
- MOPS/CRM setup checklist (Salesforce, HubSpot, or Pipedrive)
- Booth strategy, swag recommendations, side event planning

### Example: Post-Event

```
We just got back from SaaStr — help us follow up
```

or

```
/event-debrief
```

Generates:
- 48-hour sprint checklist (lead upload, assignment, first touches)
- Follow-up email sequences by lead tier (hot/warm/cold)
- Lead routing rules and SLAs
- Debrief meeting agenda
- 30-day ROI report template

## File Structure

```
~/.claude/skills/
├── event-evaluate/
│   ├── SKILL.md                              # Skill definition and workflow
│   └── references/
│       ├── evaluation-criteria.md            # 6-dimension scoring rubric
│       └── budget-benchmarks.md              # ACV-based budget guardrails and ROI formulas
├── event-plan/
│   ├── SKILL.md
│   └── references/
│       ├── master-plan-template.md           # 12-week countdown framework
│       ├── outreach-sequences.md             # 6-touch email + LinkedIn templates
│       ├── mops-checklist.md                 # CRM/MAP setup by platform
│       └── booth-and-logistics.md            # Booth design, swag, side events
├── event-brief/
│   ├── SKILL.md
│   └── references/
│       ├── talk-track-framework.md           # 60-second booth talk track
│       └── brief-template.md                 # Coverage schedule, lead scoring, huddle agenda
├── event-debrief/
│   ├── SKILL.md
│   └── references/
│       ├── follow-up-sequences.md            # Hot/warm/cold email sequences
│       ├── lead-disposition.md               # Manual vs. MAP routing, SLAs
│       └── roi-template.md                   # 30-day metrics and benchmarks
└── event-dashboard/
    └── SKILL.md

~/.claude/data/events/                        # Auto-created per event
└── {event-slug}/
    ├── event-info.md                         # Event metadata (YAML frontmatter)
    ├── status.md                             # Current phase, milestones, next actions
    ├── evaluation.md                         # Scored analysis
    ├── plan.md                               # Master plan
    ├── brief.md                              # Team briefing
    └── debrief.md                            # Follow-up plan + ROI
```

## What's in the Reference Files

The reference files contain the deep knowledge that makes the skills useful — not generic checklists, but opinionated frameworks grounded in how B2B SaaS companies actually run events.

| File | What's Inside |
|------|--------------|
| `evaluation-criteria.md` | 6-dimension scoring rubric (1-5 per dimension), anti-patterns to flag (vanity events, FOMO events, CEO pet events) |
| `budget-benchmarks.md` | Line item ranges by event type, ACV-based guardrails, break-even formulas, pipeline-to-cost ratio targets |
| `master-plan-template.md` | Week-by-week milestones with owners, late-start adjustments (what to cut at 8/6/4/2 weeks) |
| `outreach-sequences.md` | 6-touch pre-event cadence with ready-to-use email and LinkedIn templates, response handling, BDR vs. AE assignment |
| `mops-checklist.md` | CRM campaign setup (Salesforce, HubSpot, Pipedrive), MAP configuration, lead scoring adjustments, lead capture options |
| `booth-and-logistics.md` | Booth messaging hierarchy, equipment checklist, swag recs by budget, engagement tactics, exhibitor manual review, side event planning |
| `talk-track-framework.md` | 60-second structure (Hook → Qualify → Bridge → Proof → Next Step), variants for anchors/floaters/execs, practice protocol |
| `brief-template.md` | Coverage schedule grid, 1-4 lead scoring rubric, daily huddle agenda, same-day follow-up protocol, demo scripts by length, competitor handling |
| `follow-up-sequences.md` | 3 tiers of post-event sequences (hot: 3 touches/7 days, warm: 5 touches/14 days, cold: 3 automated/21 days) with templates |
| `lead-disposition.md` | Manual vs. MAP decision tree, routing rules by account status, SLA targets, 30-day follow-up calendar |
| `roi-template.md` | Investment, activity, and pipeline metrics with formulas, 5-day debrief agenda, benchmarks, go/no-go framework for next year |

## Customization

The skills are designed for B2B SaaS companies but the reference files can be edited to match your specific context:

- **Adjust budget benchmarks** in `budget-benchmarks.md` for your market
- **Customize outreach templates** in `outreach-sequences.md` with your company's voice
- **Modify lead scoring** in `brief-template.md` to match your qualification criteria
- **Update CRM instructions** in `mops-checklist.md` for your specific platform setup

## Credits

Built by [James Winter](https://www.linkedin.com/in/jameswinter/) at [Telescope Partners](https://www.telescopepartners.com/). Informed by the [vFairs Trade Show Exhibitor Checklist](https://www.vfairs.com/) and years of helping B2B SaaS companies run events that actually generate pipeline.

## License

MIT
