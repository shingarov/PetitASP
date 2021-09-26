Extension { #name : #GTPlayground }

{ #category : #'*PetitASP-Pharo' }
GTPlayground class >> aspActionsFor: aPlayground [
	<playgroundContextMenu>

	^ {GLMGenericAction new
				title: 'ASP-solve';
				action: [ :t :entity |
					t highlightSolveAndDo: [ :result | t selection: result ] ]; 
				shortcut: $j;
				yourself}
]
