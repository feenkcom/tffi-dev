Extension { #name : #TFRunner }

{ #category : #'*GToolkit-Iceberg' }
TFRunner >> invokeFunction: aTFExternalFunction withArguments: aCollection [ 

	| result |

	(Smalltalk includesKey: #TFFIInvokeSignal) ifFalse: 
		[ ^aTFExternalFunction newCall
		parameters: aCollection;
		executeOn: self ].

	TFFIInvokeSignal new
		function: aTFExternalFunction;
		arguments: aCollection;
		emit.

	result := aTFExternalFunction newCall
		parameters: aCollection;
		executeOn: self.

	TFFIResultSignal new
		function: aTFExternalFunction;
		result: result;
		emit.
	^result
]
