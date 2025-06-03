#!/bin/bash

DIRECTORIES=(
    "/home/spatial/Documents"
    "/var/log"
)

#Clears previous content
OUTPUT="/var/lib/node_exporter/textfile_collector/directory_usage.prom" 

> "$OUTPUT"

cat <<EOF >> "$OUTPUT"
# HELP directory_usage_bytes Directory usage in bytes
# TYPE directory_usage_bytes gauge
# HELP directory_usage_percent_used Percent used relative to filesystem
# TYPE directory_usage_percent_used gauge
# HELP directory_usage_percent_free Percent free relative to filesystem
# TYPE directory_usage_percent_free gauge
EOF

for DIRECTORY in "${DIRECTORIES[@]}"; do
  if [ -d "$DIRECTORY" ]; then
    #Get directory size in bytes
    DIRECTORY_SIZE=$(du -sb "$DIRECTORY" | awk '{print $1}')

    #Get total and available space on the filesystem where the directory is
    read TOTAL AVAILABLE <<< $(df -B1 "$DIRECTORY" | awk 'NR==2 {print $2, $4}')
    

    PERCENT_USED=$(awk "BEGIN {printf \"%.2f\", ($DIRECTORY_SIZE/$TOTAL)*100}")
    PERCENT_FREE=$(awk "BEGIN {printf \"%.2f\", ($DIRECTORY_SIZE/$AVAILABLE)*100}")

    CLEAN_NAME=$(echo "$DIRECTORY" | sed 's/\//_/g' | sed 's/^_//')

    cat <<EOF >> "$OUTPUT"
directory_usage_bytes{directory="$DIRECTORY", directory_label="$CLEAN_NAME"} $DIRECTORY_SIZE
directory_usage_percent_used{directory="$DIRECTORY", directory_label="$CLEAN_NAME"} $PERCENT_USED
directory_usage_percent_free{directory="$DIRECTORY", directory_label="$CLEAN_NAME"} $PERCENT_FREE
EOF

  else
    echo "Directory $DIRECTORY does not exist, skipping."
  fi
done


