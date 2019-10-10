"
The following succeeds:

[ AkgFFIstuff new doCalloutFor: 2 seconds.
AkgFFIstuff new doCalloutFor: 1 seconds.
] fork.

[ AkgFFIstuff new doCalloutFor: 2 seconds.
AkgFFIstuff new alienCalloutFor: 1 seconds.
] fork.


While the following fails:

[ AkgFFIstuff new doCalloutFor: 1 seconds.
AkgFFIstuff new doCalloutFor: 2 seconds.
] fork.


And the following crashes the VM:

[ AkgFFIstuff new doCalloutFor: 1 seconds.
AkgFFIstuff new alienCalloutFor: 2 seconds.
] fork.

"
Class {
	#name : #AkgFFIstuff,
	#superclass : #Object,
	#instVars : [
		'runner'
	],
	#category : #'Beacon-FFI-AKG'
}

{ #category : #accessing }
AkgFFIstuff >> alienCalloutFor: aDuration [

	| cb |

	cb := Callback 
		signature: #(int (int))
		block: [ :i | Stdio stdout << 'yay'; lf; flush. aDuration wait.  self shortCallout ].

	[ (Alien lookup: 'singleCallToCallback' inLibrary: self alienLibraryPath)
		primFFICallResult: nil 
		with: cb thunk 
		with: 3. ] fork.
]

{ #category : #accessing }
AkgFFIstuff >> alienLibraryPath [

	Smalltalk os isUnix ifTrue: [ ^ (FileLocator vmDirectory resolve / 'libTestLibrary.so') fullName ].
	Smalltalk os isMacOS ifTrue: [ ^ 'libTestLibrary.dylib' ].
	Smalltalk os isWindows ifTrue: [ ^ 'TestLibrary.dll' ].

	self error: 'Unsupported Platform'
]

{ #category : #accessing }
AkgFFIstuff >> alienSimpleCallback [

	| cb result |

	cb := Callback 
		signature: #(int (int))
		block: [ :i | self shortCallout + i ].

	result := (Alien lookup: 'singleCallToCallback' inLibrary: self alienLibraryPath)
		primFFICallResult: nil 
		with: cb thunk 
		with: 3.

	^result
]

{ #category : #tests }
AkgFFIstuff >> doCalloutFor: aDuration [

	| callback fun returnValue |

	callback := TFCallback 
		forCallback: [ :a | aDuration wait.  self shortCallout ] 
		parameters: { TFBasicType sint. } 
		returnType: TFBasicType sint
		runner: self runner.

	fun := TFExternalFunction
		name: 'singleCallToCallback'
		moduleName: self libraryPath
		definition: (TFFunctionDefinition
			parameterTypes: {TFBasicType pointer. TFBasicType sint}
			returnType: TFBasicType sint).

	[ returnValue := self runner invokeFunction: fun withArguments: {callback getHandle. 3}.
	self assert: returnValue = 42 ] fork.
]

{ #category : #tests }
AkgFFIstuff >> doNested [

	| callback fun fun2 callback2 returnValue |

	callback2 := TFCallback 
		forCallback: [ :a | 5 seconds wait. self shortCallout. ] 
		parameters: { TFBasicType sint. } 
		returnType: TFBasicType sint
		runner: self runner.

	fun2 := TFExternalFunction
		name: 'singleCallToCallback'
		moduleName: self libraryPath
		definition: (TFFunctionDefinition
			parameterTypes: {TFBasicType pointer. TFBasicType sint}
			returnType: TFBasicType sint).


	callback := TFCallback 
		forCallback: [ :a | [ self runner invokeFunction: fun2 withArguments: {callback2 getHandle. 3} ] fork. 35. ] 
		parameters: { TFBasicType sint. } 
		returnType: TFBasicType sint
		runner: self runner.

	fun := TFExternalFunction
		name: 'singleCallToCallback'
		moduleName: self libraryPath
		definition: (TFFunctionDefinition
			parameterTypes: {TFBasicType pointer. TFBasicType sint}
			returnType: TFBasicType sint).


	[ returnValue := self runner invokeFunction: fun withArguments: {callback getHandle. 3}.
	self assert: returnValue = 42 ] fork.
]

{ #category : #accessing }
AkgFFIstuff >> libraryPath [

	Smalltalk os isUnix ifTrue: [ ^ 'libTestLibrary.so' ].
	Smalltalk os isMacOS ifTrue: [ ^ 'libTestLibrary.dylib' ].
	Smalltalk os isWindows ifTrue: [ ^ 'TestLibrary.dll' ].

	self error: 'Unsupported Platform'
]

{ #category : #accessing }
AkgFFIstuff >> runner [

	^runner ifNil: [ runner := TFSameThreadRunner new ]
]

{ #category : #tests }
AkgFFIstuff >> sequence2 [

	| callback fun callback2 fun2 returnValue |

	callback := TFCallback 
		forCallback: [ :a | self shortCallout ] 
		parameters: { TFBasicType sint. } 
		returnType: TFBasicType sint
		runner: self runner.

	fun := TFExternalFunction
		name: 'singleCallToCallback'
		moduleName: self libraryPath
		definition: (TFFunctionDefinition
			parameterTypes: {TFBasicType pointer. TFBasicType sint}
			returnType: TFBasicType sint).

	callback2 := TFCallback 
		forCallback: [ :a | self shortCallout ] 
		parameters: { TFBasicType sint. } 
		returnType: TFBasicType sint
		runner: self runner.

	fun2 := TFExternalFunction
		name: 'singleCallToCallback'
		moduleName: self libraryPath
		definition: (TFFunctionDefinition
			parameterTypes: {TFBasicType pointer. TFBasicType sint}
			returnType: TFBasicType sint).


	returnValue := self runner invokeFunction: fun withArguments: {callback getHandle. 3}.
	self assert: returnValue = 42.
	
	returnValue := self runner invokeFunction: fun2 withArguments: {callback2 getHandle. 3}.
	self assert: returnValue = 42.
]

{ #category : #tests }
AkgFFIstuff >> sequence3 [
	"Simulates the call sequence just before the iceberg crash"
"
FFIInvokeSignal enabled: true.
FFIResultSignal enabled: true.
AkgFFIstuff new sequence3.
FFIInvokeSignal enabled: false.
FFIResultSignal enabled: false.
"

	| callback fun callback2 returnValue |

	callback := TFCallback 
		forCallback: [ :a | a + self shortCallout ] 
		parameters: { TFBasicType sint. } 
		returnType: TFBasicType sint
		runner: self runner.

	fun := TFExternalFunction
		name: 'doubleCallToCallbacks'
		moduleName: self libraryPath
		definition: (TFFunctionDefinition
			parameterTypes: {TFBasicType pointer. TFBasicType pointer. TFBasicType sint}
			returnType: TFBasicType sint).

	callback2 := TFCallback 
		forCallback: [ :a | a * 2 ] 
		parameters: { TFBasicType sint. } 
		returnType: TFBasicType sint
		runner: self runner.


	returnValue := self runner invokeFunction: fun withArguments: {callback2 getHandle. callback getHandle. 3}.
	self assert: returnValue = 48.

]

{ #category : #tests }
AkgFFIstuff >> shortCallout [
	| fun |
	fun := TFExternalFunction
		name: 'shortCallout'
		moduleName: self libraryPath
		definition:
			(TFFunctionDefinition
				parameterTypes: {}
				returnType: TFBasicType sint32).

	^ self runner invokeFunction: fun 
]

{ #category : #tests }
AkgFFIstuff >> simpleCallback [

	| callback fun returnValue |

	callback := TFCallback 
		forCallback: [ :a | (Delay forSeconds: 10) wait.  self shortCallout ] 
		parameters: { TFBasicType sint. } 
		returnType: TFBasicType sint
		runner: self runner.

	fun := TFExternalFunction
		name: 'singleCallToCallback'
		moduleName: self libraryPath
		definition: (TFFunctionDefinition
			parameterTypes: {TFBasicType pointer. TFBasicType sint}
			returnType: TFBasicType sint).

	returnValue := self runner invokeFunction: fun withArguments: {callback getHandle. 3}.
	self assert: returnValue = 42
]
