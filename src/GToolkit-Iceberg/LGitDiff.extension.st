Extension { #name : #LGitDiff }

{ #category : #'*GToolkit-Iceberg' }
LGitDiff >> diff_foreach: diff file_cb: file_cb binary_cb: binary_cb hunk_cb: hunk_cb line_cb: line_cb payload: payload [
	
	"^ self
		call:
			#(LGitReturnCodeEnum git_diff_foreach #(self , LGitDiffFileCallback file_cb , LGitDiffBinaryCallback binary_cb , LGitDiffHunkCallback hunk_cb , LGitDiffLineCallback line_cb , void * payload))
		options: #(optMayGC optCoerceNilToNull)"

	| function |

	function := TFExternalFunction
		name: 'git_diff_foreach'
		moduleName: self ffiLibraryName uniqueInstance unixModuleName
		definition: (TFFunctionDefinition
			parameterTypes: { TFBasicType pointer. TFBasicType pointer. TFBasicType pointer. TFBasicType pointer. TFBasicType pointer. TFBasicType pointer }
			returnType: TFBasicType sint).
	^TFSameThreadRunner new invokeFunction: function withArguments: 
		{ self.
		file_cb ifNil: [ ExternalAddress null ].
		binary_cb ifNil: [ ExternalAddress null ].
		hunk_cb ifNil: [ ExternalAddress null ].
		line_cb ifNil: [ ExternalAddress null ].
		payload ifNil: [ ExternalAddress null ]. }	
]
