Extension { #name : #LGitCheckoutOptions }

{ #category : #'*GToolkit-Iceberg' }
LGitCheckoutOptions >> checkout_init_options: opts version: version [ 
	^ self
		callUnchecked: #(int git_checkout_init_options(LGitCheckoutOptions * self, LGitOptionsVersionsEnum version))
		options: #(  )
]
