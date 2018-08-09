# ppx-sedlex [![Build Status](https://travis-ci.org/ELLIOTTCABLE/sedlex.svg?branch=master)](https://travis-ci.org/ELLIOTTCABLE/sedlex)

## Releases

### New Release

1. Update the "version" in `package.json` to reflect the Sedlex version to publish.
2. Run `make`.
  * There should be 2 uncommitted changes at this point: `SHASUM256.txt` and `package.json`.
3. Commit the changes with the message `Updated binary to v0.30.0`, with the correct version.
4. Push/merge to `master`.
5. Tag the update:

  ```sh
  git checkout master &&
  git pull &&
  make test &&
  git tag v$(node -p 'require("./package.json").version') &&
  git push v$(node -p 'require("./package.json").version')
  ```

6. Publish to npm.

### Inspect a Release Before Publishing

```sh
npm pack
tar xf "ppx-sedlex-$(node -p 'require("./package.json").version').tgz"
cd package
npm run verify
```
