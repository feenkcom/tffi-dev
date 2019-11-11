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
					like: self localMethods)
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
	^ (Smalltalk at: self subjectClassName) localMethods
		detect: [ :each | each selector = self selector ]
		ifNone: [ nil ]
]

{ #category : #accessing }
MethodSourceComparison >> methodDict [
	^ (Smalltalk at: self subjectClassName) methodDict at: self selector
]

{ #category : #printing }
MethodSourceComparison >> printOn: aStream [

	self localMethods ifNil: 
		[ ^super printOn: aStream ].

	aStream
		print: self localMethods;
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

	((self methodDict ~~ self localMethods) and: [ self methodDict notNil and: [ self localMethods notNil ]]) ifTrue: 
		[ reason := 'methodDict ~~ localMethods'.
		^false ].

	((self methodDict ~~ self ffiRegistry) and: [ self methodDict notNil and: [ self ffiRegistry notNil ]]) ifTrue: 
		[ reason := 'methodDict ~~ ffiRegistry'.
		^false ].

	((self ffiRegistry ~~ self localMethods) and: [ self ffiRegistry notNil and: [ self localMethods notNil ]]) ifTrue: 
		[ reason := 'ffiRegistry ~~ localMethods'.
		^false ].

	^self sourceSelectorMatchesFor: self methodDict.

]

{ #category : #testing }
MethodSourceComparison >> sourceSelectorMatchesFor: aCompiledMethod [
	"Answer a boolean indicating whether the selector from the source code on file matches the methods selector and has valid parameter names (a bit simplistic, no 'arg1')"

	| source parseTree |

	source := aCompiledMethod getSourceFromFile.
	source ifEmpty: [ reason := 'empty source from file'.
		^false ].
	parseTree := RBParser 
		parseMethod: source
		onError: [ reason := 'parser error'.
		^false ].
	parseTree methodClass: aCompiledMethod methodClass.

	parseTree arguments 
		detect: [ :each | each name = #arg1 ]
		ifFound: [ reason := 'arg1 found'.
		^false ].

	^true.
]

{ #category : #accessing }
MethodSourceComparison >> subjectClassName [
	^ subjectClassName
]

{ #category : #accessing }
MethodSourceComparison >> subjectClassName: anObject [
	subjectClassName := anObject asSymbol
]
