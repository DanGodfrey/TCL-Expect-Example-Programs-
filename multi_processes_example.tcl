package require Expect

global spawn_id

#create an output file
set filename "multi_process_example_output.txt"
# open the filename for writing
set fileId [open $filename "w"]

spawn bash

set bash_pid $spawn_id

set uname "<put username here>"
set hostname "ugate.site.uottawa.ca"
set passwd "<put password here>"

spawn ssh "$uname@$hostname"

set ssh_pid $spawn_id

expect {
	"$uname@$hostname's password:" {
	}
	timeout {
		puts -nonewline $fileId "timed out..."
		exit -1
	}
}

set spawn_id $bash_pid

exp_send "ls -l\n"

set accum {}

expect {
    -regexp {.*\$} {
		#store output from bash process in variable accum
        set accum "$expect_out(buffer)" 
        exp_continue
    }
}

puts $fileId "This came from the bash processes"
puts $fileId "---------------------------------"
puts $fileId $accum

set spawn_id $ssh_pid

exp_send "$passwd\r"
  
expect {
	-regexp {.*\$} {
		set accum "$expect_out(buffer)" 
	}
	timeout {
		puts "timed out :("
		exit -1
	}
}

puts $fileId "\nThis came from the ssh processes"
puts $fileId "---------------------------------"
puts $fileId $accum