# /bin/bash
if [ -n "$WERCKER_GHP_IMPORT_MSG" ]; then
  WERCKER_GHP_IMPORT_MSG="-m "${WERCKER_GHP_IMPORT_MSG}
fi

info "Installing ghp-import."
pip install --upgrade ghp-import

info "Importing a document."
echo "ghp-import $WERCKER_GHP_IMPORT_MSG -b $WERCKER_GHP_IMPORT_BRANCH $WERCKER_GHP_IMPORT_BASEDIR"
ghp-import $WERCKER_GHP_IMPORT_MSG -b $WERCKER_GHP_IMPORT_BRANCH $WERCKER_GHP_IMPORT_BASEDIR

REPOSITORY=${WERCKER_GIT_OWNER}/${WERCKER_GIT_REPOSITORY}
info "Pushing to $REPOSITORY."

URL="https://$WERCKER_GHP_IMPORT_TOKEN@github.com/$REPOSITORY.git"
git push -f "$URL" $WERCKER_GHP_IMPORT_BRANCH
