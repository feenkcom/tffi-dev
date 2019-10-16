Class {
	#name : #AkgCallbacks,
	#superclass : #FFICallback,
	#category : #'Beacon-FFI-AKG'
}

{ #category : #'library path' }
AkgCallbacks class >> ffiLibrary [

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ AkgLibTestLibrary ]
		ifFalse: [ super ffiLibraryName ]
]

{ #category : #'instance creation' }
AkgCallbacks class >> null [
	^ ExternalAddress null
]

{ #category : #'instance creation' }
AkgCallbacks class >> on: aBlock [
	^ self 
		signature: self fnSpec 
		block: aBlock 
]

{ #category : #accessing }
AkgCallbacks >> calloutAPIClass [

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]

{ #category : #accessing }
AkgCallbacks >> ffiLibrary [

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ self class ffiLibrary ]
		ifFalse: [ super ffiLibrary ]
]

{ #category : #initialization }
AkgCallbacks >> initializeNull [
	
	self beNull
]
