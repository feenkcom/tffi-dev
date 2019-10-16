Extension { #name : #TFCallbackInvocation }

{ #category : #'*Beacon-FFI' }
TFCallbackInvocation >> execute [ 
	|  returnValue |
	
	returnValue := callback frontendCallback valueWithArguments: self arguments.
	TFFIResultSignal new
		function: callback frontendCallback;
		result: returnValue;
		emit.
	
	callback returnType isVoid 
		ifFalse: [ self writeReturnValue: returnValue ].

	self runner returnCallback: self
]
