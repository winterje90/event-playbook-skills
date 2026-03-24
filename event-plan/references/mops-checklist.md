# MOPS / RevOps Event Setup Checklist

This checklist covers the CRM and MAP configuration needed to properly track, score, and route event leads. Customize based on the company's platform.

---

## CRM Campaign Setup

### Salesforce

1. **Create Campaign hierarchy:**
   - Parent campaign: `{Event Name} {Year}` (Type: Conference)
   - Child campaigns:
     - `{Event Name} — Booth Visits` (Type: Trade Show)
     - `{Event Name} — Pre-Event Outreach` (Type: Email)
     - `{Event Name} — Side Event` (Type: Dinner/Event) — if applicable
     - `{Event Name} — Speaking Session` (Type: Speaking) — if applicable

2. **Campaign Member Statuses** (for each child campaign):
   - Booth Visits: `Invited` → `Registered` → `Attended` → `Met at Booth` → `Demo Requested` → `Meeting Booked` → `Follow-up Sent`
   - Pre-Event Outreach: `Sent` → `Opened` → `Replied` → `Meeting Booked` → `Meeting Completed`
   - Side Event: `Invited` → `RSVP Yes` → `Attended` → `Follow-up Sent`

3. **Lead Source values:**
   - New leads from event: Lead Source = `Event — {Event Name}`
   - Existing contacts engaged at event: Original Lead Source unchanged, add Campaign Member record

4. **Custom fields** (if not already present):
   - `Event Lead Score` (picklist: 1-4) on Lead/Contact
   - `Event Notes` (long text) on Lead/Contact
   - `Event Follow-up Owner` (lookup to User) on Lead/Contact

5. **Assignment rules:**
   - New leads from booth: Round-robin to event BDRs
   - Existing accounts with owner: Route to account owner
   - Customer contacts: Route to CSM

### HubSpot

1. **Create Campaign:**
   - Marketing Campaign: `{Event Name} {Year}`
   - Associate all event assets (emails, landing pages, forms) to this campaign

2. **Create Lists:**
   - `{Event Name} — All Leads` (active list, filtered by form submission or import tag)
   - `{Event Name} — Score 3-4` (active list, filtered by event lead score property)
   - `{Event Name} — Score 1-2` (active list, for MAP nurture)
   - `{Event Name} — Pre-Event Outreach` (static list, TAL imported)

3. **Contact properties:**
   - `Event Lead Score` (dropdown: 1, 2, 3, 4) — custom property
   - `Event Notes` (multi-line text) — custom property
   - `Last Event Attended` (single-line text) — set via workflow

4. **Workflows:**
   - When contact submits event form or is imported with event tag → Set `Last Event Attended` = `{Event Name}`
   - When `Event Lead Score` = 3 or 4 → Create task for follow-up, assign to owner, due in 48 hours
   - When `Event Lead Score` = 1 or 2 → Enroll in event nurture sequence

5. **Lead rotation:**
   - Use HubSpot's round-robin assignment for new contacts without an existing owner
   - Contacts with existing owner → skip rotation, notify owner via task

### Pipedrive

1. **Pipeline adjustments:**
   - Add activity type: `Event Meeting`
   - Tag event leads with label: `{Event Name} {Year}`

2. **Custom fields on Person:**
   - `Event Lead Score` (options: 1, 2, 3, 4)
   - `Event Source` (text)

3. **Automation:**
   - When Person is created with tag `{Event Name}` → Create activity `Event Follow-up`, due in 48 hours

---

## MAP (Marketing Automation) Setup

### Landing Page

Create a simple landing page for pre-event meeting booking:
- Headline: "Meet {Company} at {Event Name}"
- Short description of what you'll discuss and why it's worth 15 minutes
- Calendar booking embed (Calendly, HubSpot meetings, Chili Piper) — not a form
- Social proof: one customer logo row or testimonial
- URL structure: `yoursite.com/events/{event-slug}` or `yoursite.com/{event-name}`

