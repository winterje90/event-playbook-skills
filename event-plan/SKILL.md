---
name: event-plan
description: >
  Build a comprehensive event plan for a B2B SaaS company that has committed to attending an event.
  Generates a 12-week countdown with milestones, budget breakdown, target account list guidance,
  6-touch outreach sequences, MOPS/CRM setup checklist, booth strategy, and side event planning.
  Outputs a local master plan, Google Doc, and Google Sheet budget tracker.
  Use when someone says "plan this event", "we're doing [event]", "event plan", "build an event plan",
  "we committed to [event]", or has already evaluated an event and is ready to plan.
---

<event-plan>

# Event Planning Skill

Build the full operational plan for a committed event. This is the workhorse skill — it produces everything the team needs from commitment through the week before the event.

## Workflow

### Step 1: Check for Existing Event Data

1. Scan `~/.claude/data/events/` for existing event folders
2. If events exist, present them as options: "I found these events — which one are you planning?"
3. If the user picks an existing event, read `event-info.md` to pull company context, ACV, ICP, goals, etc. Skip questions already answered.
4. If it's a new event (no evaluation done), collect the full intake from `/event-evaluate` first — or ask the minimal set below.

### Step 2: Intake

If starting from an existing evaluation, most of this is pre-populated. Only ask what's missing.

**Event details** (if not already captured):
1. Event name, dates, location
2. Company name, ACV, ICP, sales cycle

**Planning-specific questions:**

3. Sponsorship tier (multiple choice):
   - Booth only (no sponsorship)
   - Bronze/basic sponsor
   - Silver/mid-tier sponsor
   - Gold/premium sponsor
   - Title/platinum sponsor

4. Do you have a speaking slot? (yes/no)

5. Hosting a side event? (multiple choice):
   - No
   - Dinner (10-30 people)
   - Happy hour / cocktails (30-60 people)
   - Workshop / roundtable (15-25 people)
   - Breakfast (15-30 people)

6. How many BDRs/AEs will do pre-event outreach? (number)

7. CRM (multiple choice): Salesforce / HubSpot / Pipedrive / Other

8. MAP (multiple choice): HubSpot / Marketo / Pardot / ActiveCampaign / None

9. Do you want pre-event outreach sequences? (yes/no, default yes)

10. Approved budget (number, or "still determining")

### Step 3: Build the Master Plan

Read reference files on demand as you build each section:

**Section 1: Goals and Success Metrics**
- Translate the primary goal into specific, measurable targets
- Use benchmarks from `../event-evaluate/references/budget-benchmarks.md`: 15-25 pre-event meetings, 40-80 qualified conversations, 10x pipeline-to-cost target
- Tailor targets to their ACV and team size

**Section 2: 12-Week Countdown**
Read `references/master-plan-template.md` for the milestone framework.
- Calculate actual dates by counting back from the event start date
- Assign owner roles to each milestone (Marketing, Sales, MOPS, Executive)
- Flag milestones that are already past due (if planning started late)

**Section 3: Budget Breakdown**
Read `../event-evaluate/references/budget-benchmarks.md` for line item ranges.
- Build a detailed budget with line items based on their event type, sponsorship tier, and team size
- Include estimated ranges for each line item
- Flag areas where they should invest more or can save

**Section 4: Target Account List (TAL)**
- Provide criteria for building the TAL based on ICP
- Recommend TAL size: 200-300 accounts for major conferences, 50-100 for mid-size
- Suggest sources: event attendee list, CRM accounts in territory, LinkedIn event page, industry association members
- Include segmentation tiers: Tier 1 (must-meet, 20-30 accounts), Tier 2 (should-meet, 50-100), Tier 3 (opportunistic, rest)

**Section 5: Pre-Event Outreach**
Read `references/outreach-sequences.md` for templates.
- If user said yes to outreach, include the full 6-touch sequence with ready-to-use templates
- Customize templates with event name, company positioning, and ICP pain points
- Include timing guidance (which week to send each touch)
- Include BDR assignment guidance: divide TAL Tier 1 accounts across BDRs

**Section 6: MOPS Setup**
Read `references/mops-checklist.md` for platform-specific checklists.
- Generate CRM campaign setup instructions for their specific platform
- Include lead source values, campaign member statuses, scoring adjustments
- Include MAP setup: landing page, UTM structure, event-specific email templates

