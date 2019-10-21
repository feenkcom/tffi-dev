Extension { #name : #GlutinContextBuilder }

{ #category : #'*GToolkit-Iceberg' }
GlutinContextBuilder >> mutate: aHandle [

	handle = aHandle ifTrue: [ ^self ].

	self
		assert: [ handle ~= aHandle ]
		description: [ 'Can not replace a handle with the same one' ].
	
	(FFIExternalResourceManager uniqueInstance instVarNamed: #registry) remove: self ifAbsent: [ ].
	"we don't release previous pointer manually because it is freed by native methods"
	handle := aHandle.
	self autoRelease
]
