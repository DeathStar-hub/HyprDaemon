#!/bin/bash
# Auto-export current session to ~/AI/convo in clean JSON format

TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
FILENAME="session-${TIMESTAMP}.json"

opencode export > ~/AI/convo/$FILENAME
echo "Session exported to ~/AI/convo/$FILENAME"