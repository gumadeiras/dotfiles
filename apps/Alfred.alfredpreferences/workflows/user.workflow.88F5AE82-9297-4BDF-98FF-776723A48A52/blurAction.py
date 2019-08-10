from subprocess import check_output, call
from platform import mac_ver 
from workflow import Workflow
from time import sleep

wf = Workflow()

version = mac_ver()[0].split('.')

isMavericks = (int(version[1]) >= 9)

command = ['defaults', 'write', 'com.runningwithcrayons.Alfred-2', 'experimentalBlur', '', wf.args[0]]
# command = ['defaults', 'write', 'com.runningwithcrayons.Alfred-2', 'experimentalBlur', '', '2']

if isMavericks:
	command[4] = '-int'
else:
	command[4] = '-float'

print command

call(command)

if (check_output(['osascript', '-e', 'return (application "Alfred Preferences" is running)']).strip() == 'true'):
	prefsIsRunning = True
	call(['osascript', '-e', 'tell application "Alfred Preferences" to quit'])
else:
	prefsIsRunning = False

call(['osascript', '-e', 'tell application "Alfred 2" to quit'])

while (check_output(['osascript', '-e', 'return (application "Alfred 2" is running)']).strip() == 'true'):
	sleep(0.1)

call(['open', '-a', 'Alfred 2.app'])

print prefsIsRunning

if (prefsIsRunning):
	call(['open', '-a', 'Alfred Preferences.app'])

# Show Alfred to let user see new blur value
call(['open', '-a', 'Alfred 2.app'])