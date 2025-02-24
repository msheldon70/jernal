#!/bin/bash
set -e

# Check if MongoDB has been initialized by looking for a marker file
if [ ! -f /data/db/.initialized ]; then
  echo "Initializing MongoDB..."

  # Start MongoDB in forked mode, binding only to localhost for security during initialization
  mongod --fork --logpath /var/log/mongod.log --bind_ip localhost

  # Wait until MongoDB is ready to accept connections
  RET=1
  while [[ ${RET} -ne 0 ]]; do
      echo "Waiting for MongoDB to start..."
      sleep 1
      mongo --eval "db.adminCommand('ping')" >/dev/null 2>&1
      RET=$?
  done

  # If root username and password are provided, create the admin user
  if [ -n "$MONGO_INITDB_ROOT_USERNAME" ] && [ -n "$MONGO_INITDB_ROOT_PASSWORD" ]; then
    echo "Creating admin user..."
    mongo admin --eval "db.createUser({user: '$MONGO_INITDB_ROOT_USERNAME', pwd: '$MONGO_INITDB_ROOT_PASSWORD', roles:[{role:'root', db:'admin'}]});"
  fi

  # Mark that initialization has been completed
  touch /data/db/.initialized

  # Shutdown the forked mongod instance
  mongo admin --eval "db.shutdownServer()"
  echo "MongoDB initialization complete."
fi

# Finally, start MongoDB in the foreground with the provided CMD arguments
exec "$@"