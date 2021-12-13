#!/bin/bash

# Example:
# bash build_choices.sh              # Stops execution if GITHUB_TOKEN env is not set

if [ ! -z "${GITHUB_TOKEN}" ]; then
  export GEM_HOST_API_KEY="Bearer $GITHUB_TOKEN"

  # Build gem (sed to get filename of the gem built and store it in variable)
  GEM_FILE=$(gem build | sed -n "s/^.*File: \(.*\.gem\)$/\1/p")

  # Push gem to registry (github)
  gem push "${GEM_FILE}"
else
  echo 'GITHUB_TOKEN not set in environment. Please set it with `export GITHUB_TOKEN=<token>`'
fi
