#!/bin/bash
# Copy migration config to module.
set -e

MODULE=$1
PARAMETERS=${@:2}

source ./scripts/copy-config-to-module.sh

function show_help {
cat << EOF
 Copy migration config files into existing module. it use
 Usage: ./scripts/copy-migration-config-to-module.sh [module name] [additional parameters]

 Examples:
  ./scripts/copy-config-to-module.sh my_awesome_module --group wordpress_legacy_site
EOF
}

if [ "$#" -le 1 ]; then
    echo "Illegal number of parameters"
    show_help
    exit
fi

MODULE_DIR=$(find . -name $MODULE.info.yml | xargs dirname)
MODULE_DIR="$MODULE_DIR/config/install"
mkdir -p $MODULE_DIR

# Get entities naming the current entity.
MIGRATIONS=$(drush ms $PARAMETERS --format=string --fields=id || echo "")

if [ -z "$MIGRATIONS" ]; then
  echo "No migrations found."
  show_help
  exit
fi

# Check for feld storage config entities.
for MIGRATION in $MIGRATIONS
do

  CONFIG="migrate_plus.migration.$MIGRATION.yml"
  copy_config $CONFIG $MODULE_DIR

done
