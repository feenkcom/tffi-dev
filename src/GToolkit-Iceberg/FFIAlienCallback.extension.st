Extension { #name : #FFIAlienCallback }

{ #category : #'*GToolkit-Iceberg' }
FFIAlienCallback >> valueWithContext: callbackContext sp: stackPointer [ 
	| argumentValues |
	
	self flag: #todo. "This can be optimised in a shadow method"
	argumentValues := self argumentsFor: stackPointer context: callbackContext.
	(Smalltalk includesKey: #FFICallbackSignal) ifTrue: 
		[ FFICallbackSignal new
		block: frontendCallback block;
		arguments: argumentValues;
		emit. ].
	^ frontendCallback functionSpec returnType resolvedType
		callbackReturnOn: callbackContext 
		for: (frontendCallback valueWithArguments: argumentValues)
]
