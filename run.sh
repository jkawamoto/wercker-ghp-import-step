# /bin/bash
if [ -n "$WERCKER_GHP_IMPORT_MSG" ]; then
  WERCKER_GHP_IMPORT_MSG="-m "${WERCKER_GHP_IMPORT_MSG}
fi

info "Installing ghp-import."
pip install --upgrade ghp-import

info "Importing a document."
git config user.email "pleasemailus@wercker.com"
git config user.name "werckerbot"
ghp-import -n $WERCKER_GHP_IMPORT_MSG -b $WERCKER_GHP_IMPORT_BRANCH $WERCKER_GHP_IMPORT_BASEDIR

if [ -n "$WERCKER_GHP_IMPORT_BASEURL" ]; then
  info "Checking out $WERCKER_GHP_IMPORT_BRANCH."
  git checkout $WERCKER_GHP_IMPORT_BRANCH

  info "Installing sitemap-gen."
  pip install --upgrade -e git+https://github.com/jkawamoto/sitemap-gen#egg=sitemap-gen

  info "Generating a sitemap."
  sitemap-gen $WERCKER_GHP_IMPORT_BASEURL

  info "Commiting."
  git commit -a -m "Import sitemap.xml."
fi

REPOSITORY=${WERCKER_GIT_OWNER}/${WERCKER_GIT_REPOSITORY}
info "Pushing to $REPOSITORY."

URL="https://$WERCKER_GHP_IMPORT_TOKEN@github.com/$REPOSITORY.git"
git push -f "$URL" $WERCKER_GHP_IMPORT_BRANCH 2>/dev/null
