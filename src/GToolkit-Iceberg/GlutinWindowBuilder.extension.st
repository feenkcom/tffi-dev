Extension { #name : #GlutinWindowBuilder }

{ #category : #'*GToolkit-Iceberg' }
GlutinWindowBuilder >> mutate: aHandle [

	handle = aHandle ifTrue: [ ^self ].

	(FFIExternalResourceManager uniqueInstance instVarNamed: #registry) remove: self ifAbsent: [ ].
	"we don't release previous pointer manually because it is freed by native methods"
	handle := aHandle.
	self autoRelease
]
