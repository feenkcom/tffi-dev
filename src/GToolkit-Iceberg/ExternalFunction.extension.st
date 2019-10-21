Extension { #name : #ExternalFunction }

{ #category : #'*GToolkit-Iceberg' }
ExternalFunction >> invokeWithArguments: argArray [
	"Manually invoke the receiver, representing an external function."

	| result |

	(Smalltalk includesKey: #FFIInvokeSignal) ifFalse: 
		[ self primInvokeWithArguments: argArray ].

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

{ #category : #'*GToolkit-Iceberg' }
ExternalFunction >> primInvokeWithArguments: argArray [
	"Manually invoke the receiver, representing an external function."
	<primitive: 'primitiveCalloutWithArgs' module: 'SqueakFFIPrims' error: ec>
	^self externalCallFailed
]
