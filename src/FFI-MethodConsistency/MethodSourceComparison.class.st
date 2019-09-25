"
In conjunction with MethodDictionaryConsistencyTest, search for all methods where the source code doesn't match between the methods methodDict, localMethods and the FFIMethodRegistry.

Typically:

[[[ 
MethodDictionaryConsistencyTest new inconsistentMethodSource 
]]]

to find the offending methods.

A clean image typically has decompiled source in localMethods for a number of methods:

[[[ 
MethodDictionaryConsistencyTest new inconsistentMethodSource 
	do: [ :each | each recompileMethodDict ]
]]]

will recompile these and remove the inconsistent methods.
"
Class {
	#name : #MethodSourceComparison,
	#superclass : #Object,
	#instVars : [
		'methodDict',
		'localMethods',
		'ffiRegistry'
	],
	#category : #'FFI-MethodConsistency'
}

{ #category : #accessing }
MethodSourceComparison >> ffiRegistry [
	^ ffiRegistry
]

{ #category : #accessing }
MethodSourceComparison >> ffiRegistry: anObject [
	ffiRegistry := anObject
]

{ #category : #'as yet unclassified' }
MethodSourceComparison >> gtFfiRegistrySourceIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite pharoMethod
		title: 'ffiRegistry';
		smalltalkClass: [ ffiRegistry methodClass ];
		display: [ ffiRegistry sourceCode ];
		when: [ ffiRegistry isNotNil ];
		act: [ ffiRegistry browse ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			entitled: 'Browse'
]

{ #category : #'as yet unclassified' }
MethodSourceComparison >> gtMethodDictSourceIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite pharoMethod
		title: 'methodDict';
		smalltalkClass: [ methodDict methodClass ];
		display: [ methodDict sourceCode ];
		act: [ methodDict browse ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			entitled: 'Browse'
]

{ #category : #'as yet unclassified' }
MethodSourceComparison >> gtlocalMethodsSourceIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite pharoMethod
		title: 'localMethods';
		smalltalkClass: [ localMethods methodClass ];
		display: [ localMethods sourceCode ];
		act: [ localMethods browse ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			entitled: 'Browse'
]

{ #category : #accessing }
MethodSourceComparison >> localMethods [
	^ localMethods
]

{ #category : #accessing }
MethodSourceComparison >> localMethods: anObject [
	localMethods := anObject
]

{ #category : #accessing }
MethodSourceComparison >> methodDict [
	^ methodDict
]

{ #category : #accessing }
MethodSourceComparison >> methodDict: anObject [
	methodDict := anObject
]

{ #category : #printing }
MethodSourceComparison >> printOn: aStream [

	localMethods ifNil: 
		[ ^super printOn: aStream ].

	aStream
		print: localMethods;
		<< '(';
		print: self sourceMatches;
		<< ')'.
]

{ #category : #'as yet unclassified' }
MethodSourceComparison >> recompileMethodDict [
	"Recompile the receiver's method based on the source from methodDict iff the source doesn't match"

	| ast messageNodes |

	self sourceMatches ifTrue: [ ^self ].
	ast := methodDict ast.
	messageNodes := ast allChildren select: [ :each | each class = RBMessageNode ].
	messageNodes do: [ :messageNode |
		#(#call: #call:options: #callUnchecked:options:)
			detect: [ :selector | selector = messageNode selector ] 
			ifFound: [ methodDict methodClass
					compile: methodDict sourceCode
					classified: methodDict protocol ] 
			ifNone: [  ] ].
]

{ #category : #'as yet unclassified' }
MethodSourceComparison >> sourceMatches [

	((methodDict ~~ localMethods) and: [ methodDict notNil and: [ localMethods notNil ]]) ifTrue: 
		[ methodDict sourceCode ~= localMethods sourceCode ifTrue: 
			[ ^false ] ].

	((methodDict ~~ ffiRegistry) and: [ methodDict notNil and: [ ffiRegistry notNil ]]) ifTrue: 
		[ methodDict sourceCode ~= ffiRegistry sourceCode ifTrue: 
			[ ^false ] ].

	((ffiRegistry ~~ localMethods) and: [ ffiRegistry notNil and: [ localMethods notNil ]]) ifTrue: 
		[ ffiRegistry sourceCode ~= localMethods sourceCode ifTrue: 
			[ ^false ] ].

	^true
]
