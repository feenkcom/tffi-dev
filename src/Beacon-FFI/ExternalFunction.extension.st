Extension { #name : #ExternalFunction }

{ #category : #'*Beacon-FFI' }
ExternalFunction >> invokeWithArguments: argArray [
	"Manually invoke the receiver, representing an external function."

	FFIInvokeSignal new
		function: self;
		arguments: argArray;
		emit.
	^self primInvokeWithArguments: argArray
]

{ #category : #'*Beacon-FFI' }
ExternalFunction >> primInvokeWithArguments: argArray [
	"Manually invoke the receiver, representing an external function."
	<primitive: 'primitiveCalloutWithArgs' module: 'SqueakFFIPrims' error: ec>
	^self externalCallFailed
]
