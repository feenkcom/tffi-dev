Extension { #name : #NonInteractiveTranscript }

{ #category : #'*GToolkit-Iceberg' }
NonInteractiveTranscript >> initializeStream [
	"Open the file stream that I write to or connect to #stdout/#stderr.
	I will use the platform line end convention.
	I will append to regular files."
	
	^ stream := self isStdout 
		ifTrue: [ ZnNewLineWriterStream on: Stdio stdout ]
		ifFalse: [ 
			self isStderr
				ifTrue: [ ZnNewLineWriterStream on: Stdio stderr ]
				ifFalse: [ (File named: self fileName) openForAppend ] ]
]
