#!/bin/bash

case "$OSTYPE" in
   linux*)
      open="xdg-open"
      ;;
   darwin*)
      open="open"
      ;;
esac

while [[ $# -gt 0 ]]; do
  case $1 in
    --client-id)
      CLIENT_ID="$2"
      shift 2 # past argument and value
      ;;
    --client-secret)
      CLIENT_SECRET="$2"
      shift 2 # past argument and value
      ;;
    --redirect-uri)
      REDIRECT_URL="$2"
      shift 2 # past argument and value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

$open "https://notify-bot.line.me/oauth/authorize?response_type=code&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URL&scope=notify&state=1234"
echo -n "code: " && read CODE

curl https://notify-bot.line.me/oauth/token --data "grant_type=authorization_code&code=$CODE&redirect_uri=$REDIRECT_URL&client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET"
