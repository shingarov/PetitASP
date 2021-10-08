Class {
	#name : #ASPIntegrationTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'PetitASP-Tests-ASP'
}

{ #category : #tests }
ASPIntegrationTest >> testEX1 [
	| answers e acd x |
	x := 'x' toInt.
	answers := EzSMT new solveProgram: '
		a :- c, not b.
		b :- d, not a.
		c :- d, not b.
		c :- d, not a.
		d :- c, not a.
		d :- not e, not b.
		e :- a, b.
		e :- not a, not b.
		«x>42» :- e.
		«x<0» :- not e.' in: thisContext.
	self assert: answers size equals: 2.
	e := answers detect: [ :ans | ans trueAtoms size = 1 ].
	self assert: e trueAtoms equals: #('e').
	self assert: (e constraintAssignments at: 'x') >= 10.
	acd := answers detect: [ :ans | ans ~= e ].
	self assert: (acd constraintAssignments at: 'x') <= 0.
]

{ #category : #tests }
ASPIntegrationTest >> testRequired1 [
	| answers x |
	x := 'x' toInt.
	answers := EzSMT new solveProgram: 'cspdomain(fd).
		ezcsp_required(ezcsp_appl(ezcsp_escape_003C,x,10)).'.
	self assert: answers size equals: 1.
	self assert: (answers first constraintAssignments at: 'x') < 10

]

{ #category : #tests }
ASPIntegrationTest >> testRequired2 [
	| answers ans x y |
	x := 'x' toInt.
	y := 'y' toInt.
	answers := EzSMT new solveProgram: 'cspdomain(fd).
		ezcsp_required(ezcsp_appl(ezcsp_escape_003C,x,10)).
		ezcsp_required(ezcsp_appl(ezcsp_escape_003C,y,x)).
		'.
	self assert: answers size equals: 1.
	ans := answers first.
	self assert: (ans constraintAssignments at: 'x') < 10.
	self assert: (ans constraintAssignments at: 'y') < (ans constraintAssignments at: 'x')
]
