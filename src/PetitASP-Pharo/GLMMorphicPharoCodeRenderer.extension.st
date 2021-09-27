Extension { #name : #GLMMorphicPharoCodeRenderer }

{ #category : #'*PetitASP-Pharo' }
GLMMorphicPharoCodeRenderer >> actOnSolveASP: ann [
	UIManager default defer: [ 
		textMorph textArea handleEdit: [
			textMorph textArea editor highlightAspAndDo: ann action .
			textMorph shoutStyler style: textMorph text. ] ]
]

{ #category : #'*PetitASP-Pharo' }
GLMMorphicPharoCodeRenderer >> registerEventsForPresentation: aPresentation [
	super registerEventsForPresentation: aPresentation.
	aPresentation when: GLMSelectCurrentLine send: #selectLine to: self.
	aPresentation when: GLMEvaluateSelection send: #actOnEvaluateSelection: to: self.
	aPresentation when: GLMHighlightAndEvaluate send: #actOnHighlightAndEvaluate: to: self.
	aPresentation when: GLMCompileText send: #actOnCompileText: to: self.
	aPresentation when: GLMDebugSelection send: #debugHighlightedText to: self.
	aPresentation when: GLMProfileSelection send: #profileHighlightedText to: self.
	aPresentation when: GLMPrintSelection send: #evaluateAndPopPrintHighlight to: self.
	aPresentation when: GLMFormatCode send: #formatSourceCode to: self.
	
	aPresentation when: GLMSolveASP send: #actOnSolveASP: to: self.
]
