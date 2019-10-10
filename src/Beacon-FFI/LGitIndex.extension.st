Extension { #name : #LGitIndex }

{ #category : #'*Beacon-FFI' }
LGitIndex >> index_add_all: index pathspec: pathspec flags: flags callback: callback payload: payload [
	
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
