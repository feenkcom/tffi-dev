Extension { #name : #IceLibgitRepository }

{ #category : #'*GToolkit-Iceberg' }
IceLibgitRepository >> gtActionCommitFor: anAction [
	<gtAction>
	|dropdown|
	self isMissing ifTrue: [ ^ anAction ].
	dropdown := anAction dropdown.
	^ dropdown
		icon: nil;
		label: 'Commit...';
		content: [ :b | 
			| editor |
			editor := BrEditor new look: BrGlamorousCodeEditorLook.
			BlElement new
				constraintsDo: [:c | c horizontal exact: 400. c vertical fitContent];
				layout: BlLinearLayout vertical;
				padding: (BlInsets all: 10);
				addChild: editor;
				addChild: (BrButton new look: BrGlamorousButtonWithIconLook; icon: BrGlamorousIcons accept asElement; label: 'Commit'; action: [
				self executeCommit:  (editor editor text asString).
				"dropdown close."
				"b phlow spawnObject: (GtIcebergCommit on: self)" " ((XMLDOMParser parse: self contents) xpath: editor editor text asString)" ])] 
]
