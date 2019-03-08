#!/usr/bin/expect -f
eval spawn psql -h cmps180-db.lt.ucsc.edu -U daswilli
set prompt "Password for user daswilli:"
interact -o -nobuffer -re $prompt return
send "function02manager\r"
interact