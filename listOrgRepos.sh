#!/bin/bash
#Purpose: Bash Scripting Training
#Author: Shashavali
#Date: 21 June,2022
#Use: List the repos in org

curl \
  -H "Accept: application/vnd.github.v3+json" \ 
  -H "Authorization: token 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" \
  https://api.github.com/orgs/ShashaDevopsTraining/repos