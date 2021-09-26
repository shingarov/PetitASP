Extension { #name : #GLMTextualPresentation }

{ #category : #'*PetitASP-Pharo' }
GLMTextualPresentation >> highlightSolveAndDo: oneArgBlock [ 
	self shouldBeImplemented.
	oneArgBlock value: #ARG.
	(self pane port: #selectedText) value asString.
	self highlightEvaluateAndDo: 1
]
