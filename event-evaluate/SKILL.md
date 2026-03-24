---
name: event-evaluate
description: >
  Evaluate whether a B2B SaaS company should attend a specific event. Scores the event across 6 dimensions
  (ICP density, budget ratio, content opportunity, competitive landscape, timing, strategic value),
  calculates break-even pipeline math, and produces a go/no-go recommendation.
  Use when someone asks "should we do this event?", "is this event worth it?", "evaluate this conference",
  "should we sponsor?", or is deciding between events.
---

<event-evaluate>

# Event Evaluation Skill

Evaluate whether attending a specific event is worth the investment. Produces a scored analysis with a clear recommendation.

## Workflow

### Step 1: Intake

Ask these questions to understand the event and company context. Use AskUserQuestion with multiple choice where indicated.

**Event details:**
1. What's the event name? (And URL if you have it) — free text
2. When is it? — free text (dates)
3. Where is it? — free text (city/venue)

**Event type** (multiple choice):
- Major conference (5,000+ attendees)
- Mid-size conference (1,000-5,000)
- Small/niche event (under 1,000)
- Hosted event (your own dinner/happy hour/workshop)

**Company context:**
4. What's your company name? — free text
5. What's your ACV? (multiple choice):
   - Under $10K
   - $10K-$50K
   - $50K-$150K
   - $150K+
6. Describe your ICP in one sentence — free text
7. How long is your typical sales cycle? (multiple choice):
   - Under 30 days
   - 30-90 days
   - 90-180 days
   - 180+ days

**Event fit:**
8. How well does the attendee profile match your ICP? (multiple choice):
   - Our core ICP will be densely represented
   - Some overlap, but not primarily our buyers
   - Unclear — we need to investigate
9. What's your estimated total budget for this event? (multiple choice):
   - Under $10K (attending only, no booth)
   - $10K-$25K (small booth or sponsorship)
   - $25K-$75K (mid-tier sponsorship + travel)
   - $75K-$150K (major sponsorship)
   - $150K+
10. How many people would you send? (multiple choice):
    - 1-2 people
    - 3-5 people
    - 6+ people

**Goals** (multiple choice):
11. What's the primary goal?
    - Pipeline generation (meetings, demos booked)
    - Brand awareness / category positioning
    - Customer engagement / expansion
    - Partner development
    - Recruiting / employer brand

12. Are competitors exhibiting at this event? (multiple choice):
    - Yes, major competitors will be there
    - Some competitors, not a big presence
    - No / unknown
    - We'd be the only vendor in our category

### Step 2: Score the Event

Read `references/evaluation-criteria.md` for the full scoring rubric.

Score the event across 6 dimensions (1-5 each, 30 max):

| Dimension | What you're scoring |
|-----------|-------------------|
| ICP Density | How concentrated is your buyer at this event? |
| Budget-to-Opportunity Ratio | Can you afford enough presence to matter? |
| Content/Speaking Opportunity | Can you get on stage or create content? |
| Competitive Landscape | Are competitors there? Is that good or bad? |
| Timing Alignment | Does this fit your sales cycle and roadmap? |
| Strategic Value | Category positioning, partner density, recruiting |

**Scoring thresholds:**
- 24-30: **Strong Yes** — commit and invest
- 18-23: **Conditional Yes** — worth it with conditions (specify what would need to be true)
- Below 18: **Likely No** — money is probably better spent elsewhere

### Step 3: Break-Even Math

Read `references/budget-benchmarks.md` for benchmarks.

Calculate and present:
1. **Break-even deals needed:** Total Event Cost ÷ Average ACV
2. **Qualified conversations needed:** Break-even deals ÷ Event-to-Close Rate (use 20-25% as baseline)
3. **Meetings needed pre-event:** Target 15-25 pre-booked meetings for major conferences, 5-10 for mid-size
4. **Pipeline-to-cost target:** 10x is strong, 5x is acceptable for first-time events
5. **Budget sanity check:** Compare proposed budget against benchmarks for this event type and ACV

Present this as a simple table: "Here's what needs to be true for this event to pay for itself."

