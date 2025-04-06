#!/bin/sh
set -e

echo "Waiting for web service to become available..."

max_attempts=30
attempt=0

until curl -fs http://localhost:8080/ >/dev/null || [ $attempt -eq $max_attempts ]; do
  attempt=$((attempt+1))
  >&2 echo "Attempt $attempt/$max_attempts - Web service not ready yet, sleeping..."
  sleep 1
done

if [ $attempt -eq $max_attempts ]; then
  >&2 echo "Web service did not become available after $max_attempts attempts"
  exit 1
fi

>&2 echo "Web service is up - continuing"