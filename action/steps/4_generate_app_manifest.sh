#!/bin/sh

echo ""
echo "#################################"
echo "#    Generating App Manifest    #"
echo "#################################"
echo ""

mkdir BuildOutput

cat << EOF > "manifest.vdf"
"AppBuild"
{
  "AppID" "$appId"
  "Desc" "$buildDescription"
  "BuildOutput" "BuildOutput"
  "ContentRoot" "$(pwd)"
  "SetLive" "$releaseBranch"
  "Preview" "$previewEnabled"
  "Local" "$localContentServer"

  "Depots"
  {$(echo "$DEPOTS" | sed 's/\\n/\
/g')}
}
EOF
echo "creating manifest.vdf"
cat manifest.vdf
echo ""