### Step 4: Generate Recommendation

Write a clear, opinionated recommendation:
- **Verdict:** Strong Yes / Conditional Yes / Likely No
- **Why:** 2-3 sentences grounding the recommendation in the scores and math
- **Conditions** (if Conditional Yes): What would need to change to make this a Strong Yes
- **Red flags** (if any): Anti-patterns you spotted (vanity event, FOMO-driven, budget mismatch)
- **Alternative** (if Likely No): What they should consider instead (smaller presence, hosted dinner nearby, skip entirely)

### Step 5: Create Event Folder and Files

1. Generate a slug from the event name (lowercase, hyphens, e.g., `saastr-2026`)
2. Create the event directory: `mkdir -p ~/.claude/data/events/{slug}`
3. Write `event-info.md` with YAML frontmatter containing all intake data:

```yaml
---
name: {Event Name}
slug: {slug}
dates: { start: YYYY-MM-DD, end: YYYY-MM-DD }
location: {City, State}
venue: {Venue name if known}
event_url: {URL}
event_type: {type}
company: {Company Name}
acv: {number}
icp: "{ICP description}"
budget: {number}
primary_goal: {goal}
sponsorship_tier: null
side_event: null
team_size: {number}
crm: null
map: null
sales_cycle_days: {number}
created: {today's date}
google_doc_ids:
  evaluation: null
  plan: null
  brief: null
  debrief: null
  budget_sheet: null
  roi_sheet: null
---
```

4. Write `status.md`:

```markdown
---
phase: evaluating
last_updated: {today's date}
---

# Status: {Event Name}

## Current Phase: Evaluating

## Next Actions
1. Review evaluation and make go/no-go decision
2. If approved, run `/event-plan` to build the master plan
```

5. Write `evaluation.md` with the full scored analysis, break-even math, and recommendation.

### Step 6: Create Google Doc

Build the evaluation as an HTML document following the google-docs skill pattern:

1. Write HTML to `/tmp/event-{slug}-evaluation.html` using the standard CSS template:
   - `<h1>` for the doc title: `{Company} — {Event Name} Evaluation`
   - `<h2>` sections for: Event Overview, Scoring Analysis, Break-Even Math, Recommendation
   - Use `<table>` for the scoring grid and budget analysis
   - Use status colors: green `#1a7a1a` for Strong Yes, amber `#b36b00` for Conditional Yes, red `#cc1111` for Likely No

2. Get access token:
```bash
CLIENT_ID=$(python3 -c "import json; d=json.load(open('$HOME/.config/gws/credentials.json')); print(d['client_id'])")
CLIENT_SECRET=$(python3 -c "import json; d=json.load(open('$HOME/.config/gws/credentials.json')); print(d['client_secret'])")
REFRESH_TOKEN=$(python3 -c "import json; d=json.load(open('$HOME/.config/gws/credentials.json')); print(d['refresh_token'])")
ACCESS_TOKEN=$(curl -s -X POST https://oauth2.googleapis.com/token \
  -d "client_id=$CLIENT_ID" \
  -d "client_secret=$CLIENT_SECRET" \
  -d "refresh_token=$REFRESH_TOKEN" \
  -d "grant_type=refresh_token" | python3 -c "import json,sys; print(json.load(sys.stdin).get('access_token',''))")
```

3. Upload to Drive:
```bash
curl -s -X POST "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -F "metadata={\"name\": \"{Company} — {Event Name} Evaluation\", \"mimeType\": \"application/vnd.google-apps.document\"};type=application/json" \
  -F "file=@/tmp/event-{slug}-evaluation.html;type=text/html"
```

4. Extract the doc ID from the response and update `event-info.md` frontmatter: `google_doc_ids.evaluation: {id}`

5. Print the doc URL: `https://docs.google.com/document/d/{id}/edit`

### Step 7: Present Summary

Print a concise summary in conversation:
- Event name and dates
- Overall score (X/30)
- Verdict with color coding
- Break-even math (one line)
- Link to Google Doc
- Next step: "If you're going ahead, run `/event-plan` to build the full plan."

</event-evaluate>
