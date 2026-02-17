#!/bin/bash
set -e
dconf load / <gnome.dconf
echo "Done. Log out and back in."
