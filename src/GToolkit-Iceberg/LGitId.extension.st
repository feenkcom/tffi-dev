Extension { #name : #LGitId }

{ #category : #'*GToolkit-Iceberg' }
LGitId >> hexString [
	| string |
	self isExternal
		ifFalse: [ ^ handle hex ].
	string := ByteArray new: 40.
	string pin.
	self oid_fmt: string id: self.
	string unpin.
	^ string asString
]
