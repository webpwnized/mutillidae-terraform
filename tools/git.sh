#!/bin/bash

# Check if the number of command-line arguments is not equal to 2
if (( $# != 2 ))
then
    # Print usage message to standard error
    printf "%b" "Usage: git.sh <version> <annotation>\n" >&2
    # Exit with error status
    exit 1
fi

# Assign command-line arguments to variables
VERSION=$1
ANNOTATION=$2

# Print message indicating the tag creation process
echo "Creating tag $VERSION with annotation \"$ANNOTATION\""
# Create an annotated tag with the specified version and annotation
git tag -a $VERSION -m "$ANNOTATION"

# Print message indicating the local commit
echo "Commiting version $VERSION to local branch"
# Commit all changes with the version and annotation as the commit message
git commit -a -m "$VERSION $ANNOTATION"

# Print message indicating the tag push
echo "Pushing tag $VERSION"
# Push the newly created tag to the remote repository
git push --tag

# Print message indicating the version push
echo "Pushing version $VERSION to upstream"
# Push the changes to the remote repository
git push
