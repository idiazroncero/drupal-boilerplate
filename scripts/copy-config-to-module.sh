#!/bin/bash
# Copy config to specific module

# Copy the config entities and remove the filename.
function copy_config {
  CONFIG_NAME=$1
  MODULE_DIR=$2
  cp config/default/$CONFIG_NAME $MODULE_DIR
  sed -i /^uuid:/d $MODULE_DIR/$CONFIG_NAME
  sed -i /^_core:/d $MODULE_DIR/$CONFIG_NAME
  sed -i /^\ \ default_config_hash:/d $MODULE_DIR/$CONFIG_NAME
}
