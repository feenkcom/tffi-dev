Extension { #name : #LGitIndex }

{ #category : #'*GToolkit-Iceberg' }
LGitIndex >> addAll [
	| pathspec |
	pathspec := LGitStringArray withAll: #().
	self withReturnHandlerDo: [ 
		self
			index_add_all: self
			pathspec: pathspec
			flags: 0
			callback: (LGitIndexMatchedPathCallback on: [ :a :b :c | 0 ])
			payload: ExternalAddress null ]
]

{ #category : #'*GToolkit-Iceberg' }
LGitIndex >> addAll: pathSpecs [
	| pathspec |
	pathspec := LGitStringArray withAll: pathSpecs.
	self withReturnHandlerDo: [ 
		self
			index_add_all: self
			pathspec: pathspec
			flags: 0
			callback: (LGitIndexMatchedPathCallback on: [ :a :b :c | 0 ])
			payload: ExternalAddress null ]
]

{ #category : #'*GToolkit-Iceberg' }
LGitIndex >> tFFIindex_add_all: index pathspec: pathspec flags: flags callback: callback payload: payload [
	
	"^ self
		call:
			#(LGitReturnCodeEnum git_index_add_all #(
				self, 
				LGitStringArray *pathspec, 
				uint flags, 
				LGitIndexMatchedPathCallback callback, 
				void *payload))
		options: #(optMayGC optCoerceNilToNull)"

	| function |

	function := TFExternalFunction
		name: 'git_index_add_all'
		moduleName: self ffiLibraryName uniqueInstance unixModuleName
		definition: (TFFunctionDefinition
			parameterTypes: { TFBasicType pointer. TFBasicType pointer. TFBasicType uint. TFBasicType pointer. TFBasicType pointer. }
			returnType: TFBasicType sint).
	^TFSameThreadRunner new invokeFunction: function withArguments: 
		{ self ifNil: [ ExternalAddress null ].
		pathspec ifNil: [ ExternalAddress null ].
		flags.
		callback ifNil: [ ExternalAddress null ].
		payload ifNil: [ ExternalAddress null ]. }
]
