Extension { #name : #LGitRepository }

{ #category : #'*GToolkit-Iceberg' }
LGitRepository >> clone: out url: url local_path: local_path options: options [
	
	^ self
		callUnchecked:
			#(LGitReturnCodeEnum git_clone (void * out, String url, String local_path, void * options))
		options: #(optCoerceNilToNull)
]
