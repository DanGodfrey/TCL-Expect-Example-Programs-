package require Expect

  set uname "<put username here>"
  set hostname "ugate.site.uottawa.ca"
  set passwd "<put password here>"

  spawn ssh "$uname@$hostname"

  expect {
      "$uname@$hostname's password:" {
        	  
      }
	 timeout {
		puts "timed out :("
		exit -1
	 }
  }

  exp_send "$passwd\r"
  
  expect {
	#another reg ex notation. Works the same as the other one.
	 -re ".*\$" {
	 	puts "logged in!"
	 }
	 timeout {
	 	puts "timed out :("
		exit -1
	 }
  }
  

