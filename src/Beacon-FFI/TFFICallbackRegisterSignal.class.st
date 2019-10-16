Class {
	#name : #TFFICallbackRegisterSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'callback'
	],
	#category : #'Beacon-FFI'
}

{ #category : #accessing }
TFFICallbackRegisterSignal >> callback [
	^ callback
]

{ #category : #accessing }
TFFICallbackRegisterSignal >> callback: anObject [
	callback := anObject
]

{ #category : #printing }
TFFICallbackRegisterSignal >> printOneLineContentsOn: aStream [
	"hook to be overriden by subclasses"
	
	aStream
		<< 'Register callback: '.
	callback ifNil: [ ^self ].
	aStream
		print: callback frontendCallback.

]
