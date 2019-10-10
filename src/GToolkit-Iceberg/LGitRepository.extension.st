Extension { #name : #LGitRepository }

{ #category : #'*GToolkit-Iceberg' }
LGitRepository >> resetHardTo: target checkoutOptions: options [

	^ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
	 self
		tFFIresetTo: target
		resetType: LGitResetTypeEnum git_reset_hard
		checkoutOptions: options ]
	ifFalse: [ 
	 self
		resetTo: target
		resetType: LGitResetTypeEnum git_reset_hard
		checkoutOptions: options ]
]

{ #category : #'*GToolkit-Iceberg' }
LGitRepository >> tFFIresetTo: target resetType: aResetType checkoutOptions: checkout_opts [

	"^ self
		call: #(LGitReturnCodeEnum git_reset(self, LGitObject target, LGitResetTypeEnum aResetType, LGitCheckoutOptions *checkout_opts))
		options: #()"

	| function |

	function := TFExternalFunction
		name: 'git_reset'
		moduleName: self ffiLibraryName uniqueInstance unixModuleName
		definition: (TFFunctionDefinition
			parameterTypes: { TFBasicType pointer. TFBasicType pointer. TFBasicType uint32. TFBasicType pointer }
			returnType: TFBasicType sint).
	^TFSameThreadRunner new invokeFunction: function withArguments: 
		{ self ifNil: [ ExternalAddress null ].
		target ifNil: [ ExternalAddress null ].
		aResetType value.
		checkout_opts ifNil: [ ExternalAddress null ]. }	
]
