#!/bin/sh

# Debugging urls:
# https://partner.steamgames.com/doc/sdk/uploading#Troubleshooting_SteamPipe
# https://partner.steamgames.com/doc/sdk/uploading#Debugging_Build_Issues
#
echo ""
su steam
echo "pwd"
pwd
echo ""
echo "ls -lah"
ls -lah
echo "ls -lah build"
ls -lah build
echo ""
echo "ls -lah build/StandaloneWindows64"
ls -lah build/StandaloneWindows64

echo ""
echo "#################################"
echo "#        Uploading build        #"
echo "#################################"
echo ""

"$STEAMCMDDIR/steamcmd.sh" \
  +login "$INPUT_USERNAME" "$INPUT_PASSWORD" "$INPUT_MFACODE" \
  +run_app_build_http $(pwd)/manifest.vdf \
  +api_logging verbose \
  +log_ipc verbose \
  +quit || (
    echo ""
    echo "#################################"
    echo "#             Errors            #"
    echo "#################################"
    echo ""
    echo "Listing current folder and rootpath"
    echo ""
    ls -alh
    echo ""
    ls -alh $rootPath
    echo ""
    echo "Listing logs folder:"
    echo ""
    ls -Ralph /github/home/Steam/logs/
    echo ""
    echo "Displaying error log"
    echo ""
    cat /github/home/Steam/logs/stderr.txt
    echo ""
    echo "Displaying bootstrapper log"
    echo ""
    cat /github/home/Steam/logs/bootstrap_log.txt
    echo ""
    echo "#################################"
    echo "#             Output            #"
    echo "#################################"
    echo ""
    ls -Ralph BuildOutput
    exit 1
  )

echo $?
