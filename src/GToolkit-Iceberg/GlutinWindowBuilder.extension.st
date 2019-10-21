Extension { #name : #GlutinWindowBuilder }

{ #category : #'*GToolkit-Iceberg' }
GlutinWindowBuilder >> primWithTitle: aString [
	^ self ffiCall: #(void* glutin_window_builder_with_title(#GlutinWindowBuilder self, String aString))
]

{ #category : #'*GToolkit-Iceberg' }
GlutinWindowBuilder >> title: aString [
	| encodedString |
	title := aString.
	
	"encodedString := ByteArray streamContents: [ :aStream |
		ZnUTF8Encoder new 
			next: aString size 
			putAll: aString asString
			startingAt: 1 
			toStream: aStream.
		aStream nextPut: 0 ]."
	
	self mutate: (self primWithTitle: (title, (String with: Character null)))
]
