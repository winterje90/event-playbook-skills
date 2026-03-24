---
name: event-brief
description: >
  Build a team briefing document for an upcoming B2B SaaS event. Generates a 60-second booth talk track,
  coverage schedule, lead scoring rubric, booth behavior rules, daily huddle agenda, demo script, and
  same-day follow-up protocol. Designed to be shared with the on-site team 1-2 weeks before the event.
  Use when someone says "event brief", "brief the team", "event is next week", "team briefing",
  "booth talk track", "get us ready for [event]", or is 1-2 weeks out from an event.
---

<event-brief>

# Event Briefing Skill

Compress everything the on-site team needs into one shareable document. This is the doc that gets dropped in the team Slack channel 1-2 weeks before the event.

## Workflow

### Step 1: Find the Event

1. Scan `~/.claude/data/events/` for events with a `plan.md` file
2. Present them: "Which event are you prepping for?"
3. Read `event-info.md` and `plan.md` to pull context: company name, ICP, goals, ACV, booth number, sponsorship tier, side events

### Step 2: Intake

Only ask what's not already captured in the event files.

1. **Who's going?** (free text — names and roles)

2. **What role does each person play?** (multiple choice per person):
   - Booth anchor (stays at booth, runs demos, captures leads)
   - Booth floater (works booth + walks the floor)
   - Floor / networking only
   - Speaker
   - Executive (meetings focused)

3. **Any pre-scheduled meetings?** (free text list, or "none")

4. **Do you have a demo available?** (multiple choice):
   - Yes — live product demo
   - Yes — recorded demo / video
   - No demo
   If yes: "How long is your standard demo?" (multiple choice): 2 min / 5 min / 10 min / 15+ min

5. **Top 3 competitor booths to watch** (free text, or "skip")

6. **Anything specific the team should know?** (free text, or "skip") — e.g., "CEO is bringing a key prospect to dinner," "we just launched a new feature," "avoid mentioning pricing"

### Step 3: Build the Briefing Document

Read reference files and build each section:

**Section 1: Event at a Glance**
Pull from `event-info.md`:
- Event name, dates, location, venue
- Booth number (if assigned)
- WiFi info (if known, otherwise: "Check exhibitor manual or ask at registration")
- Hotel name and address
- Side event details (dinner/HH venue, time, guest count)

**Section 2: Goals Reminder**
Pull from `plan.md`:
- Primary goal and specific targets (e.g., "20 qualified meetings, $500K pipeline")
- "This is what success looks like. Everything below is designed to get us there."

**Section 3: Team Schedule and Coverage**
Build a coverage grid based on intake:

- Divide event hours into 3-hour rotation blocks
- Assign anchors and floaters to each block
- Ensure 2 people at booth at all times
- Build in breaks — nobody should be "on" for more than 3 hours straight

Read `references/brief-template.md` for the time allocation guidance:
- 60% booth staffing (rotating pairs)
- 15% walking the floor (visit target accounts at THEIR booths)
- 15% session attendance (sit in talks where buyers are)
- 10% networking events and after-hours

**Section 4: 60-Second Booth Talk Track**
Read `references/talk-track-framework.md` and generate a customized talk track:

- **Hook** (5 sec): A question about THEIR challenge, not your product
- **Qualify** (10 sec): 2-3 rapid questions to confirm ICP fit
- **Bridge** (15 sec): Connect their pain to your solution
- **Proof** (15 sec): One customer name, one metric
- **Next Step** (5 sec): Book a meeting or demo, right there

Generate 2-3 variations:
- Standard (for anchors — full talk track)
- Abbreviated (for floaters — hook + qualify + "come to the booth")
- Executive (for leadership — relationship-focused, less pitch)

**Section 5: Lead Scoring Rubric**
Generate a 1-4 scoring guide:

| Score | Criteria | Action |
|-------|---------|--------|
| 4 — Hot | Decision-maker, active pain, budget, timeline in next quarter | AE personal follow-up within 24 hours |
| 3 — Warm | Right persona, expressed interest, exploring options | BDR follow-up within 48 hours |
| 2 — Lukewarm | Attended booth, had a conversation, but no clear need or timeline | MAP nurture sequence within 5 days |
| 1 — Badge scan | Scanned badge or took swag, minimal conversation | Add to general nurture, no personal follow-up |

Include: "When in doubt, score UP not down. A false positive costs one extra email. A false negative costs a deal."

**Section 6: Booth Behavior Rules**
Read `references/brief-template.md` for standard rules:

**Do:**
- Stand, don't sit. Energy is contagious.
- Make eye contact with people walking by. Smile.
- Open with a question, not a pitch.
- Score every conversation immediately — don't wait until the end of the day.
- Take a photo of every badge/card as backup.
- Drink water. You're talking for 8 hours.

**Don't:**
- Don't check your phone at the booth. It signals "I'm not interested in you."
- Don't huddle with your teammates. It looks like a closed group.
- Don't eat at the booth. Step away for meals.
- Don't lead with "What does your company do?" — lead with "What brought you to [Event]?"
- Don't pitch features. Ask about problems, then bridge to outcomes.
- Don't let anyone leave without being scored and logged.

**Section 7: Demo Script** (if demo available)
Build a structured demo flow based on their demo length:

- 2-min demo: Hook → one "wow" moment → CTA
- 5-min demo: Hook → pain validation → 2-3 key workflows → proof point → CTA
- 10-min demo: Hook → discovery (2 min) → tailored walkthrough (6 min) → "What would this mean for your team?" → CTA
- 15+ min: Shouldn't happen at a booth. "Let's book a full demo next week" is the better play.

**Section 8: Daily Huddle Agenda**
15 minutes, standing, morning and evening:

**Morning (before doors open):**
- Today's pre-booked meetings (who, when, where)
- Focus accounts to look for on the floor
- Any adjustments from yesterday

**Evening (after floor closes):**
- Top 3 conversations: who, what they care about, next step
- Hot leads that need same-day follow-up (score 4s)
- Anything to adjust for tomorrow
- Energy check: how's everyone holding up?

**Section 9: Same-Day Follow-Up Protocol**
- All score 4 leads: personal email from AE within 4 hours of conversation
- Template: reference the specific conversation, deliver on any promise ("sending you that case study"), propose next step with specific time
- All score 3 leads: personal email from BDR by end of event day
- LinkedIn connection requests: send to all score 3-4 leads same day

**Section 10: Competitor Intel** (if provided)
- Where their booths are
- Key things to listen for (their messaging, pricing, product gaps)
- How to handle "How are you different from [Competitor]?" — one crisp sentence

**Section 11: Logistics and Emergency**
- Travel details (flights, hotels)
- Expense policy reminders
- Emergency contacts (team lead phone, venue number)
- Dress code

### Step 4: Write Event Files

1. Write `~/.claude/data/events/{slug}/brief.md` — the full briefing document
2. Update `status.md`: phase to "briefed", last_updated to today

### Step 5: Create Google Doc

Build as HTML and upload via the standard google-docs pattern:
- Title: `{Company} — {Event Name} Team Brief`
- Sections as `<h2>` headings
- Talk track in a styled table
- Lead scoring rubric as a color-coded table
- Coverage schedule as a grid

Upload, store doc ID in `event-info.md` → `google_doc_ids.brief`, print the doc URL.

### Step 6: Present Summary

Print in conversation:
- Talk track (the standard version — the one the team should memorize)
- Lead scoring rubric (quick reference)
- Link to Google Doc
- "Share this with your team. Next step after the event: run `/event-debrief` to build your follow-up plan and ROI report."

</event-brief>
