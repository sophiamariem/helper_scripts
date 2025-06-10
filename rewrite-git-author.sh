#!/bin/bash

OLD_EMAIL="old@example.com"
NEW_NAME="New Name"
NEW_EMAIL="new@example.com"

echo "Rewriting Git history: replacing $OLD_EMAIL with $NEW_NAME <$NEW_EMAIL>..."

git filter-branch --env-filter "
if [ \"\$GIT_COMMITTER_EMAIL\" = \"$OLD_EMAIL\" ]
then
    export GIT_COMMITTER_NAME=\"$NEW_NAME\"
    export GIT_COMMITTER_EMAIL=\"$NEW_EMAIL\"
fi
if [ \"\$GIT_AUTHOR_EMAIL\" = \"$OLD_EMAIL\" ]
then
    export GIT_AUTHOR_NAME=\"$NEW_NAME\"
    export GIT_AUTHOR_EMAIL=\"$NEW_EMAIL\"
fi
" --tag-name-filter cat -- --branches --tags

echo "Done. You may need to force push:"
echo "  git push --force --all"
echo "  git push --force --tags"
