"
Since callbacks can be called a lot, and this logging isn't required most of the time the code to call it needs to be added in TFCallbackInvocation:

[[[ 
""operations""
execute 
	|  returnValue |

	TFFICallbackSignal new 
		block: callback frontendCallback;
		arguments: self arguments;
		emit.
	returnValue := callback frontendCallback valueWithArguments: self arguments.
	TFFIResultSignal new
		function: callback frontendCallback;
		result: returnValue;
		emit.

	self isNull 
		ifTrue: [ ^ self  ].

	callback returnType isVoid 
		ifFalse: [ self writeReturnValue: returnValue ].

	self runner returnCallback: self
]]]
"
Class {
	#name : #TFFICallbackSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'block',
		'arguments'
	],
	#category : #'Beacon-FFI'
}

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
