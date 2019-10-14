Class {
	#name : #TFFIResultSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'function',
		'result'
	],
	#classVars : [
		'Enabled'
	],
	#category : #'Beacon-FFI'
}

{ #category : #accessing }
TFFIResultSignal class >> enabled [ 

	^Enabled ifNil: [ false ].
]

{ #category : #accessing }
TFFIResultSignal class >> enabled: aBoolean [

	Enabled := aBoolean
]

{ #category : #'instance creation' }
TFFIResultSignal >> emit [ 

	self enabled ifTrue: [ super emit ].
]

{ #category : #accessing }
TFFIResultSignal >> enabled [ 

	^Enabled ifNil: [ false ]
]

{ #category : #accessing }
TFFIResultSignal >> function [
	^ function
]

{ #category : #accessing }
TFFIResultSignal >> function: anObject [
	function := anObject
]

{ #category : #printing }
TFFIResultSignal >> printOneLineContentsOn: aStream [

	aStream
		print: function;
		<< ': ';
		print: result.
]

{ #category : #accessing }
TFFIResultSignal >> result [
	^ result
]

{ #category : #accessing }
TFFIResultSignal >> result: anObject [
	result := anObject
]
