"
Methods for classes can currently be stored in up to three places:

1. methodDict in Behavior
2. [base]LocalMethods in TraitedMetaClass
3. compiledMethods in FFIMethodRegistry

Ignoring FFIMethodRegistry for the moment:

If a class doesn't have traits, the compiled method will be stored in methodDict.
If a class does have traits, the compiled method will be stored in methodDict and [base]LocalMethods.  In this case, it should be the same instance of the compiled method (this is the important bit).

If the method is a ffi callout and has been called, it will also exist in compiledMethods in FFIMethodRegistry.  In this case, the compiled method in the FFIMethodRegistry should be the same instance as methodDict.  If the class has traits, the #ffiNonCompiledMethod property will be the same as [base]LocalMethods.

inconsistentMethodSource searches for methods that break these rules.

This class was developed while addressing:

- *https://github.com/pharo-project/pharo/issues/4967*
- *https://github.com/pharo-project/pharo/pull/5120*

"
Class {
	#name : #MethodDictionaryConsistencyTest,
	#superclass : #TestCase,
	#category : #'FFI-MethodConsistency'
}

{ #category : #actions }
MethodDictionaryConsistencyTest class >> recompileInconsistent [
	"Recompile all methods where the Class contains inconsistent method definitions"
	<script>

	| before after |

	before := self new inconsistentMethodSource.
	before do: [ :methodComparison | 
		methodComparison recompileMethodDict ].
	after := self new inconsistentMethodSource.
	^{ before. after. }
]

{ #category : #helper }
MethodDictionaryConsistencyTest >> inconsistentMethodSource [
	"Iterate over all method definitions and check that the class is internally consistent.
	See MethodSourceComparison>>sourceMatches for a definition of 'consistent'."

	| results |

	results := OrderedCollection new.
	Object withAllSubclassesDo: [ :class |
		class isMeta ifFalse:
			[ results addAll: (self inconsistentMethodSourceIn: class) ] ].
	^results sorted: [ :a :b | a methodDict methodClass name < b methodDict methodClass name ]
]

{ #category : #helper }
MethodDictionaryConsistencyTest >> inconsistentMethodSourceIn: aClass [
	"Iterate over all method definitions and check that the class is internally consistent.
	See MethodSourceComparison>>sourceMatches for a definition of 'consistent'."

	| results comparisons |

	results := OrderedCollection new.
	comparisons := aClass selectors collect: [ :each | 
		MethodSourceComparison new 
			subjectClassName: aClass name;
			selector: each ].
	comparisons do: [ :each |
			each sourceMatches	
				ifFalse: [ results add: each ] ].
	^results sorted: [ :a :b | a methodDict methodClass name < b methodDict methodClass name ]
]

{ #category : #tests }
MethodDictionaryConsistencyTest >> testMethodConsistency [

	self assert: self inconsistentMethodSource size isZero
]
