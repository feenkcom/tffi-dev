Extension { #name : #Object }

{ #category : #'*GToolkit-Iceberg' }
Object >> ffiCall: fnSpec [
	<ffiCalloutTranslator>

	^ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
	 (self ffiCalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: self ffiLibrary uniqueInstance options;
		tffiFunction: fnSpec module: self ffiLibrary uniqueInstance
	] ifFalse: [ 
	 (self ffiCalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: self ffiLibrary uniqueInstance options;
		function: fnSpec module: self ffiLibrary uniqueInstance
	].
]

{ #category : #'*GToolkit-Iceberg' }
Object >> ffiCall: fnSpec module: aModuleName [
	<ffiCalloutTranslator>
	
	| ffiLibrary |

	ffiLibrary := aModuleName asFFILibrary.
	^ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
	(ffiLibrary calloutAPIClass inContext: thisContext sender)
		convention: self ffiCallingConvention;
		options: ffiLibrary options;
		tffiFunction: fnSpec module: aModuleName
	] ifFalse: [ 
	(ffiLibrary calloutAPIClass inContext: thisContext sender)
		convention: self ffiCallingConvention;
		options: ffiLibrary options;
		function: fnSpec module: aModuleName
	]
]

{ #category : #'*GToolkit-Iceberg' }
Object >> ffiCall: fnSpec module: aModuleName options: callOptions [
	<ffiCalloutTranslator>
	
	| ffiLibrary |
	
	ffiLibrary := aModuleName asFFILibrary.	
	^ThreadedFFIMigration threadedFFIAvailable  ifTrue: [ 
	(ffiLibrary calloutAPIClass inContext: thisContext sender)
		convention: self ffiCallingConvention;
		options: (ffiLibrary options), callOptions;
		tffiFunction: fnSpec module: aModuleName
	] ifFalse: [ 
	(ffiLibrary calloutAPIClass inContext: thisContext sender)
		convention: self ffiCallingConvention;
		options: (ffiLibrary options), callOptions;
		function: fnSpec module: aModuleName
	]
]

{ #category : #'*GToolkit-Iceberg' }
Object >> ffiCall: fnSpec options: callOptions [
	<ffiCalloutTranslator>

	^ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
	(self ffiCalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: (self ffiLibrary options), callOptions;
		tffiFunction: fnSpec module: self ffiLibrary moduleName
	] ifFalse: [ 
	(self ffiCalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: (self ffiLibrary options), callOptions;
		function: fnSpec module: self ffiLibrary moduleName
	]
]
