#!/usr/bin/env bash

set -euo pipefail  # Enable strict mode for better error detection

print_message() {
  local color="$1"
  local message="$2"
  if command -v tput >/dev/null 2>&1; then
    echo "$(tput setaf "$color")$message$(tput sgr0)"
  else
    echo "$message"
  fi
}

error() {
  print_message 1 "💔 error: $1"
}

warn() {
  print_message 3 "⚠️ warn: $1"
}

info() {
  print_message 2 "$1"
}

copy_to_clipboard() {
  local content="$1"
  if command -v xclip >/dev/null 2>&1; then
    echo "$content" | xclip -selection clipboard
    info "✂️ copied to clipboard."
  elif command -v pbcopy >/dev/null 2>&1; then
    echo "$content" | pbcopy
    info "✂️ command was copied to clipboard."
  else
    warn "🦘 no clipboard utility found."
  fi
}

dingen() {
  local maxTokens=100
  local trust=false
  local usage="usage \`dingen.sh <system_prompt_file> [--max-tokens <number>] [--trust] <user_prompt>\`"

  # Check for required commands early
  if ! command -v gh >/dev/null 2>&1; then
    error "gh command not found. Please install the GitHub CLI."
    exit 1
  fi

  # Check if at least one argument (systemPromptFile) is provided
  if [[ $# -lt 1 ]]; then
    error "missing arguments."
    warn "$usage"
    return 1
  fi

  local systemPromptFile="$1"
  shift

  # Validate the system prompt file
  if [[ ! -f "$systemPromptFile" || ! -r "$systemPromptFile" ]]; then
    error "invalid system prompt file '$systemPromptFile'."
    warn "$usage"
    return 1
  fi

  # Parse optional --max-tokens argument safely
  if [[ $# -ge 2 && "$1" == "--max-tokens" && -n "$2" ]]; then
    if [[ "$2" =~ ^[0-9]+$ && "$2" -gt 0 ]]; then
      maxTokens="$2"
      shift 2
    else
      error "--max-tokens must be a positive integer."
      warn "$usage"
      return 1
    fi
  fi

  # Parse optional --trust argument
  if [[ $# -ge 1 && "$1" == "--trust" ]]; then
    trust=true
    shift
  fi

  # Validate that at least one user prompt argument exists
  if [[ $# -lt 1 ]]; then
    error "missing user prompt."
    warn "$usage"
    return 1
  fi

  # Efficient file reading
  local systemPrompt
  systemPrompt="$(<"$systemPromptFile")"

  # Run the AI command
  echo "✨ doing its ding..."
  local command
  if ! command=$(gh models run gpt-4o-mini --max-tokens "$maxTokens" --system-prompt "$systemPrompt" "$@" 2>&1); then
    error "failed."
    echo "$command"
    return 1
  fi

  # Store response in a file
  echo "$command" | tee ~/.dingen.sh-last >/dev/null

  # Display generated command with syntax highlighting (fallback to echo if bat isn't installed)
  echo ""
  print_message 5 "\`\`\`bash"
  if command -v bat >/dev/null 2>&1; then
    echo "$command" | bat --language=bash --style=plain
  else
    echo "$command"
  fi
  print_message 5 "\`\`\`"
  echo ""

  # Copy to clipboard if available
  copy_to_clipboard "$command"
  
  # Confirm execution (quiet prompt)
  if [[ "$trust" == true ]]; then
    echo "🚀 executing that dingens..."
    eval "$command" || error "command execution failed."
  else
    read -p "🕵️‍♀️ please review the generated command above and decide if you want to execute it (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      echo -e "\n🚀 executing that dingens..."
      eval "$command" || error "command execution failed."
    else
      echo "🚮 command not executed."
    fi
  fi
}

# run the function with all arguments
dingen "$@"
