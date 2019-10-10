Class {
	#name : #FFICallbackRegisterSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'callback'
	],
	#category : #'Beacon-FFI'
}

{ #category : #accessing }
FFICallbackRegisterSignal >> callback [
	^ callback
]

{ #category : #accessing }
FFICallbackRegisterSignal >> callback: anObject [
	callback := anObject
]

{ #category : #printing }
FFICallbackRegisterSignal >> printOneLineContentsOn: aStream [
	"hook to be overriden by subclasses"
	
	aStream
		<< 'Register callback: '.
	callback ifNil: [ ^self ].
	aStream
		print: callback frontendCallback.

]
