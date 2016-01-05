et the working application directory
working_directory "/app/current"

# Unicorn PID file location
pid "/app/current/pids/unicorn.pid"

# Path to logs
stderr_path "/app/current/log/unicorn.log"
stdout_path "/app/current/log/unicorn.log"

# Unicorn socket
listen "/app/current/pids/unicorn.sock"

# Number of processes
worker_processes 3

# Time-out
timeout 60

