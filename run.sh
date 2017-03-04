#!/bin/bash
#
# The MIT License (MIT)
#
# Copyright (c) 2016-2017 Junpei Kawamoto
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# This script installs and runs ghp-import to store document in gh-pages.
if [[ -n "$WERCKER_GHP_IMPORT_MSG" ]]; then
  WERCKER_GHP_IMPORT_MSG="--message=\\'${WERCKER_GHP_IMPORT_MSG}\\'"
fi

info 'Installing ghp-import.'
pip install --upgrade ghp-import

info 'Importing a document.'
git config user.email 'pleasemailus@wercker.com'
git config user.name 'werckerbot'
info "ghp-import -n $WERCKER_GHP_IMPORT_MSG -b $WERCKER_GHP_IMPORT_BRANCH $WERCKER_GHP_IMPORT_BASEDIR"
ghp-import -n $WERCKER_GHP_IMPORT_MSG -b $WERCKER_GHP_IMPORT_BRANCH $WERCKER_GHP_IMPORT_BASEDIR

if [[ -n "$WERCKER_GHP_IMPORT_BASEURL" ]]; then
  info "Checking out $WERCKER_GHP_IMPORT_BRANCH."
  git checkout $WERCKER_GHP_IMPORT_BRANCH

  info 'Installing sitemap-gen.'
  pip install --upgrade -e git+https://github.com/jkawamoto/sitemap-gen#egg=sitemap-gen

  info 'Generating a sitemap.'
  sitemap-gen --tracked-files $WERCKER_GHP_IMPORT_BASEURL

  info 'Commiting.'
  git add sitemap.xml
  git commit -m 'Import sitemap.xml.'
fi

readonly REPOSITORY=${WERCKER_GIT_OWNER}/${WERCKER_GIT_REPOSITORY}
info "Pushing to $REPOSITORY."

readonly URL="https://$WERCKER_GHP_IMPORT_TOKEN@github.com/$REPOSITORY.git"
git push -f "$URL" $WERCKER_GHP_IMPORT_BRANCH 2>/dev/null
