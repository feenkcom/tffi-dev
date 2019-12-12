Extension { #name : #LGitId }

{ #category : #'*GToolkit-Iceberg' }
LGitId >> hexString [
	| buffer |
	self isExternal
		ifFalse: [ ^ handle hex ].
	buffer := ByteArray new: 40.
	buffer pin.
	self oid_fmt: buffer size: 40 id: self.
	buffer unpin.
	^ buffer asString
]

{ #category : #'*GToolkit-Iceberg' }
LGitId >> oid_fmt: aByteArray size: anInteger id: objectId [
	^self call: #(void git_oid_nfmt(void *aByteArray, int anInteger, LGitId * self)) options: #(  )
]
