#!/bin/bash

# server-stats.sh - A script to display basic server performance statistics

# Function to get total CPU usage
get_cpu_usage() {
  echo "Total CPU Usage:"
  mpstat | awk '/all/ {printf "User: %.2f%%, System: %.2f%%, Idle: %.2f%%\n", 100-$12, $5, $12}'
  echo
}

# Function to get memory usage
get_memory_usage() {
  echo "Total Memory Usage:"
  free -h | awk 'NR==2 {printf "Used: %s, Free: %s, Percentage: %.2f%%\n", $3, $4, ($3/$2)*100}'
  echo
}

# Function to get disk usage
get_disk_usage() {
  echo "Total Disk Usage:"
  df -h --total | awk '/total/ {printf "Used: %s, Available: %s, Usage: %s\n", $3, $4, $5}'
  echo
}

# Function to get top 5 processes by CPU usage
get_top_cpu_processes() {
  echo "Top 5 Processes by CPU Usage:"
  ps -eo pid,user,%cpu,%mem,command --sort=-%cpu | head -n 6
  echo
}

# Function to get top 5 processes by memory usage
get_top_memory_processes() {
  echo "Top 5 Processes by Memory Usage:"
  ps -eo pid,user,%cpu,%mem,command --sort=-%mem | head -n 6
  echo
}

# Stretch goal: Additional server stats
get_additional_stats() {
  echo "Additional Server Stats:"
  echo "OS Version: $(lsb_release -d | awk -F'\t' '{print $2}')"
  echo "Uptime: $(uptime -p)"
  echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
  echo "Logged-in Users: $(who | wc -l)"
  echo "Failed Login Attempts: $(grep 'Failed password' /var/log/auth.log | wc -l)"
  echo
}

# Main function
main() {
  echo "Server Performance Stats"
  echo "========================="
  get_cpu_usage
  get_memory_usage
  get_disk_usage
  get_top_cpu_processes
  get_top_memory_processes
  get_additional_stats
}

# Run the main function
main

