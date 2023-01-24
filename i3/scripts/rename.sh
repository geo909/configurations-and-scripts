#!/bin/bash
# Rename current workspace

WS=`python3 -c "import json; print(next(filter(lambda w: w['focused'], json.loads('$(i3-msg -t get_workspaces)')))['num'])"`

exec i3-input -f 'DejaVu Sans Mono-16' -F "rename workspace to $WS:%s" -P 'New name: '
#exec i3-input -f 'DejaVu Sans Mono-16' -f "-*-dejavu sans mono-*-*-*-*-*-*-*-*-*-*-*-*" -F "rename workspace to $WS:%s" -P 'New name: '




