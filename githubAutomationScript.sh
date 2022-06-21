#!/bin/bash
#Purpose: Bash Scripting Training
#Author: Shashavali
#Date: 21 June,2022
#Use: Automation of Github Admin Tasks


echo 
echo "============= Enter your choice ==============="
echo
echo "1 ==> List all existing repositories"
echo "2 ==> Create a repository"
echo "3 ==> Delete a repository"
echo

read choice

case $choice in
    
    1)
    echo
    echo "The existing repositories are ..."
    echo
    curl \
        -s -S -H "Accept: application/vnd.github.v3+json" --user shashavalidudekula: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 https://api.github.com/orgs/ShashaDevopsTraining/repos | grep -w "name" | awk '{print $2}' | grep -v repos | sed 's/"*"//g' | cut -d "," -f 1
    ;;

    2)
        echo 
        echo "Give a name for your new repo: "
        read reponame 
        echo
        echo "Checking $reponame exists or not..."
        sleep 1
        echo "..."

        #============= this will list all the repo names in given organization and redirect names to listOfRepo.txt file
        curl \
        -s -S -H "Accept: application/vnd.github.v3+json" -H "Authorization: token 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" https://api.github.com/orgs/ShashaDevopsTraining/repos | grep -w "name" | awk '{print $2}' | grep -v repos | sed 's/"*"//g' | cut -d "," -f 1 > listOfRepo.txt

        #check the given repo name in the listOfRepo.txt file
        grep -ix $reponame listOfRepo.txt > /dev/null

        if [ $? -eq 0 ]                        #if name exists it shows already exists
        then
            echo
            echo "already exists"
            exit 0
        else 
            echo "Creating repo..."                  #if not create a repo with given name.
            echo 
            curl \
            -X POST \
            -s -S -H "Accept: application/vnd.github.v3+json" --user shashavalidudekula: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 \
            https://api.github.com/orgs/ShashaDevopsTraining/repos \
            -d '{"name":"'$reponame'" ,"description":"This is your first repository","private":false}' > /dev/null
            echo
            echo "$reponame repo is created successfully."
        fi
        ;;

    3)
        echo 
        echo "Give a repo name to delete: "
        read reponame
        echo
        echo "Checking $reponame exists or not..."
        sleep 1
        echo "..."

        #============= this will list all the repo names in given organization and redirect names to listOfRepo.txt file
        curl \
        -s -S -H "Accept: application/vnd.github.v3+json" --user shashavalidudekula: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 https://api.github.com/orgs/ShashaDevopsTraining/repos | grep -w "name" | awk '{print $2}' | grep -v repos | sed 's/"*"//g' | cut -d "," -f 1 > listOfRepo.txt

        #check the given repo name in the listOfRepo.txt file
        grep -ix $reponame listOfRepo.txt > /dev/null

        if [ $? -eq 0 ]                        #if name exists it shows already exists
        then
            echo "Deleting repo..."                  #if not create a repo with given name.
            echo 
           curl \
            -X DELETE \
            -s -S -H "Accept: application/vnd.github.v3+json" --user shashavalidudekula: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 https://api.github.com/repos/ShashaDevopsTraining/$reponame
            echo
            echo "$reponame repo is deleted successfully."
        else
            echo "incorrect repo name."
        fi
        ;;
    *)
    echo 
    echo "You have entered wrong choice"
    echo
    echo -e "Usage: \n1 ==> Listing repositories \n2 ==> Create a repository \n3 ==> Delete a repository"
    echo
    ;;
esac