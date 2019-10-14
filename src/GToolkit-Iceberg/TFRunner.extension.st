Extension { #name : #TFRunner }

{ #category : #'*GToolkit-Iceberg' }
TFRunner >> invokeFunction: aTFExternalFunction withArguments: aCollection [ 

	| result |

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
