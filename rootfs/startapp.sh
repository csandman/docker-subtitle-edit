#!/bin/sh

# # Install requested packages.
# if [ "${INSTALL_EXTRA_PKGS:-UNSET}" != "UNSET" ]; then
#   log "installing requested package(s)..."
#   for PKG in $INSTALL_EXTRA_PKGS; do
#     if cat /etc/apk/world | grep -wq "$PKG"; then
#       log "package '$PKG' already installed"
#     else
#       log "installing '$PKG'..."
#       run add-pkg "$PKG" \| log 2>&1
#     fi
#   done
# fi

# # Make sure mandatory directories exist.
# mkdir -p /config/logs

mono /defaults/SubtitleEdit.exe --window max
