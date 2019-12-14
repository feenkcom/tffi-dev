Extension { #name : #LGitRemote }

{ #category : #'*GToolkit-Iceberg' }
LGitRemote >> lookup [
	self withReturnHandlerDo: [
		(self
			remote_lookup: self
			repo: self repository
			name: self remoteName) isOk ifFalse: 
				[ LGitObjectNotFound signalWith: self ].
		self url: self remote_url ].
	self flag: #todo. "shouldn't be autoreleased?"
]
