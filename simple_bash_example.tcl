# import expect package
package require Expect

#run or "spawn" the bash process
spawn bash

#send command to the bash processes
exp_send "ls -l\n"

set accum {}

#expect the bash processes to return an output matching the below regular expression
expect {
    -regexp {..*} {
		#store output from bash process in variable accum
        set accum "${accum}$expect_out(0,string)" 
        exp_continue
    }
}

#create an output file
set filename "simple_bash_example_output.txt"
# open the filename for writing
set fileId [open $filename "w"]

puts -nonewline $fileId $accum