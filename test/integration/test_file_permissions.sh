#!/bin/sh

## @file test_file_permissions.sh
## @author Kolby <kolby@fasterdevops.com>
## @description Integration test for file permissions
## @see https://www.owasp.org/index.php/Test_File_Permission_(OTG-CONFIG-009)

# Correct File Permissions:
# 750(rwx-wx---) scripts
# 750(rwx-wx---) scripts_directory
# 600(rw-------) configuration
# 700(rwx------) configuration_directory
# 640(rw-r-----) log_files
# 400(r--------) archived_log_files
# 700(rwx------) log_files_directory
# 600(rw-------) debug_files
# 700(rwx------) debug_files_directory
# 600(rw-------) database_files
# 700(rwx------) database_files_directory
# 600(rw-------) sensitive_info_files_like_keys

TEST_COMMAND="perminator"

make_files() {
  touch     scripts
  mkdir -p  scripts_directory
  touch     configuration
  mkdir -p  configuration_directory
  touch     log_files
  touch     archived_log_files
  mkdir -p  log_files_directory
  touch     debug_files
  mkdir -p  debug_files_directory
  touch     database_files
  mkdir -p  database_files_directory
  touch     sensitive_info_files_like_keys
}

open_perms() {
  chmod 777 scripts
  chmod 777 scripts_directory
  chmod 777 configuration
  chmod 777 configuration_directory
  chmod 777 log_files
  chmod 777 archived_log_files
  chmod 777 log_files_directory
  chmod 777 debug_files
  chmod 777 debug_files_directory
  chmod 777 database_files
  chmod 777 database_files_directory
  chmod 777 sensitive_info_files_like_keys
}

check_perms() {
  [ "$(stat -f '%Sp' scripts)"                        = '-rwx-wx---' ]
  [ "$(stat -f '%Sp' scripts_directory)"              = 'drwx-wx---' ]
  [ "$(stat -f '%Sp' configuration)"                  = '-rw-------' ]
  [ "$(stat -f '%Sp' configuration_directory)"        = 'drwx------' ]
  [ "$(stat -f '%Sp' log_files)"                      = '-rw-r-----' ]
  [ "$(stat -f '%Sp' archived_log_files)"             = '-r--------' ]
  [ "$(stat -f '%Sp' log_files_directory)"            = 'drwx------' ]
  [ "$(stat -f '%Sp' debug_files)"                    = '-rwx------' ]
  [ "$(stat -f '%Sp' debug_files_directory)"          = 'drwx------' ]
  [ "$(stat -f '%Sp' database_files)"                 = '-rw-------' ]
  [ "$(stat -f '%Sp' database_files_directory)"       = 'drwx------' ]
  [ "$(stat -f '%Sp' sensitive_info_files_like_keys)" = '-rw-------' ]
}

main() {
  make_files
  open_perms
  ${TEST_COMMAND}
  check_perms
}

main
