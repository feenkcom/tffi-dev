Class {
	#name : #MethodSourceComparison,
	#superclass : #Object,
	#instVars : [
		'subjectClassName',
		'selector',
		'reason'
	],
	#category : #'FFI-MethodConsistency'
}

{ #category : #accessing }
MethodSourceComparison >> ffiRegistry [
	^ (FFIMethodRegistry uniqueInstance compiledMethods 
					like: self methodDict)
]

{ #category : #'as yet unclassified' }
MethodSourceComparison >> gtFfiRegistrySourceIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite pharoMethod
		title: 'ffiRegistry';
		smalltalkClass: [ self ffiRegistry methodClass ];
		display: [ self ffiRegistry sourceCode ];
		when: [ self ffiRegistry isNotNil ];
		act: [ self ffiRegistry browse ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			entitled: 'Browse'
]

{ #category : #'as yet unclassified' }
MethodSourceComparison >> gtMethodDictSourceIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite pharoMethod
		title: 'methodDict';
		smalltalkClass: [ self methodDict methodClass ];
		display: [ self methodDict sourceCode ];
		act: [ self methodDict browse ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			entitled: 'Browse';
		when: [ self methodDict isNotNil ]
]

{ #category : #'as yet unclassified' }
MethodSourceComparison >> gtlocalMethodsSourceIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite pharoMethod
		title: 'localMethods';
		smalltalkClass: [ self localMethods methodClass ];
		display: [ self localMethods sourceCode ];
		when: [ self localMethods isNotNil ];
		act: [ self localMethods browse ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			entitled: 'Browse'
]

{ #category : #accessing }
MethodSourceComparison >> localMethods [

	| subjectClass |
	
	subjectClass := (Smalltalk at: self subjectClassName).
	(subjectClass isKindOf: TraitedMetaclass) ifFalse: [ ^nil ].
	^subjectClass localMethods
		detect: [ :each | each selector = self selector ]
		ifNone: [ nil ]
]

{ #category : #accessing }
MethodSourceComparison >> methodDict [
	^ (Smalltalk at: self subjectClassName) methodDict at: self selector
]

{ #category : #printing }
MethodSourceComparison >> printOn: aStream [

	self methodDict ifNil: 
		[ ^super printOn: aStream ].

	aStream
		print: self methodDict;
		<< '(';
		print: self sourceMatches;
		<< ', ';
		<< reason;
		<< ')'.
]

{ #category : #actions }
MethodSourceComparison >> recompileMethodDict [
	"Recompile the receiver's method based on the source from methodDict iff the source doesn't match"

	| sourceMethod |

	"Return if there's nothing to do"
	self sourceMatches ifTrue: [ ^self ].

	Stdio stdout
		<< 'recompile: '
		print: self methodDict;
		lf; flush.

	"Select the best looking source"
	sourceMethod := { self methodDict. self localMethods. self ffiRegistry }
		detect: [ :method | method isNotNil and: [ self sourceSelectorMatchesFor: method ] ]
		ifNone: [ self methodDict ].
	"Recompile it"
	sourceMethod methodClass
		compile: sourceMethod sourceCode
		classified: sourceMethod protocol.
]

{ #category : #accessing }
MethodSourceComparison >> selector [
	^ selector
]

{ #category : #accessing }
MethodSourceComparison >> selector: anObject [
	selector := anObject asSymbol
]

{ #category : #testing }
MethodSourceComparison >> sourceMatches [
	"Answer a boolean indicating whether the receiver is consistent, i.e.:
	- methodDict, localmethods and ffiRegistry are all the same instance of CompiledMethod.
	- the source code selector matches the compiled method selector.
	- the source code has valid parameter names"

	| matches methodDict localMethods ffiRegistry |

	reason := ''.
	methodDict := self methodDict.
	localMethods := self localMethods.
	ffiRegistry := self ffiRegistry.

	ffiRegistry ifNil: [ 
		localMethods ifNil: [ 
			"No ffiRegistry, no traits"
			matches := true.
			 ] ifNotNil: [ 
			"localMethods and methodDict should be the same"
			matches := methodDict == localMethods.
			matches ifFalse: [ reason := 'methodDict ~~ localMethods' ].
			 ]
		 ] ifNotNil: [ 
			localMethods ifNil: [ 
				"ffiRegistry, no traits"
				matches := methodDict == ffiRegistry.
				matches ifFalse: [ reason := 'methodDict ~~ ffiRegistry' ]
				 ] ifNotNil: [ 
				matches := methodDict == ffiRegistry and:
					[ localMethods == (ffiRegistry propertyAt: #ffiNonCompiledMethod) ].
				matches ifFalse: [ reason := 'methodDict ~~ ffiRegistry or ffiNonCompiledMethod mismatch' ]
				 ]
		 ].

	matches ifFalse: [ ^false ].
	^self sourceSelectorMatchesFor: self methodDict.

]

{ #category : #testing }
MethodSourceComparison >> sourceSelectorMatchesFor: aCompiledMethod [
	"Answer a boolean indicating whether the selector from the source code on file matches the methods selector and has valid parameter names (a bit simplistic, no 'arg1')"

	| source parseTree |

	source := aCompiledMethod getSourceFromFile.
	source ifEmpty: [ reason := reason, ', empty source from file'.
		^false ].
	parseTree := RBParser 
		parseMethod: source
		onError: [ reason := reason, ', parser error'.
		^false ].
	parseTree methodClass: aCompiledMethod methodClass.

	^parseTree selector == aCompiledMethod selector.
]

{ #category : #accessing }
MethodSourceComparison >> subjectClassName [
	^ subjectClassName
]

{ #category : #accessing }
MethodSourceComparison >> subjectClassName: anObject [
	subjectClassName := anObject asSymbol
]
