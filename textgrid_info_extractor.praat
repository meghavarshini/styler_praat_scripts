# Modified by Megh Krishnaswamy for use case, original code by Will Styler
# TextGrid information extraction script
# Gathers labels from other tiers on Textgrids
# So if you want to find the label from another tier corresponding to the time of another tier
	#Note: this schema has 2 tiers in the textgrid, and separated by space, not tabs 


grid$ = selected$ ("TextGrid")
resultfile$ = "'grid$'.txt"

# Extracting start and end time, label in tier-2, contents of tier-1
header_row$ = "#"+ tab$ + "start"+ " " + "end" + " " + "addressee" + " " + "transcript" + " " + newline$
fileappend "'resultfile$'" 'header_row$'


selectObject: "TextGrid 'grid$'"
numint = Get number of intervals... 2
# Start the loop
for i from 1 to numint
	lab$ = ""
	selectObject: "TextGrid 'grid$'"
	lab$ = Get label of interval: 2, 'i'
	if lab$ <> ""
		vstart = Get start point: 2, 'i'
		vend = Get end point: 2, 'i'
		vdur = vend - vstart
		midpoint = vstart + (vdur/2)

		# Spit the results into a text file
		int1 = Get interval at time... 1 'midpoint'
		lab1$ = Get label of interval... 1 int1
		# print "'vdur'"
		prevint = int1 - 1
		result_row$ =  "'vstart'" + " " + "'vend'" + " " + "'lab$'" + ": " + "'lab1$'" + " " + newline$ + newline$
		fileappend "'resultfile$'" 'result_row$'
	endif	
endfor
