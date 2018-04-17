.data
SYSIN = 0
STDIN = 0
SYSOUT = 1
STDOUT = 1
SYSEXIT = 60
EXIT_SUCCESS = 0

.text
.global main
main:


# f(0) = 0
# f(1) = 3
# f(n-1) - 7*f(n-2)
func:
	
