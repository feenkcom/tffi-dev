Extension { #name : #LGitDiffFindOptions }

{ #category : #'*GToolkit-Iceberg' }
LGitDiffFindOptions >> diff_find_init_options: opts version: version [
	^ self
		callUnchecked: #(LGitReturnCodeEnum git_diff_find_init_options(void * self, LGitOptionsVersionsEnum version))
		options: #(  )
]
