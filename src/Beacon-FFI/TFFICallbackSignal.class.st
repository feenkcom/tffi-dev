Class {
	#name : #TFFICallbackSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'block',
		'arguments'
	],
	#classVars : [
		'Enabled'
	],
	#category : #'Beacon-FFI'
}

{ #category : #accessing }
TFFICallbackSignal class >> enabled [ 

	^Enabled ifNil: [ false ].
]

{ #category : #accessing }
TFFICallbackSignal class >> enabled: aBoolean [

	Enabled := aBoolean
]

{ #category : #accessing }
TFFICallbackSignal >> arguments [
	^ arguments
]

{ #category : #accessing }
TFFICallbackSignal >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
TFFICallbackSignal >> block [
	^ block
]

{ #category : #accessing }
TFFICallbackSignal >> block: anObject [
	block := anObject
]

{ #category : #'instance creation' }
TFFICallbackSignal >> emit [ 

	self enabled ifTrue: [ super emit ].
]

{ #category : #accessing }
TFFICallbackSignal >> enabled [ 

	^Enabled ifNil: [ false ]
]

{ #category : #printing }
TFFICallbackSignal >> printOn: aStream [

	super printOn: aStream.
	aStream cr.
	aStream
		<< 'Block: ';
		print: block;
		cr;
		<< 'Arguments:';
		cr.
	arguments do: [ :each |
		aStream
			<< '    ';
			print: each;
			cr. ].

]

{ #category : #printing }
TFFICallbackSignal >> printOneLineContentsOn: aStream [
	"hook to be overriden by subclasses"

	aStream
		<< 'TFFICallback'.
]
