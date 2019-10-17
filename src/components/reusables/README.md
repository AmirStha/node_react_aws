
### STEP 1 - Adding the sub tree

# Add a new remote:

git remote add carpool_ui https://gitlab.com/pentamine/carpool-app-ui.git
# Fetch changes and update
git subtree add  --prefix=src/components/resuables rt_ui master

with squash
git subtree add --prefix=src/components/resuables --squash rt_ui master

## STEP 2 - Grabbing/updating a repo that uses subtrees
Fetch and merge
git subtree pull --prefix=src/components/resuables --squash plugin master

## STEP 3 - Push changes from main repo to subtree repo
git subtree push --prefix=src/components/resuables plugin master