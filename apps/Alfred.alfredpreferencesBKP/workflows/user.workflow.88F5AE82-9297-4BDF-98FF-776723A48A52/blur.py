import subprocess
import platform
from os import devnull
from workflow import Workflow

version = platform.mac_ver()[0].split('.')
items = []

if int(version[0]) == 10:
	isMavericks = (int(version[1]) >= 9)
else:
	raise SystemExit

if isMavericks:
	number_format = "whole"
	isFloat = False
	max_value = 15
else:
	number_format = "decimal"
	isFloat = True
	max_value = 5.0

wf = Workflow()

currentBlur = 0

try:
  with open(devnull, 'w') as void:
    currentBlur = subprocess.check_output(['defaults', 'read', 'com.runningwithcrayons.Alfred-2', 'experimentalBlur'], stderr=void).strip()
except:
  pass

if (currentBlur > max_value):
	notice = u" (Invalid)"
else:
	notice = u""
wf.add_item(u"Blur is set to {} of {}".format(currentBlur, max_value, notice),
icon="icons/{}.png".format(int(round(float(currentBlur) / float(max_value) * 5.0))))

if len(wf.args) > 0 and wf.args[0]:
	try:
		value = float(wf.args[0]) if isFloat else int(wf.args[0])
	except ValueError:
		wf.add_item(u"Invalid Number", subtitle="Value must be a {} number between 0 and {}".format(number_format, max_value))
		wf.send_feedback()
		raise SystemExit
	
	if value >= 0 and value <= max_value:
		wf.add_item(u"Set blur radius to {} of {}".format(value, max_value),
		# subtitle=u"Blur radius must be a {} number between 0 and {}".format(number_format, max_value),
		arg=u"{}".format(value),
		icon=u"icons/{}.png".format(int(round(float(value) / float(max_value) * 5.0))),
		valid=True)
	else:
		wf.add_item(u"Invalid Number",
		subtitle=u"Value must be a {} number between 0 and {}".format(number_format, max_value))

else:
	descriptions = [u"Very Low", u"Low", u"Medium", u"High", u"Very High"]
	
	for i in range(5):
		value = max_value / 5 * (i + 1)
		wf.add_item(descriptions[i],
		subtitle=u"Set blur radius to {} of {}".format(value, max_value),
		arg=str(value),
		icon=u"icons/{}.png".format(i),
		valid=True)
	
	wf.add_item(u"Off",
	subtitle=u"Set blur radius to 0 of {}".format(max_value),
	arg=str(0),
	icon=u"icons/0.png",
	valid=True)

wf.send_feedback()
