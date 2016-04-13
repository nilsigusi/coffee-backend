# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/app/coffee-backend"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/app/coffee-backend/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/app/coffee-backend/log/unicorn.log"
stdout_path "/app/coffee-backend/log/unicorn.log"

# Unicorn socket
listen "/var/sockets/unicorn.myapp.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30
