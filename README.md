ghp-import step for Wercker
=========================
[![wercker status](https://app.wercker.com/status/174391855078cb6ce10ea72be4e8e539/m "wercker status")](https://app.wercker.com/project/bykey/174391855078cb6ce10ea72be4e8e539)

A [wercker](http://wercker.com/) step to import a document to GitHub Pages by [ghp-import](https://pypi.python.org/pypi/ghp-import).

Options
---------
- token: [Github Personal access tokens](https://github.com/settings/tokens)
  with `public_repo` score for public repository or otherwise `repo` scope.
  **Use a protected environment variable.**
- basedir: Directory path to the document root.
- msg: Optional commit message.
- branch: Branch name to be pushed. (Default: `gh-pages`)
- baseurl: If set, `sitemap.xml` will be generated based on the given base URL.

License
=========
This software is released under the MIT License, see [LICENSE](https://github.com/jkawamoto/wercker-ghp-import-step/blob/master/LICENSE).
