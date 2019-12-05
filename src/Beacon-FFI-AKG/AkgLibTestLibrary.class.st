Class {
	#name : #AkgLibTestLibrary,
	#superclass : #FFILibrary,
	#instVars : [
		'initialized'
	],
	#category : #'Beacon-FFI-AKG'
}

{ #category : #converting }
AkgLibTestLibrary >> calloutAPIClass [
	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]

{ #category : #'accessing platform' }
AkgLibTestLibrary >> macModuleName [
	| pluginDir |
	pluginDir := Smalltalk vm binary parent / 'Plugins'.
	#('libTestLibrary.dylib')
		detect: [ :each | (pluginDir / each) exists ] 
		ifFound: [ :libName | ^ (pluginDir / libName) fullName  ].

	self error: 'Module not found.'
]

{ #category : #accessing }
AkgLibTestLibrary >> runner [ 

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFSameThreadRunner uniqueInstance ]
		ifFalse: [ super runner ]

]

{ #category : #'accessing platform' }
AkgLibTestLibrary >> unixModuleName [
	| pluginDir |
	pluginDir := Smalltalk vm binary parent.
	#('libTestLibrary.so')
		detect: [ :each | (pluginDir / each) exists ] 
		ifFound: [ :libName | ^ (pluginDir / libName) fullName ].

	self error: 'Module not found.'
]
