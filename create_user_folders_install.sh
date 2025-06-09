#!/bin/bash

if [ -z "$DOMINO_USER" ]; then
  DOMINO_USER=notes
fi

if [ -z "$DOMINO_GROUP" ]; then
  DOMINO_GROUP=notes
fi

if [ -z "$DIR_PERM" ]; then
  DIR_PERM=770
fi

print_delim()
{
  echo "--------------------------------------------------------------------------------"
}

log_ok ()
{
  echo
  echo "$1"
  echo
}


log_error()
{
  echo
  echo "Failed - $1"
  echo
}


header()
{
  echo
  print_delim
  echo "$1"
  print_delim
  echo
}

install_package()
{
  if [ -x /usr/bin/zypper ]; then
    /usr/bin/zypper install -y "$@"

  elif [ -x /usr/bin/dnf ]; then
    /usr/bin/dnf install -y "$@"

  elif [ -x /usr/bin/tdnf ]; then
    /usr/bin/tdnf install -y "$@"

  elif [ -x /usr/bin/microdnf ]; then
    /usr/bin/microdnf install -y "$@"

  elif [ -x /usr/bin/yum ]; then
    /usr/bin/yum install -y "$@"

  elif [ -x /usr/bin/apt-get ]; then
    /usr/bin/apt-get install -y "$@"

  elif [ -x /usr/bin/pacman ]; then
    /usr/bin/pacman --noconfirm -Sy "$@"

  elif [ -x /sbin/apk ]; then
    /sbin/apk add "$@"

  else
    log_error "No package manager found!"
    exit 1
  fi
}

install_packages()
{
  local PACKAGE=
  for PACKAGE in $*; do
    install_package $PACKAGE
  done
}

add_notes_user()
{
  header "Add Notes user"

  local NOTES_UID=$(id -u $DOMINO_USER 2>/dev/null)
  if [ -n "$NOTES_UID" ]; then
    echo "$DOMINO_USER user already exists (UID:$NOTES_UID)"
    return 0
  fi

  # creates user and group

  groupadd $DOMINO_GROUP
  useradd $DOMINO_USER -g $DOMINO_GROUP -m
}


create_directory()
{
  TARGET_FILE=$1
  OWNER=$2
  GROUP=$3
  PERMS=$4

  if [ -z "$TARGET_FILE" ]; then
    return 0
  fi

  if [ -e "$TARGET_FILE" ]; then
    return 0
  fi

  mkdir -p "$TARGET_FILE"

  if [ ! -z "$OWNER" ]; then
    chown $OWNER:$GROUP "$TARGET_FILE"
  fi

  if [ ! -z "$PERMS" ]; then
    chmod "$PERMS" "$TARGET_FILE"
  fi

  return 0
}


create_directories()
{
  header "Create directory structure /local ..."

  # creates local directory structure with the right owner

  create_directory /local           $DOMINO_USER $DOMINO_GROUP 777
  create_directory /local/dl        $DOMINO_USER $DOMINO_GROUP 777
  create_directory /local/notesdata $DOMINO_USER $DOMINO_GROUP $DIR_PERM
  create_directory /local/translog  $DOMINO_USER $DOMINO_GROUP $DIR_PERM
  create_directory /local/daos      $DOMINO_USER $DOMINO_GROUP $DIR_PERM
  create_directory /local/nif       $DOMINO_USER $DOMINO_GROUP $DIR_PERM
  create_directory /local/ft        $DOMINO_USER $DOMINO_GROUP $DIR_PERM
  create_directory /local/backup    $DOMINO_USER $DOMINO_GROUP $DIR_PERM
}

# Main part

add_notes_user
create_directories

header "Installing required software"

install_packages unzip ncurses jq procps openssl

echo
echo "Done"