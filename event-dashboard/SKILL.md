---
name: event-dashboard
description: >
  Display a cross-event status dashboard for all tracked B2B SaaS events. Shows each event's phase,
  overdue milestones, upcoming deadlines, and budget status. Reads from the local events data store.
  Use when someone says "event dashboard", "show events", "event status", "what events do we have",
  "how are our events going", or wants a cross-event overview. Also useful for weekly event check-ins.
---

<event-dashboard>

# Event Dashboard Skill

Read-only skill that presents a cross-event status view. No intake questions needed.

## Workflow

### Step 1: Scan Events

1. List all directories in `~/.claude/data/events/`
2. If no events exist, print: "No events tracked yet. Run `/event-evaluate` to evaluate your first event, or `/event-plan` to plan one you've already committed to."

### Step 2: Read Event Data

For each event directory, read:
- `event-info.md` — YAML frontmatter for: name, dates, location, budget, company, primary goal
- `status.md` — YAML frontmatter for: phase, last_updated. Read the milestone table and next actions.

**Phase inference** (fallback if status.md is missing or has no phase):
- `debrief.md` exists → "Follow-up"
- `brief.md` exists → "Briefed"
- `plan.md` exists → "Planning"
- `evaluation.md` exists → "Evaluated"
- Only `event-info.md` → "New"

### Step 3: Calculate Status

For each event:
1. **Days until/since event:** Calculate from `event-info.dates.start` relative to today
2. **Current phase:** From `status.md` or inferred
3. **Overdue milestones:** Any milestone in `status.md` where status != "Done" and due date < today
4. **Next action due:** First milestone or action that is "Not Started" or "In Progress"
5. **Phase health:**
   - "On Track" — no overdue milestones
   - "At Risk" — 1-2 overdue milestones
   - "Overdue" — 3+ overdue milestones or critical milestone missed
   - "Needs Attention" — event date has passed but no debrief.md exists

### Step 4: Present Dashboard

Sort events by priority: overdue items first, then by proximity (nearest event date first), then completed events last.

**Format:**

```markdown
## Event Dashboard — {Today's Date}

### Active Events

| Event | Date | Days Away | Phase | Health | Next Action | Due |
|-------|------|-----------|-------|--------|-------------|-----|
| {Name} | {Date range} | {N days} | {Phase} | {Health} | {Next action} | {Due date} |
| ... | | | | | | |

### Overdue Items
{For each event with overdue milestones:}
- **{Event Name}**: {Milestone} was due {date} ({N days ago}). {Suggested action — e.g., "Run `/event-brief` to build the team briefing."}

### Upcoming Milestones (Next 14 Days)
{Across all events, sorted by date:}
1. {Date} — {Event Name}: {Milestone}
2. {Date} — {Event Name}: {Milestone}
3. ...

### Budget Summary (if budget data available)
| Event | Budgeted | Notes |
|-------|----------|-------|
| {Name} | ${Budget} | {Phase — e.g., "Planning, 8 weeks out"} |
| ... | | |

### Completed Events (Last 90 Days)
{Events with debrief.md and event dates in the past:}
| Event | Date | Pipeline-to-Cost | Notes |
|-------|------|------------------|-------|
| {Name} | {Date} | {Ratio if available} | {Status — e.g., "ROI report pending"} |
```

### Step 5: Suggest Actions

Based on the dashboard, suggest the most impactful next action:

- If an event has passed with no debrief: "**{Event Name}** ended {N days ago} — run `/event-debrief` before leads go cold."
- If an event is 1-2 weeks out with no brief: "**{Event Name}** is {N days away} — run `/event-brief` to build the team briefing."
- If an event is evaluating but the event is less than 8 weeks out: "**{Event Name}** is still in evaluation with only {N weeks} until the event. Decide soon or you won't have enough time to plan."
- If no events are tracked: "No events in the pipeline. Run `/event-evaluate` to assess an upcoming conference."

### Handling Edge Cases

**Event with only event-info.md (no status.md):**
- Show as "New" phase, "—" for health
- Suggest: "Run `/event-evaluate` or `/event-plan` to get started."

**Event with dates in the past and no debrief:**
- Show as "Needs Attention"
- Flag: "This event happened {N days ago}. Follow-up leads go cold fast — run `/event-debrief` now."

**Event with debrief but ROI report not yet filled in:**
- Show as "Follow-up (ROI pending)"
- If 30+ days since event: "It's been {N days} — time to fill in the ROI report."

**No events directory exists:**
- Create it: `mkdir -p ~/.claude/data/events`
- Print the "no events" message with guidance

</event-dashboard>