### UTM Structure

Standardize UTMs for all event marketing:

| Parameter | Value |
|-----------|-------|
| utm_source | `{event-slug}` (e.g., `saastr-2026`) |
| utm_medium | `event` |
| utm_campaign | `{event-slug}-{type}` (e.g., `saastr-2026-outreach`, `saastr-2026-booth`) |
| utm_content | `{specific asset}` (e.g., `email-touch-1`, `linkedin-post`, `landing-page`) |

### Email Templates to Load

Pre-load these in your MAP before the event:
1. **Pre-event outreach sequence** (6 touches — see outreach-sequences.md)
2. **Same-day follow-up** (for hot leads met at the booth)
3. **Post-event hot lead follow-up** (for score 3-4, sent within 48 hours)
4. **Post-event warm lead follow-up** (for score 2, sent within 5 days)
5. **Post-event nurture** (for score 1, automated 3-touch sequence)
6. **Side event follow-up** (for dinner/happy hour attendees)

### Lead Scoring Adjustments

Temporarily boost scoring for event engagement:

| Activity | Score Boost | Duration |
|----------|------------|----------|
| Submitted event meeting form | +15 points | Permanent |
| Attended event (badge scan) | +10 points | Decays after 30 days |
| Met at booth (manual tag) | +20 points | Decays after 30 days |
| Attended side event | +25 points | Decays after 30 days |
| Opened pre-event email | +3 points | Decays after 14 days |
| Clicked pre-event email | +5 points | Decays after 14 days |

**Important:** Set score decay so event leads don't inflate MQL counts indefinitely. 30-day decay for most event activities aligns with the follow-up window.

---

## Lead Capture Setup

### Options

| Method | Pros | Cons | Best For |
|--------|------|------|----------|
| Badge scanner (event-provided) | Fast, accurate data | Limited to registered attendees, rental cost | Teams with 50+ booth conversations/day |
| Business card scanner app | Free/cheap, works everywhere | Manual review needed, data quality varies | Small teams, niche events |
| Google Sheet (shared) | Zero cost, flexible | Manual entry, error-prone | Very small teams, informal events |
| CRM mobile app | Direct to CRM, no import step | Slower at booth | Teams already using Salesforce/HubSpot mobile |
| Dedicated lead capture app | Rich data, scoring built in | App subscription cost | Teams doing 5+ events/year |

### Recommended approach:

- **For 3+ events/year:** Invest in a lead capture app. The time saved on data entry and import alone justifies the cost.
- **For 1-2 events/year:** Badge scanner from the event + Google Sheet backup. Have a shared Sheet on everyone's phone for conversations where you don't scan a badge.
- **For hosted events:** Google Sheet or CRM direct entry. Guest list is pre-set, you're just tracking who showed and conversation quality.

### Data fields to capture at the booth:

| Field | Required | Notes |
|-------|----------|-------|
| Name | Yes | First + Last |
| Company | Yes | |
| Title/Role | Yes | Critical for scoring |
| Email | Yes | |
| Lead Score (1-4) | Yes | Scored immediately after conversation |
| Notes | Recommended | 1-2 sentences: what they care about, what you discussed |
| Next Step | Recommended | Demo? Meeting? Send info? Add to nurture? |
| Photo of badge/card | Optional | Backup for data quality |

---

## Data Hygiene Checklist

Run these before and after the event:

**Before:**
- [ ] Deduplicate TAL against existing CRM contacts
- [ ] Flag existing customers in the TAL (route to CSM, not BDR)
- [ ] Confirm account ownership for all TAL accounts with existing pipeline
- [ ] Test lead capture → CRM import flow with a dummy record

**After (within 24 hours):**
- [ ] Import all leads to CRM with correct campaign membership
- [ ] Deduplicate new leads against existing contacts
- [ ] Merge duplicates (keep the record with more activity history)
- [ ] Verify lead scores are captured and visible
- [ ] Trigger assignment workflows
- [ ] Spot-check 5 records for data quality
