Class {
	#name : #AkgBlockCallback,
	#superclass : #AkgCallbacks,
	#category : #'Beacon-FFI-AKG'
}

{ #category : #'callback spec' }
AkgBlockCallback class >> fnSpec [

	^#(int (int a))
]

{ #category : #'instance creation' }
AkgBlockCallback class >> timesTwo [

	^self on: [ :a | MethodStackSignal emit. a * 2 ]
]
