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
			| editor button |
			editor := BrEditor new look: BrGlamorousCodeEditorLook.
			button := (BrButton new look: BrGlamorousButtonWithIconLook; icon: BrGlamorousIcons accept asElement; label: 'Commit'; action: [
				self executeCommit:  (editor editor text asString).]).
			button disable.
			editor editor when: BrTextEditorModifiedEvent do: [ :anEvent | ((anEvent text asString) isEmpty) ifTrue: [button disable]; ifFalse: [button enable].  ].
			BlElement new
				constraintsDo: [:c | c horizontal exact: 400. c vertical fitContent];
				layout: BlLinearLayout vertical;
				padding: (BlInsets all: 10);
				addChild: editor;
				addChild: button] 
]
