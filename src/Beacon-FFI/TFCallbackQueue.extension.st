Extension { #name : #TFCallbackQueue }

{ #category : #'*Beacon-FFI' }
TFCallbackQueue >> executeCallback: aCallbackInvocation [
	
	aCallbackInvocation ifNil: [ ^self ].
	aCallbackInvocation getHandle isNull ifTrue: [ ^self ].
	
	aCallbackInvocation callback: (self lookupCallback: aCallbackInvocation callbackData).
	"StringSignal emit: 'executeCallback: ', aCallbackInvocation callback callbackData printString."
	aCallbackInvocation runner executeCallback: aCallbackInvocation
]
