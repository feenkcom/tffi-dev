"
Signal function calls made through FFI.

Because there can be so many calls made (e.g. every graphics operation and pulse) the signal includes a flag that disables the signal from being emitted.  The signal is disabled by default.  To enable the signal:

``` 
FFIInvokeSignal enabled: true
```

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
		'arguments',
		'return'
	],
	#category : #'Beacon-FFI'
}

{ #category : #accessing }
FFIInvokeSignal >> arguments [
	^ arguments
]

{ #category : #accessing }
FFIInvokeSignal >> arguments: anObject [
	arguments := anObject
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

	super printOn: aStream.
	aStream cr.
	aStream
		<< 'Function: ';
		<< function getHandle ffiArgumentString;
		cr;
		<< 'Arguments:';
		cr.
	arguments do: [ :each |
		aStream
			<< '    ';
			<< each ffiArgumentString;
			cr. ].
	aStream
		<< 'Return type:';
		cr;
		<< '    ';
		<< return ffiArgumentString.

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

{ #category : #accessing }
FFIInvokeSignal >> return [
	^ return
]

{ #category : #accessing }
FFIInvokeSignal >> return: anObject [
	return := anObject
]
