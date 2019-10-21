Extension { #name : #TFCallbackInvocation }

{ #category : #'*GToolkit-Iceberg' }
TFCallbackInvocation >> execute [ 
	|  returnValue |

	TFFICallbackSignal new 
		block: callback frontendCallback block;
		arguments: self arguments;
		emit.
	returnValue := callback frontendCallback valueWithArguments: self arguments.
	TFFIResultSignal new
		function: callback frontendCallback;
		result: returnValue;
		emit.
	
	callback returnType isVoid 
		ifFalse: [ self writeReturnValue: returnValue ].

	self runner returnCallback: self
]
