Extension { #name : #GlutinWindowBuilder }

{ #category : #'*GToolkit-Iceberg' }
GlutinWindowBuilder >> mutate: aHandle [

	handle = aHandle ifTrue: [ ^self ].

	self
		assert: [ handle ~= aHandle ]
		description: [ 'Can not replace a handle with the same one' ].

	(FFIExternalResourceManager uniqueInstance instVarNamed: #registry) remove: self ifAbsent: [ ].
	"we don't release previous pointer manually because it is freed by native methods"
	handle := aHandle.
	self autoRelease
]

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
