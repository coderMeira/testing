#!/bin/sh

# DESCRIPTION:
# This script modifies the commit history of a Git repository, changing the name and email of all commits.

# INSTRUCTIONS:
# 1 - Save the script to a file: "update_commit_identity.sh"
# 2 - Replace the NAME and EMAIL variables with the ones associated with your account on GitHub.com
# 3 - Change file permissions with the chmod 777 command: chmod 777 update_commit_identity.sh
# 4 - Create a bare clone of the desired repository: git clone --bare https://github.com/user/repo.git
# 5 - Run the script inside the repository with the "./" command: ./update_commit_identity.sh

# WARNING:
# Be careful if you have a multi-user repository.
# This script will modify the commit history of the repository, which can
# cause conflicts if other people have already cloned or forked the repository.
# It is best to do this only on repositories that you own and have complete control over.
#

# Change these variables accordingly
NAME="coderMeira"
EMAIL="fredericomeiraa@gmail.com"

# Setting right name and email on user's git config, to avoid having to run this script again in the future
if ! git config --get user.name | grep "$NAME";
then
        git config --global user.name "$NAME"
fi;
if ! git config --get user.email | grep "$EMAIL";
then
        git config --global user.email "$EMAIL"
fi;

# Modify the current repo's commits names and emails
git filter-branch --force --commit-filter '
        if [ "$GIT_COMMITTER_EMAIL" != '"$EMAIL"' -o "$GIT_COMMITTER_EMAIL" != '"$EMAIL"' ];
        then
                export GIT_COMMITTER_NAME='"$NAME"';
                export GIT_AUTHOR_NAME='"$NAME"';
                export GIT_COMMITTER_EMAIL='"$EMAIL"';
                export GIT_AUTHOR_EMAIL='"$EMAIL"';
        fi;
        git commit-tree $@
' --tag-name-filter cat -- --all

git filter-branch --env-filter;
# git push --force --tags origin 'refs/heads/*'
