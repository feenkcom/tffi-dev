Extension { #name : #TFCallback }

{ #category : #'*Beacon-FFI' }
TFCallback >> register [
	
	handle isNull ifFalse: [ ^ self error: 'Callback already registered' ].
	
	self validateTypes.
	self runner ensureInitialized.
	FFICallbackRegisterSignal new
		callback: self;
		emit.
	self registerCallback.
	TFCallbackQueue uniqueInstance registerCallback: self.
]
