# Lead Disposition and Routing Rules

## Manual vs. MAP Decision Tree

Not every lead needs a personal touch. The goal is to match effort to opportunity.

```
Lead comes in from event
├── Score 4 (Hot) → MANUAL: AE personal email within 24 hours
├── Score 3 (Warm) → MANUAL: BDR personalized template within 48 hours
├── Score 2 (Lukewarm) → MAP: Automated nurture within 5 days
├── Score 1 (Badge scan) → MAP: General nurture, no personal touch
├── Existing customer → MANUAL: CSM + AE within 48 hours
└── Executive (VP+) → MANUAL: AE or leadership, regardless of score
```

### When to Always Use Manual Follow-Up

Even if the lead scored low, these get personal attention:

- **Any existing pipeline account.** The event is an accelerator. Don't let automation handle a deal that's already in motion.
- **Any executive contact (VP+).** Executives don't respond to automated sequences. They respond to peer-level outreach.
- **Any lead where you made a specific promise.** "I'll send you that case study" requires a real email, not a drip campaign.
- **Any customer contact.** Route to CSM immediately. This is an expansion opportunity, not a new lead.
- **Any partner or integration prospect.** These need a different conversation track entirely.

### When MAP Automation Is the Right Call

- Score 1-2 leads with no specific conversation context
- Large batch of badge scans from a scanner dump
- People who took swag but didn't engage in conversation
- Leads from a partner booth referral with no direct interaction

---

## Lead Routing Rules

### By Account Status

| Account Status | Route To | Why |
|---------------|----------|-----|
| Existing account with owner | Account owner | They own the relationship. Don't let a BDR cold-email their contact. |
| Existing pipeline (open opp) | Opp owner (AE) | Event is a pipeline accelerator. AE should reference the conversation. |
| Existing customer | CSM + AE | CSM handles relationship, AE joins if expansion opportunity is clear. |
| New account, in-territory | Territory BDR/AE | Standard routing by territory rules. |
| New account, no territory match | Round-robin to event BDRs | Fair distribution among the team that worked the event. |

### By Lead Score

| Score | Primary Owner | Backup | Notes |
|-------|--------------|--------|-------|
| 4 | AE who had the conversation | AE assigned by territory if no specific converation | AE owns through to close or disqualification. |
| 3 | BDR who had the conversation | BDR assigned by territory | BDR qualifies, books meeting for AE if confirmed. |
| 2 | MAP | BDR (if lead engages with nurture) | Monitor for engagement signals. If they click 2+ emails, escalate to BDR. |
| 1 | MAP | None | General nurture only. No personal follow-up unless they engage. |

### Special Routing

**Customer contacts identified at the event:**
1. Do NOT route through standard lead assignment
2. Immediately notify the CSM via Slack/email: "{Customer} contact {Name} was at {Event}, they scored {Score}"
3. If expansion opportunity was discussed: create a note on the account, loop in AE
4. CSM sends follow-up within 48 hours: "Great seeing you at {Event}..."

**Executive contacts (VP+):**
1. Route to AE regardless of score
2. If your exec met their exec: your exec sends the follow-up email (peer-to-peer)
3. Never send an automated email to a VP+ contact. Ever.

---

## SLA Framework

### Definitions

| SLA | Meaning |
|-----|---------|
| First Touch | Time from lead creation in CRM to first personal outreach (email or LinkedIn) |
| Meeting SLA | Time from first touch to a booked meeting on the calendar |
| CRM Update | Time from conversation to complete CRM record (notes, score, next step) |

### SLA Targets

| Lead Tier | First Touch | Meeting Booked | CRM Updated |
|-----------|------------|----------------|-------------|
| Score 4 (Hot) | 24 hours | Within 48 hours | Same day as event conversation |
| Score 3 (Warm) | 48 hours | Within 7 days | Within 24 hours of event |
| Score 2 (Lukewarm) | 5 business days (via MAP) | N/A | Within 48 hours of event |
| Score 1 (Cold) | 5 business days (via MAP) | N/A | Within 48 hours of event |
| Customer | 48 hours | Within 7 days (CSM + AE) | Same day |

### SLA Tracking

**How to measure compliance:**

For CRM (Salesforce/HubSpot):
- First touch SLA: Compare "Campaign Member Created Date" to "First Activity Date" on the lead/contact
- Meeting SLA: Compare "Campaign Member Created Date" to first "Meeting" activity
- CRM Update SLA: Compare event end date to "Last Modified Date" on the lead/contact

**Report to run at Day 7:**
- Total leads by score tier
- % of score 3-4 leads with first touch sent within SLA
- % of score 3-4 leads with meetings booked
- % of all leads with CRM records complete

**What to do when SLAs are missed:**
- Day 3: If any score 4 lead hasn't been touched → escalate to sales manager immediately
- Day 5: If any score 3 lead hasn't been touched → reassign to another BDR
- Day 7: If leads are still unworked → it's likely too late for hot leads, but warm leads can still be recovered with a "sorry for the delay" angle

---

## Lead Lifecycle After the Event

### 30-Day Follow-Up Calendar

| Day | Action | Who |
|-----|--------|-----|
| 1 | Upload leads, assign owners, send score 4 follow-ups | MOPS + AEs |
| 2 | Send score 3 follow-ups, enroll score 1-2 in MAP | BDRs + MOPS |
| 3-5 | Send Touch 2 (value-add) to score 4 leads | AEs |
| 5 | Run team debrief meeting | Marketing lead |
| 7 | Send Touch 3 to score 4, Touch 2 to score 3 | AEs + BDRs |
| 7 | SLA compliance report | MOPS |
| 10 | Touch 3 to score 3, MAP Touch 2 to score 1-2 | BDRs + MAP |
| 14 | Touch 5 (break-up) to score 3. Mid-month pipeline check. | BDRs + Marketing |
| 21 | MAP Touch 3 to score 1-2 | MAP |
| 30 | Run ROI report. Pipeline attribution. Go/no-go for next year. | Marketing + Sales |

### Lead Status Progression

Track these statuses in CRM for event leads:

```
New (imported) → Contacted → Engaged → Meeting Booked → Meeting Completed → Opportunity Created
                                                                            → Disqualified
                           → No Response (after full sequence) → Nurture
```

**"No Response" is not "Dead."** Leads that don't respond to the event sequence may re-engage later through inbound. Tag them as `Event — {Name} — No Response` so you can attribute future engagement back to the event.