**Section 7: Booth Strategy and Logistics**
Read `references/booth-and-logistics.md` for detailed guidance.
- Booth messaging framework (tagline, value props, proof points)
- Equipment and supplies checklist
- Swag recommendations based on budget
- Exhibitor manual review checklist
- Booth design principles

**Section 8: Side Event Planning** (if applicable)
Read `references/booth-and-logistics.md` for side event section.
- Venue sourcing timeline
- Guest list criteria and size
- Program flow (agenda for dinner/happy hour/workshop)
- F&B budget guidance
- Invitation sequence and timeline

**Section 9: Marketing Activation**
- Pre-show social media plan (LinkedIn posts, event hashtags)
- Content to prepare: social posts, blog recap framework, email headers
- Paid amplification recommendations if budget allows

### Step 4: Write Event Files

1. Write `~/.claude/data/events/{slug}/plan.md` — the full master plan with all sections
2. Update `event-info.md` frontmatter with any new data (sponsorship tier, CRM, MAP, etc.)
3. Update `status.md`:
   - Set phase to "planning"
   - Populate the milestone table from the 12-week countdown
   - Set next actions (first 3 milestones)
   - Set `last_updated` to today

### Step 5: Create Google Doc

Build the master plan as HTML and upload via the google-docs pattern:

1. Write HTML to `/tmp/event-{slug}-plan.html`
   - Title: `{Company} — {Event Name} Master Plan`
   - Sections as `<h2>` headings
   - Milestones as a table with color-coded status
   - Outreach templates in styled blockquotes
   - Budget as a table

2. Upload to Drive (same pattern as event-evaluate):
```bash
CLIENT_ID=$(python3 -c "import json; d=json.load(open('$HOME/.config/gws/credentials.json')); print(d['client_id'])")
CLIENT_SECRET=$(python3 -c "import json; d=json.load(open('$HOME/.config/gws/credentials.json')); print(d['client_secret'])")
REFRESH_TOKEN=$(python3 -c "import json; d=json.load(open('$HOME/.config/gws/credentials.json')); print(d['refresh_token'])")
ACCESS_TOKEN=$(curl -s -X POST https://oauth2.googleapis.com/token \
  -d "client_id=$CLIENT_ID" -d "client_secret=$CLIENT_SECRET" \
  -d "refresh_token=$REFRESH_TOKEN" -d "grant_type=refresh_token" | \
  python3 -c "import json,sys; print(json.load(sys.stdin).get('access_token',''))")

curl -s -X POST "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -F "metadata={\"name\": \"{Company} — {Event Name} Master Plan\", \"mimeType\": \"application/vnd.google-apps.document\"};type=application/json" \
  -F "file=@/tmp/event-{slug}-plan.html;type=text/html"
```

3. Store doc ID in `event-info.md` → `google_doc_ids.plan`

### Step 6: Create Budget Google Sheet

1. Create the spreadsheet:
```bash
gws sheets spreadsheets create --params '{"properties": {"title": "{Company} — {Event Name} Budget Tracker"}}' | python3 -c "import json,sys; d=json.load(sys.stdin); print(d['spreadsheetId'])"
```

2. Write headers and data:
```bash
gws sheets spreadsheets values update --params '{
  "spreadsheetId": "{SHEET_ID}",
  "range": "Sheet1!A1",
  "valueInputOption": "USER_ENTERED"
}' --json '{"values": [
  ["Category", "Line Item", "Estimated", "Actual", "Delta", "Notes"],
  ["Booth", "Space rental", {estimated}, "", "=D2-C2", ""],
  ...
]}'
```

3. Include formulas for category subtotals and grand total
4. Store sheet ID in `event-info.md` → `google_doc_ids.budget_sheet`

### Step 7: Present Summary

Print in conversation:
- Event name, dates, and countdown (X weeks away)
- Budget summary (total estimated)
- Key milestone dates (next 3)
- Links to Google Doc and Google Sheet
- Next step: "Start with your TAL build and outreach sequence. When the event is 1-2 weeks away, run `/event-brief` to build your team briefing."

</event-plan>
