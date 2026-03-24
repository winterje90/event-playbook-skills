#!/bin/bash
# Install Event Playbook Skills for Claude Code

set -e

SKILLS_DIR="$HOME/.claude/skills"
DATA_DIR="$HOME/.claude/data/events"

echo "Installing Event Playbook Skills..."

# Create directories
mkdir -p "$SKILLS_DIR"
mkdir -p "$DATA_DIR"

# Copy skills
for skill in event-evaluate event-plan event-brief event-debrief event-dashboard; do
  if [ -d "$skill" ]; then
    cp -r "$skill" "$SKILLS_DIR/"
    echo "  ✓ Installed $skill"
  else
    echo "  ✗ Missing $skill directory"
    exit 1
  fi
done

echo ""
echo "Done! 5 skills installed to $SKILLS_DIR"
echo "Event data will be stored in $DATA_DIR"
echo ""
echo "Available commands:"
echo "  /event-evaluate   — Should we do this event?"
echo "  /event-plan       — Build the full event plan"
echo "  /event-brief      — Create team briefing (1-2 weeks before)"
echo "  /event-debrief    — Post-event follow-up and ROI"
echo "  /event-dashboard  — Cross-event status view"
echo ""
echo "Optional: Install gws CLI for Google Docs/Sheets output:"
echo "  npm install -g @googleworkspace/cli"
echo "  gws auth login -s drive,docs,sheets"
