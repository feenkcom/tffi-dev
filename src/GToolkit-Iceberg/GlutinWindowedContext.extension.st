Extension { #name : #GlutinWindowedContext }

{ #category : #'*GToolkit-Iceberg' }
GlutinWindowedContext >> primSetTitle: aString [
	^ self ffiCall: #(void glutin_windowed_context_set_title(GlutinWindowedContext self, String aString))
]

{ #category : #'*GToolkit-Iceberg' }
GlutinWindowedContext >> title: aString [
	| encodedString |

	title := aString.
	
	self isValid
		ifFalse: [ ^ self ].
	
"	encodedString := ByteArray streamContents: [ :aStream |
		ZnUTF8Encoder new 
			next: aString size 
			putAll: aString asString
			startingAt: 1 
			toStream: aStream.
		aStream nextPut: 0 ].
"	
	
	self primSetTitle: (aString, (String with: Character null))
]
