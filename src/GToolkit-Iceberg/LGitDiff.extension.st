Extension { #name : #LGitDiff }

{ #category : #'*GToolkit-Iceberg' }
LGitDiff >> filesDo: filesBlockOrNil binaryFilesDo: binaryBlockOrNil hunksDo: hunksBlockOrNil linesDo: linesBlockOrNil [
	^ ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
		self
		tFFIdiff_foreach: self
		file_cb: (filesBlockOrNil 
			ifNotNil: [ LGitDiffFileCallback on: filesBlockOrNil ]
			ifNil: [ LGitCallback null ])
		binary_cb: (binaryBlockOrNil 
			ifNotNil: [ 	LGitDiffBinaryCallback on: binaryBlockOrNil ]
			ifNil: [ LGitCallback null ])
		hunk_cb: (hunksBlockOrNil 
			ifNotNil: [ 	LGitDiffHunkCallback on: hunksBlockOrNil ]
			ifNil: [ LGitCallback null ])
		line_cb: (linesBlockOrNil 
			ifNotNil: [ 	LGitDiffLineCallback on: linesBlockOrNil ]
			ifNil: [ LGitCallback null ])
		payload: ExternalAddress null ]
	ifFalse: [ 
		self
		diff_foreach: self
		file_cb: (filesBlockOrNil 
			ifNotNil: [ LGitDiffFileCallback on: filesBlockOrNil ]
			ifNil: [ LGitCallback null ])
		binary_cb: (binaryBlockOrNil 
			ifNotNil: [ 	LGitDiffBinaryCallback on: binaryBlockOrNil ]
			ifNil: [ LGitCallback null ])
		hunk_cb: (hunksBlockOrNil 
			ifNotNil: [ 	LGitDiffHunkCallback on: hunksBlockOrNil ]
			ifNil: [ LGitCallback null ])
		line_cb: (linesBlockOrNil 
			ifNotNil: [ 	LGitDiffLineCallback on: linesBlockOrNil ]
			ifNil: [ LGitCallback null ])
		payload: ExternalAddress null ]
]

{ #category : #'*GToolkit-Iceberg' }
LGitDiff >> tFFIdiff_foreach: diff file_cb: file_cb binary_cb: binary_cb hunk_cb: hunk_cb line_cb: line_cb payload: payload [
	
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
