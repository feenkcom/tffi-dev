Extension { #name : #ExternalFunction }

{ #category : #'*Beacon-FFI' }
ExternalFunction >> invokeWithArguments: argArray [
	"Manually invoke the receiver, representing an external function."

	| result |

	FFIInvokeSignal new
		function: self;
		arguments: argArray;
		emit.
	result := self primInvokeWithArguments: argArray.
	FFIResultSignal new
		function: self;
		result: result;
		emit.
	^result
]

{ #category : #'*Beacon-FFI' }
ExternalFunction >> primInvokeWithArguments: argArray [
	"Manually invoke the receiver, representing an external function."
	<primitive: 'primitiveCalloutWithArgs' module: 'SqueakFFIPrims' error: ec>
	^self externalCallFailed
]
