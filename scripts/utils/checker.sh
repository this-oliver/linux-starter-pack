#!/usr/bin/env bash

# returns true if argument is "Y" or "y" or "N" or "n" or empty
function check_response {
    response=$1

    if [ "$response" = "Y" ] || [ "$response" = "y" ] || [ "$response" = "N" ] || [ "$response" = "n" ] || [ "$response" = "" ]; then
        return 0
    else
        return 1
    fi
}

# returns true if argument is "Y" or "y"
function is_yes {
    response=$1

    if [ "$response" = "Y" ] || [ "$response" = "y" ]; then
        return 0
    else
        return 1
    fi
}

# returns true if argument is a valid version number
function check_version {
    version=$1
    if [[ $version =~ ^[0-9]+(\.[0-9]+)*$ ]]; then
        return 0
    else
        return 1
    fi
}

# returns true if argument looks like a valid theme name for oh-my-zsh (lowercase letters, numbers, hyphens and +)
function check_theme {
    theme=$1
    if [[ $theme =~ ^[a-z0-9-+]*$ ]]; then
        return 0
    else
        return 1
    fi
}