---
name: event-debrief
description: >
  Build a post-event follow-up plan and ROI report for a B2B SaaS company returning from an event.
  Generates tiered follow-up sequences, lead routing rules, SLAs, a debrief agenda, and a 30-day
  ROI report with pipeline metrics. Outputs a follow-up playbook (Google Doc) and ROI tracker (Google Sheet).
  Use when someone says "event debrief", "we're back from [event]", "post-event", "event follow-up",
  "event ROI", "debrief this event", or has just returned from an event and needs to activate follow-up.
---

<event-debrief>

# Event Debrief Skill

Turn event leads into pipeline. This skill builds the follow-up machine and ROI measurement framework.

## Workflow

### Step 1: Find the Event

1. Scan `~/.claude/data/events/` for events with a `brief.md` file (or at minimum, a `plan.md`)
2. Present them: "Which event are you debriefing?"
3. Read `event-info.md`, `plan.md`, and `brief.md` to pull context: goals, budget, team, ICP, ACV

### Step 2: Intake

1. **How'd it go overall?** (multiple choice):
   - Exceeded expectations
   - Met expectations
   - Below expectations
   - Waste of money

2. **Total leads collected** (number, or "I need to count")

3. **Rough lead quality breakdown** (multiple choice):
   - Mostly hot/warm (score 3-4) — great conversations
   - Mixed — some gems but a lot of badge scans
   - Mostly cold (score 1-2) — high volume, low quality
   - Don't know yet — haven't scored them

4. **Lead data format** (multiple choice):
   - CSV / spreadsheet export from lead capture
   - Badge scan data from the event
   - Notes in a Google Sheet or CRM
   - Handwritten notes / business cards to enter
   - Already in the CRM, just need follow-up plan

5. **Best lead from the event?** (free text) — "Tell me about your hottest lead. Who were they, what do they care about?"

6. **Any deals or next steps already in motion?** (free text or "none yet")

7. **Budget actuals** (optional): "Do you have actual spend numbers, or still gathering receipts?"

### Step 3: Build the Follow-Up Plan

Read reference files and build each section:

**Section 1: The 48-Hour Sprint**
This is the most time-sensitive section. Present it first.

Read `references/follow-up-sequences.md` for templates and timing.

**Day 1 (within 24 hours of getting home):**
- Upload all leads to CRM with correct campaign membership
- Assign every lead to an owner (see routing rules below)
- Send follow-up emails to ALL score 4 leads (personal, from AE)
- Send LinkedIn connection requests to all score 3-4 leads

**Day 2 (within 48 hours):**
- Send follow-up emails to ALL score 3 leads (personalized template, from BDR)
- Enroll score 1-2 leads in MAP nurture sequence
- Complete any promised sends (case studies, links, intros)

**Section 2: Lead Routing Rules**
Read `references/lead-disposition.md` for the decision tree.

Generate routing rules based on their CRM setup:
- Existing accounts with an owner → route to account owner
- New accounts → round-robin to event BDRs/AEs
- Customer contacts → route to CSM, flag for expansion conversation
- Executive contacts → route to AE, flag for leadership follow-up

**Section 3: Follow-Up Sequences by Lead Tier**
Read `references/follow-up-sequences.md` for full templates.

Generate customized email sequences:

**Hot leads (score 4):** 3-touch sequence over 7 days
- Day 1: Personal email referencing specific conversation + next step
- Day 3: Value-add (case study, relevant content)
- Day 7: "Checking in" + new angle or customer story

**Warm leads (score 3):** 5-touch sequence over 14 days
- Day 1-2: Personalized template referencing event + pain point
- Day 4: Content share (guide, report, webinar relevant to their challenge)
- Day 7: Social proof email (customer story matching their persona)
- Day 10: "Quick question" — one specific question about their situation
- Day 14: Break-up email / last touch

**Cold leads (score 1-2):** 3-touch automated MAP sequence over 21 days
- Day 3: Event recap email (generic but useful — event highlights, key takeaways)
- Day 10: Content piece relevant to event theme
- Day 21: "One more thing" — invite to webinar or content download

**Section 4: SLAs**
Read `references/lead-disposition.md` for SLA framework.

| Lead Tier | Owner | First Touch SLA | Meeting SLA |
|-----------|-------|----------------|-------------|
| Score 4 (Hot) | AE | 24 hours | Booked within 48 hours |
| Score 3 (Warm) | BDR | 48 hours | Booked within 7 days |
| Score 2 (Lukewarm) | MAP | 5 business days | N/A — nurture only |
| Score 1 (Cold) | MAP | 5 business days | N/A — nurture only |
| Customer | CSM | 48 hours | CSM + AE meeting within 7 days |

