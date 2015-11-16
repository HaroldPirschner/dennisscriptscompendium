#!/bin/bash
find . -type f -exec grep -Hni --color "$1" {} \;
