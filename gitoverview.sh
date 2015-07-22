#!/bin/bash

# IMPROVEMENTS:
#  - option '-a' searches svn, git and hidden folders
#  - option '-r' can be deleted and replaced by...
#  - ... option '-d' for specifying maxdepth of searching

START_PATH=""
LOOKUP_SVN=false
RECURSIVE=false
GO_DEEPER=true

function displayUsage {
    echo "Searches in the subfolders of the current directory and displays uncommitted changes in GIT repositories that are found."
    echo "Usage: $0 [OPTIONS]"
    echo "    Valid options are:"
    echo "    -a"
    echo "        Displays all repositories below the path. Same as -r -s."
    echo "    -r"
    echo "        Searches in subfolders recursively."
    echo "    -s"
    echo "        Searches also for changes in SVN repositories."
    echo "    -p <PATH>"
    echo "        Specifies the path in which this script will search."
    echo "    -h"
    echo "        Displays this help."
    exit 0
}

function evaluateCurrentFolder {
if [ -e ".git" ]; then
    gitStatusMessage=`git status -s`
    if [ ! "x$gitStatusMessage" == "x" ]; then
        echo "[GIT] "`pwd`
        git status -s 2> /dev/null
        echo
        GO_DEEPER=false
    fi
fi
if [ "$LOOKUP_SVN" == true ]; then
    if [ -e ".svn" ]; then
        svnStatusMessage=`svn st`
        if [ ! "x$svnStatusMessage" == "x" ]; then
            echo "[SVN] "`pwd`
            svn st 2> /dev/null
            echo
            GO_DEEPER=false
        fi
    fi
fi
}

function searchSubfolders {
for FOLDER in *
do
    if [ -d "$FOLDER" ]; then
        cd "./${FOLDER}"
        evaluateCurrentFolder
        if $RECURSIVE ; then
            if $GO_DEEPER ; then
                searchSubfolders
            else
                GO_DEEPER=true
            fi
        fi
        cd ..
    fi
done
}

function checkPath {
    if [ -d "$START_PATH" ]; then
        echo "Searching in $START_PATH"
    else
        echo "No such file or file is no directory: $START_PATH"
        exit 1
    fi
}


while getopts "hasrp:" optArg; do
    case "$optArg" in
        h)
            displayUsage
            ;;
        s)
            LOOKUP_SVN=true
            ;; 
        p)
            START_PATH="$OPTARG"
            checkPath
            cd "$START_PATH"
            ;; 
        r)
            RECURSIVE=true
            ;; 
        a)
            LOOKUP_SVN=true
            RECURSIVE=true
            ;;
    esac
done
evaluateCurrentFolder
searchSubfolders
