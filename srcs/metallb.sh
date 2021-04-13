#!/usr/bin/expect -f

set ip [lindex $argv 0]

set timeout -1

spawn minikube addons configure metallb

expect {

"*IP*" { send -- "$ip\r" }

"*End*" { send -- "$ip\r" }

}

expect {

"*IP*" { send -- "$ip\r" }

"*End*" { send -- "$ip\r" }

}

expect eof