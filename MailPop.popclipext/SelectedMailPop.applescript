-- Slightly modified version of Efficient Computing's AppleScript: http://efficientcomputing.commons.gc.cuny.edu/2012/03/17/copy-email-message-in-mail-app-to-evernote-applescript/
tell application "Mail"
	set selectedMails to the selection
	repeat with theMessage in selectedMails
		
		--get information from message
		set theMessageDate to the date received of theMessage
		set theMessageSender to sender of theMessage
		set theMessageSubject to the subject of the theMessage
		set theMessageURL to "message://%3c" & theMessage's message id & "%3e"
		
		--make a short header
		set theHeader to the all headers of theMessage
		set theShortHeader to (paragraph 1 of theHeader & return & paragraph 2 of theHeader & return & paragraph 3 of theHeader & return & paragraph 4 of theHeader & return & return)
		
		--import message to Evernote
		tell application "Evernote"
			synchronize
			set theNewNote to (create note with text (theMessageURL & return & return & theShortHeader & "{popclip text}"))
			set the title of theNewNote to theMessageSubject
			set the source URL of theNewNote to theMessageURL
			set the creation date of theNewNote to theMessageDate
			synchronize
		end tell
		
	end repeat
end tell