**Section 5: Disposition Decision Tree**
Read `references/lead-disposition.md`.

When to use manual follow-up vs. marketing automation:

**Manual (human sends the email):**
- Any score 3-4 lead
- Any existing pipeline account
- Any executive contact (VP+)
- Any lead where you made a specific promise

**MAP (automated sequence):**
- Score 1-2 leads with no specific conversation
- Large batch of badge scans
- People who took swag but didn't engage

**Section 6: 5-Day Team Debrief**

Generate a debrief meeting agenda to run within 5 days of the event:

1. **What worked** (10 min) — booth traffic, outreach effectiveness, side event ROI, talk track resonance
2. **What didn't** (10 min) — low-quality leads, booth location issues, messaging misses, logistics problems
3. **Top conversations** (15 min) — 5 best leads/conversations, what they need, next steps
4. **Surprise leads** (5 min) — anyone NOT on the TAL who turned out to be great?
5. **Competitive intel** (5 min) — what did competitors say/show? Anything new?
6. **One change for next time** (5 min) — each team member names one thing they'd do differently
7. **Preliminary numbers** (10 min) — review early metrics (leads, meetings booked, estimated pipeline)

**Section 7: 30-Day ROI Report Template**
Read `references/roi-template.md` for the full framework.

Build the measurement framework comparing actuals to original targets from the plan:

| Metric | Target (from plan) | Actual | Notes |
|--------|-------------------|--------|-------|
| Pre-event meetings booked | {from plan} | | |
| Qualified booth conversations (Score 3+) | {from plan} | | |
| Follow-ups sent within 48 hours (% of Score 3+) | 100% | | |
| Post-event meetings booked | {from plan} | | |
| Pipeline created within 30 days | ${from plan} | | |
| Pipeline accelerated (existing opps that advanced) | — | | Track this — often the hidden winner |
| Cost per qualified lead | — | | Total spend ÷ Score 3+ leads |
| Pipeline-to-cost ratio | 10x target | | Pipeline generated ÷ Total event cost |

Include the ROI formula:
```
Pipeline-to-Cost Ratio = Pipeline Generated ÷ Total Event Cost
Example: $300K pipeline ÷ $35K total cost = 8.6x
Target: 10x+ = strong, 5-10x = solid, under 5x = review execution
```

### Step 4: Write Event Files

1. Write `~/.claude/data/events/{slug}/debrief.md` — full debrief with all sections
2. Update `status.md`:
   - Phase to "follow-up"
   - Add 30-day milestone checkpoints: Day 2 (48-hr sprint complete), Day 5 (debrief meeting), Day 7 (all warm follow-ups sent), Day 14 (mid-month pipeline check), Day 30 (ROI report)
   - Set next actions (first 3 immediate items)
   - Set `last_updated` to today

### Step 5: Create Google Doc (Follow-Up Playbook)

Build as HTML and upload:
- Title: `{Company} — {Event Name} Follow-up Playbook`
- Sections: 48-Hour Sprint, Lead Routing, Follow-Up Sequences (with email templates), SLAs, Debrief Agenda
- Email templates in styled blockquotes for easy copy-paste

Store doc ID in `event-info.md` → `google_doc_ids.debrief`

### Step 6: Create Google Sheet (ROI Report)

Create a spreadsheet with three tabs:

**Tab 1: Investment**
- All budget line items with Estimated and Actual columns
- Category subtotals and grand total
- Delta column (Actual - Estimated)

**Tab 2: Activity Metrics**
- Pre-event meetings booked
- Booth conversations by score tier
- Follow-ups sent (count and % within SLA)
- Post-event meetings booked
- Demos completed

**Tab 3: Pipeline & ROI**
- Opportunities created (count and dollar value)
- Pipeline by source (pre-event outreach, booth, side event)
- Pipeline accelerated (existing opps that advanced stage)
- Cost per lead, cost per meeting, cost per opportunity
- Pipeline-to-cost ratio with formula
- Space for 30/60/90 day updates

Store sheet ID in `event-info.md` → `google_doc_ids.roi_sheet`

### Step 7: Present Summary

Print in conversation:
- Verdict recap: how it went + sentiment
- Immediate actions (the 48-hour sprint checklist)
- Lead routing summary
- SLA table (quick reference)
- Links to Google Doc and Google Sheet
- "Fill in actuals over the next 30 days. The pipeline-to-cost ratio is the number that tells you whether to do this event again."

</event-debrief>
