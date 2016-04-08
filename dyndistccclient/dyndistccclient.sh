#!/bin/bash

VERSION="0.0.1"

function printVersion ()
{
    echo "dyndistcc Version $VERSION"
    echo "Copyright 2016 Mark Furneaux, Romaco Canada"
}

function printRoot ()
{
    echo "This script must be run as root"
}

function printHelp ()
{
    scriptName=$(basename "$0")
    printVersion
    echo "Usage: $scriptName <command>"
    echo ""
    echo "Commands:"
    echo "  install     Install and configure dyndistcc client"
    echo "  uninstall   Remove dyndistcc client"
    echo ""
    printRoot
}

function askQuestions ()
{
    read -p "What is the domain/IP address of the controller: " serverAddr
    read -p "What project network is this client part of: " projectName
}

function doInstall ()
{
    askQuestions

    if [ $(which cron | wc -l) -lt 1 ] || [ $(which wget | wc -l) -lt 1 ]; then
        echo "Installing dependencies..."
        apt-get install cron wget
    else
        echo "Dependencies already installed. Skipping..."
    fi
    
    echo ""
    echo ""
    
}


if [ $# -ne 1 ]; then
    printHelp
elif [ $EUID -ne 0 ]; then
    printRoot
else
    case $1 in
        "install")
            mode="1"
            doInstall
            ;;
        "uninstall")
            mode="2"
            echo "Uninstalling..."
            ;;
        *)
            echo "Invalid command: $1"
            echo ""
            printHelp
    esac
fi


