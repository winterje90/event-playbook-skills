# gws CLI Reference (for Claude Code)

gws is a CLI tool for Google Workspace APIs. Use it to access Gmail, Drive, Calendar, Sheets, and Docs on the user's behalf.

## Setup

gws is installed globally via npm (`@googleworkspace/cli`). Auth is done via `gws auth login` which stores encrypted credentials in `~/.config/gws/`. The `client_secret.json` file lives at `~/.config/gws/client_secret.json`.

## Command Pattern

```bash
gws <service> <resource> <method> --params '<JSON>'
```

Output is always JSON. Pipe to `jq` for filtering.

## Gmail

```bash
# Get profile
gws gmail users getProfile --params '{"userId": "me"}'

# Search messages (returns message IDs)
gws gmail users messages list --params '{"userId": "me", "q": "from:someone@example.com"}'
gws gmail users messages list --params '{"userId": "me", "q": "subject:quarterly review"}'
gws gmail users messages list --params '{"userId": "me", "q": "is:unread"}'

# Read a message
gws gmail users messages get --params '{"userId": "me", "id": "MESSAGE_ID"}'

# Get subject line
gws gmail users messages get --params '{"userId": "me", "id": "MESSAGE_ID"}' | jq '.payload.headers[] | select(.name == "Subject") | .value'

# List labels
gws gmail users labels list --params '{"userId": "me"}' | jq '.labels[] | {id, name}'

# Send an email (build RFC 2822 message, then send)
# Step 1: Write the email to a temp file
cat > /tmp/email.eml << 'EOF'
From: me
To: recipient@example.com
Subject: Your subject here
Content-Type: text/plain; charset="UTF-8"

Email body here.
EOF
# Step 2: Base64 encode and send
gws gmail users messages send --params '{"userId": "me", "raw": "'$(base64 -i /tmp/email.eml | tr -d '\n')'"}'

# Create a draft
gws gmail users drafts create --params '{"userId": "me", "message": {"raw": "'$(base64 -i /tmp/email.eml | tr -d '\n')'"}}'
```

## Drive

```bash
# List files
gws drive files list --params '{"fields": "files(id,name,mimeType,modifiedTime)"}' | jq '.files[]'

# Search by name
gws drive files list --params '{"q": "name contains \"board deck\""}'

# Files in a folder
gws drive files list --params '{"q": "\"FOLDER_ID\" in parents"}'

# Upload a file (helper command — recommended)
gws drive +upload ./report.pdf --name "Q1 Report"

# Upload with explicit metadata
gws drive files create --json '{"name": "filename.pdf"}' --upload ./report.pdf

# Download a file
gws drive files get --params '{"fileId": "FILE_ID", "alt": "media"}' > output-file.pdf

# Create a folder
gws drive files create --params '{"name": "Folder Name", "mimeType": "application/vnd.google-apps.folder"}'

# Move a file to a folder
gws drive files update --params '{"fileId": "FILE_ID", "addParents": "FOLDER_ID", "removeParents": "CURRENT_PARENT_ID"}'
```

## Calendar

```bash
# List calendars
gws calendar calendarList list --params '{}' | jq '.items[] | {id, summary}'

# Upcoming events (replace the date with today's date)
gws calendar events list --params '{
  "calendarId": "primary",
  "timeMin": "2026-03-16T00:00:00Z",
  "maxResults": 10,
  "singleEvents": true,
  "orderBy": "startTime"
}' | jq '.items[] | {summary: .summary, start: .start.dateTime}'

# Create an event
gws calendar events insert --params '{
  "calendarId": "primary",
  "summary": "Meeting title",
  "start": {"dateTime": "2026-03-17T14:00:00-05:00"},
  "end": {"dateTime": "2026-03-17T15:00:00-05:00"},
  "attendees": [{"email": "someone@example.com"}]
}'
```

## Sheets

```bash
# Read cells
gws sheets spreadsheets values get --params '{
  "spreadsheetId": "SPREADSHEET_ID",
  "range": "Sheet1!A1:D10"
}' | jq '.values'

# Write cells
gws sheets spreadsheets values update --params '{
  "spreadsheetId": "SPREADSHEET_ID",
  "range": "Sheet1!A1",
  "valueInputOption": "USER_ENTERED"
}' --json '{"values": [["Value1", "Value2"], ["Value3", "Value4"]]}'

# Append rows
gws sheets spreadsheets values append --params '{
  "spreadsheetId": "SPREADSHEET_ID",
  "range": "Sheet1!A:A",
  "valueInputOption": "USER_ENTERED"
}' --json '{"values": [["New row value 1", "New row value 2"]]}'
```

## Docs

```bash
# Read a document (extract text)
gws docs documents get --params '{"documentId": "DOCUMENT_ID"}' | jq '.body.content[].paragraph.elements[].textRun.content' 2>/dev/null | tr -d '"'

# Get title
gws docs documents get --params '{"documentId": "DOCUMENT_ID"}' | jq '.title'
```

## Creating Google Docs from Content

To create a Google Doc, upload an HTML file to Drive with MIME type conversion:

```bash
# 1. Write content to a temp HTML file
cat > /tmp/doc-content.html << 'HTMLEOF'
<html><body>
<h1>Title</h1>
<p>Content here</p>
</body></html>
HTMLEOF

# 2. Upload with conversion to Google Docs format
gws drive files create --json '{"name": "Document Title", "mimeType": "application/vnd.google-apps.document"}' --upload /tmp/doc-content.html
```

## Pagination

List endpoints return `nextPageToken` when there are more results.

```bash
# Manual: pass pageToken from previous response
gws gmail users messages list --params '{"userId": "me", "q": "is:unread", "pageToken": "TOKEN"}'

# Automatic: fetch all pages (use with caution on large result sets)
gws gmail users messages list --params '{"userId": "me", "q": "label:inbox"}' --page-all
```

## Token Refresh

Tokens refresh automatically. If you get auth errors:
1. Check that `~/.config/gws/client_secret.json` exists
2. Re-run `gws auth login -s gmail,drive,calendar,sheets,docs` to re-authenticate
3. If the token was revoked, the user needs to sign in again via the browser

## Important Notes

- Always use `"userId": "me"` for Gmail commands
- Gmail message list only returns IDs — you must call `messages get` to read content
- For Drive uploads, use the `+upload` helper or `--json` + `--upload` flags
- For dates in Calendar commands, use ISO 8601 format with timezone
- The `--page-all` flag can return very large payloads — always filter with a query first
