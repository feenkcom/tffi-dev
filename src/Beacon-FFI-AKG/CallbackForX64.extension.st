Extension { #name : #CallbackForX64 }

{ #category : #'*Beacon-FFI-AKG' }
CallbackForX64 >> intRetint: callbackContext regs: regsAlien [
	<signature: #(int (int))>
	^callbackContext wordResult:
		(block
			value: (regsAlien signedLongAt: 1))
]
