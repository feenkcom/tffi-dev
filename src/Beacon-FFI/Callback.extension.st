Extension { #name : #Callback }

{ #category : #'*Beacon-FFI' }
Callback >> initialize [ 

	StringSignal emit: 'ALIEN: Callback created'.
	super initialize.
]

{ #category : #'*Beacon-FFI' }
Callback >> thunk [

	StringSignal emit: 'ALIEN callback thunked'.
	^thunk
]
