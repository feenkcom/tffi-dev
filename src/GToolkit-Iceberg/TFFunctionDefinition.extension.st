Extension { #name : #TFFunctionDefinition }

{ #category : #'*GToolkit-Iceberg' }
TFFunctionDefinition >> printOn: aStream [

	parameterTypes ifNil: [ ^super printOn: aStream ].
	aStream << '('.
	parameterTypes ifNotEmpty: [ 
		parameterTypes allButLastDo: [ :each |
			aStream
				print: each;
				<< ', ' ].
		aStream print: parameterTypes last ].
	aStream << ')'.
]
