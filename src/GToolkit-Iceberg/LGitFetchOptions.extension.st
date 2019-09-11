Extension { #name : #LGitFetchOptions }

{ #category : #'*GToolkit-Iceberg' }
LGitFetchOptions >> fetch_init_options: opts version: version [
	^ self
		callUnchecked: #(LGitReturnCodeEnum git_fetch_init_options(void * self, LGitOptionsVersionsEnum version))
		options: #(  )
]
