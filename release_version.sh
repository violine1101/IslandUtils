#!/bin/bash
VERSION=$(grep -oP '^mod_version=(.*)$' gradle.properties | sed 's/mod_version=//')
CREATE_RELEASE=false
if [ -n "$VERSION" ]; then
  echo "# Detected mod version $VERSION\n"
  # Was able to extract version. Check if version already exists:
  git pull --tags
  echo "\n"
  EXISTING_TAG=$(git tag -l $VERSION)
  if [ -z "$EXISTING_TAG" ]; then
    # The tag doesn't exist yet; create a new one
    git tag $VERSION
    echo "\n"
    git push origin tag $VERSION
    echo "\n# Created tag $VERSION\n"
    CREATE_RELEASE=true
  else
    echo "# Tag $VERSION already exists; skipping creation of release\n"
  fi
else
  echo "# No mod version detected\n"
fi
echo "CREATE_RELEASE=$CREATE_RELEASE"
echo "RELEASE_VERSION=$VERSION"
