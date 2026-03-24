# Google Workspace + Claude Code — Setup Guide

> This guide sets up [gws](https://github.com/googleworkspace/cli) — Google's open-source CLI for Google Workspace APIs. The setup is handled entirely by Claude Code — no terminal commands needed. It takes about 5 minutes.

---

## Before You Start

You need two things:

1. **Claude Code open on your computer.** Open your terminal app and type `claude` then press Enter.
   - **Windows:** Search for "Command Prompt" in the Start menu.
   - **Mac:** Search for "Terminal" in Spotlight (Cmd + Space, type "Terminal").
   - If you don't have Claude Code installed yet, see [Claude Code docs](https://docs.anthropic.com/en/docs/claude-code).
2. **A `client_secret.json` file in your Downloads folder.** This comes from your Google Cloud project (see [Admin Setup](#admin-setup-one-time) below if you haven't created one yet).

You also need `gws-claude-reference.md` from this repo — it's at [`docs/gws-claude-reference.md`](gws-claude-reference.md). Download it to your Downloads folder.

## The Prompt

Paste this into Claude Code:

> I need to set up Google Workspace access. Please do the following:
>
> 1. Install Node.js and Python if I don't have them, then install gws (https://github.com/googleworkspace/cli) via npm — make sure it's v0.16.0 or newer. If you get a PowerShell script execution error, run `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned` first.
> 2. Copy the client_secret.json file from my Downloads folder to ~/.config/gws/client_secret.json (create the directory if needed).
> 3. Save the gws-claude-reference.md file from my Downloads folder into my ~/.claude/CLAUDE.md file. If I already have a CLAUDE.md file there, append the contents to the end of it.
> 4. Read the client_id and client_secret from the client_secret.json file, then build an OAuth URL with these parameters: the client_id from the file, redirect_uri=http://localhost, response_type=code, scope=https://www.googleapis.com/auth/gmail.modify https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/spreadsheets https://www.googleapis.com/auth/documents, access_type=offline, prompt=consent. **Open the URL directly in my default browser** using `open` on Mac or `start` on Windows — do not print the URL in the terminal.
> 5. After I sign in, I'll paste back the URL from my browser. Extract the authorization code from it, exchange it for tokens using curl (with the client_id and client_secret from the file), and save the result as a plain JSON credentials file at ~/.config/gws/credentials.json.
> 6. Test that it works by creating a Google Doc called "My Test Document."

## What to Expect

Claude Code will ask your permission before running each step. **Just click "approve" or type "y" each time.** Here's what happens:

1. **It installs software.** Claude Code checks if you have the right tools and installs anything missing. This takes about a minute.
2. **It moves your files into place.** It copies the two files you downloaded to where they need to go.
3. **Claude Code opens your browser automatically.** Sign in with your Google account and click "Allow" on the permissions screen.
4. **Copy the URL from your browser and paste it back into Claude Code.** After you click Allow, your browser will show an error page or blank page — that's normal. Copy the entire URL from your browser's address bar and paste it back into Claude Code.
5. **It runs a test.** Claude Code creates a Google Doc to confirm everything works. You'll see it appear in your Google Drive.

The whole thing takes about 5 minutes.

---

## What You Can Do Now

Once set up, just tell Claude Code what you want in plain English:

- "Check my calendar for this week"
- "Search my Gmail for emails from Sarah"
- "Create a Google Doc with this content"
- "Pull data from this Google Sheet"
- "Draft an email to the team about the quarterly review"

Claude Code handles all the technical details — you just describe what you need.

---

## Troubleshooting

| Problem | What to do |
|---------|-----------|
| Don't know how to open Claude Code | Windows: search "Command Prompt" in Start menu. Mac: search "Terminal" in Spotlight. Type `claude`, press Enter |
| Claude Code says it can't find gws or Node.js | Paste the error into Claude Code and ask it to fix it — it can install what's missing |
| gws version is below 0.16.0 | Tell Claude Code: "Update gws to the latest version" |
| "Access blocked" when signing in with Google | Your Google Cloud consent screen may need to be set to Internal (for Workspace accounts) or have your email added as a test user |
| Token stops working after 7 days | Your consent screen is still in Testing mode — publish it to Production (see Admin Setup) |
| Claude Code looks stuck after you signed in | Wait 10-15 seconds. If it's still stuck, just press Enter in Claude Code |
| Google says "Required parameter is missing: response_type" | The OAuth URL got broken by terminal line wrapping. Tell Claude Code: "Don't print the URL — open it directly in my browser using the `start` command (Windows) or `open` command (Mac)." |
| Any other error during setup | Paste the error message into Claude Code and ask it to help |

---

## You Won't Need to Do This Again

Your credentials don't expire unless you manually revoke access at [myaccount.google.com/permissions](https://myaccount.google.com/permissions). Everything refreshes automatically in the background.

---

## Admin Setup (One-Time)

This creates the Google Cloud project that lets Claude Code access Gmail, Calendar, Drive, Sheets, and Docs. You only do this once per organization.

### Step 1: Create a Google Cloud Project

1. Go to [console.cloud.google.com](https://console.cloud.google.com) and sign in with your Google account.
2. Click the project dropdown at the very top of the page (it might say "Select a project" or show an existing project name).
3. In the popup, click **New Project** in the top right.
4. Name it something like "Claude Code" and click **Create**.
5. Make sure your new project is selected in that same dropdown at the top.

### Step 2: Set Up the Consent Screen

This controls what users see when they sign in to approve access.

1. In the left sidebar, go to **APIs & Services** then **OAuth consent screen**.
2. Click **Get Started**.
3. Fill in the app name (e.g., "Claude Code") and your email for the support contact.
4. For audience:
   - **Google Workspace accounts:** Select **Internal**. Only people in your domain can sign in, no "unverified app" warning.
   - **Personal Gmail accounts:** Select **External**. You'll need to add each user's email as a test user, or publish and verify the app.
5. Add your email as a developer contact.
6. On the scopes screen, click **Add or Remove Scopes** and add:
   - `https://www.googleapis.com/auth/gmail.modify`
   - `https://www.googleapis.com/auth/drive`
   - `https://www.googleapis.com/auth/calendar`
   - `https://www.googleapis.com/auth/spreadsheets`
   - `https://www.googleapis.com/auth/documents`
7. Complete the remaining steps and click **Publish** to move the app out of testing mode (testing mode tokens expire after 7 days).

### Step 3: Turn On Google APIs

1. In the left sidebar, go to **APIs & Services** then **Library**.
2. Search for and enable each of these (click into each one and hit the blue **Enable** button):
   - Google Drive API
   - Gmail API
   - Google Calendar API
   - Google Sheets API
   - Google Docs API

### Step 4: Create OAuth Credentials

1. In the left sidebar, go to **APIs & Services** then **Credentials**.
2. Click **Create Credentials** at the top, then choose **OAuth client ID**.
3. For Application type, select **Desktop app**.
4. Name it anything (e.g., "Claude Code Desktop").
5. Click **Create**.

### Step 5: Download and Share `client_secret.json`

1. On the Credentials page, find the OAuth client you just created.
2. Click the download icon (⬇) to download the JSON file.
3. Rename it to `client_secret.json`.
4. Share it with your team (Slack DM, shared Drive folder, etc.). Each person saves it to their Downloads folder before running the setup prompt above.
