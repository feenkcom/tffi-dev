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
	"Iterate over all method definitions and check that the class is internally consistent in that methods defined in both methodDict and localMethods are the same instance of CompiledMethod"

	| results |

	results := OrderedCollection new.
	Object withAllSubclassesDo: [ :class |
		class localMethods do: [ :localMethod | | comparison |
			comparison := MethodSourceComparison new
				localMethods: localMethod;
				methodDict: (class methodDict at: localMethod selector);
				ffiRegistry: (FFIMethodRegistry uniqueInstance compiledMethods 
					like: localMethod);
				yourself.
			comparison sourceMatches	
				ifFalse: [ results add: comparison ] ] ].
	^results sorted: [ :a :b | a localMethods methodClass name < b localMethods methodClass name ]
]

{ #category : #tests }
MethodDictionaryConsistencyTest >> testMethodConistency [

	self assert: self inconsistentMethodSource size isZero
]
