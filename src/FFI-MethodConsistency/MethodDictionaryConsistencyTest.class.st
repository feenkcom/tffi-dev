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
	^results sorted: [ :a :b | a localMethods methodClass name < b localMethods methodClass name ]
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
	^results sorted: [ :a :b | a localMethods methodClass name < b localMethods methodClass name ]
]

{ #category : #tests }
MethodDictionaryConsistencyTest >> testMethodConsistency [

	self assert: self inconsistentMethodSource size isZero
]
