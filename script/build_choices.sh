#!/bin/bash

# Example:
# bash build_choices.sh              # If github entry exists in "$HOME"/.gem/credentials
# bash build_choices.sh <token>      # If you want to overwrite "$HOME"/.gem/credentials with <token> and use it to push gem

GITHUB_TOKEN=$1

if [ ! -z "${GITHUB_TOKEN}" ]; then
  # Set credentials if token is passed
  mkdir -p "$HOME"/.gem
  touch "$HOME"/.gem/credentials
  chmod 0600 "$HOME"/.gem/credentials
  printf -- "---\n:github: Bearer %s\n" "${GITHUB_TOKEN}" > "$HOME"/.gem/credentials
else
  echo "GITHUB_TOKEN not passed. Assuming 'github' key exists in $HOME/.gem/credentials"
  echo "---------------"
  echo "If not run the same command with your github token as argument"
  echo "WARNING: It will overwrite "$HOME"/.gem/credentials"
  echo "Example: bash build_choices.sh <token>"
  echo "---------------"
fi

# Build gem (sed to get filename of the gem built and store it in variable)
GEM_FILE=$(gem build | sed -n "s/^.*File: \(.*\.gem\)$/\1/p")

# Push gem to registry (github)
gem push --key github "${GEM_FILE}"
