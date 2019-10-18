Class {
	#name : #AkgCallouts,
	#superclass : #Object,
	#category : #'Beacon-FFI-AKG'
}

{ #category : #resources }
AkgCallouts class >> ffiLibrary [

	^AkgLibTestLibrary
]

{ #category : #resources }
AkgCallouts >> ffiLibrary [ 

	^self class ffiLibrary
]
