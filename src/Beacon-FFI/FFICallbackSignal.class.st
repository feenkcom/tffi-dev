Class {
	#name : #FFICallbackSignal,
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
FFICallbackSignal >> arguments [
	^ arguments
]

{ #category : #accessing }
FFICallbackSignal >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
FFICallbackSignal >> block [
	^ block
]

{ #category : #accessing }
FFICallbackSignal >> block: anObject [
	block := anObject
]

{ #category : #printing }
FFICallbackSignal >> printOn: aStream [

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
FFICallbackSignal >> printOneLineContentsOn: aStream [
	"hook to be overriden by subclasses"

	aStream
		<< 'FFICallback'.
]
