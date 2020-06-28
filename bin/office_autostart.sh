#!/bin/bash

slack &
$HOME/bin/ssb-launcher https://chat.google.com --profile_name work --process_name chat &
mattermost-desktop &
