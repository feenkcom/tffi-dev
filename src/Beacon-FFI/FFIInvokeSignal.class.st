"
Signal function calls made through FFI.

Because there can be so many calls made (e.g. every graphics operation and pulse) the signal includes a flag that disables the signal from being emitted.  The signal is disabled by default.  To enable the signal:

[[[ 
FFIInvokeSignal enabled: true
]]]

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	arguments:		<Object>
	function:		<Object>


    Implementation Points
"
Class {
	#name : #FFIInvokeSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'function',
		'arguments'
	],
	#classVars : [
		'Enabled'
	],
	#category : #'Beacon-FFI'
}

{ #category : #accessing }
FFIInvokeSignal class >> enabled [ 

	^Enabled ifNil: [ false ].
]

{ #category : #accessing }
FFIInvokeSignal class >> enabled: aBoolean [

	Enabled := aBoolean
]

{ #category : #accessing }
FFIInvokeSignal >> arguments [
	^ arguments
]

{ #category : #accessing }
FFIInvokeSignal >> arguments: anObject [
	arguments := anObject
]

{ #category : #'instance creation' }
FFIInvokeSignal >> emit [ 

	self enabled ifTrue: [ super emit ].
]

{ #category : #accessing }
FFIInvokeSignal >> enabled [ 

	^Enabled ifNil: [ false ]
]

{ #category : #accessing }
FFIInvokeSignal >> function [
	^ function
]

{ #category : #accessing }
FFIInvokeSignal >> function: anObject [
	function := anObject
]

{ #category : #printing }
FFIInvokeSignal >> printOn: aStream [

	aStream
		nextPut:$<;
		nextPutAll: function callingConventionString; nextPutAll:': '.
	{ 'threaded' } with: { function class callingConventionModifierFor: 'threaded' } do:
		[:modifier :flag|
		(function flags anyMask: flag) ifTrue:
			[aStream nextPutAll: modifier; space]].
	aStream print: function argTypes first; space.
	self name == nil
		ifTrue:[aStream nextPutAll:'(*) ']
		ifFalse:[aStream << function name asString; space].
	aStream nextPut:$(.
	2 to: function argTypes size do:[:i|
		aStream print: (function argTypes at: i).
		i < function argTypes size ifTrue:[aStream space]].
	aStream nextPut: $).
	aStream cr.
	arguments do: [ :each |
		aStream
			<< '    ';
			<< each ffiArgumentString;
			cr. ]
]

{ #category : #printing }
FFIInvokeSignal >> printOneLineContentsOn: aStream [
	"hook to be overriden by subclasses"

	aStream
		nextPut:$<;
		nextPutAll: function callingConventionString; nextPutAll:': '.
	{ 'threaded' } with: { function class callingConventionModifierFor: 'threaded' } do:
		[:modifier :flag|
		(function flags anyMask: flag) ifTrue:
			[aStream nextPutAll: modifier; space]].
	aStream print: function argTypes first; space.
	self name == nil
		ifTrue:[aStream nextPutAll:'(*) ']
		ifFalse:[aStream << function name asString; space].
	aStream nextPut:$(.
	2 to: function argTypes size do:[:i|
		aStream print: (function argTypes at: i).
		i < function argTypes size ifTrue:[aStream space]].
	aStream nextPut: $).
]
