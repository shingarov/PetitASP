Class {
	#name : #ASPIntegrationTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'PetitASP-Tests'
}

{ #category : #tests }
ASPIntegrationTest >> testEX1 [
	| answers e acd |
	answers := EzSMT solveProgram: 'cspdomain(fd). cspvar(x).
		a :- c, not b.
		b :- d, not a.
		c :- d, not b.
		c :- d, not a.
		d :- c, not a.
		d :- not e, not b.
		e :- a, b.
		e :- not a, not b.
		required(ezcsp__geq(x, 10)) :- e.
		required(ezcsp__leq(x, 9)) :- not e.'.
	self assert: answers size equals: 2.
	e := answers detect: [ :ans | ans trueAtoms size = 1 ].
	self assert: e trueAtoms equals: #('e').
	self assert: (e constraintAssignments at: 'x') >= 10.
	acd := answers detect: [ :ans | ans ~= e ].
	self assert: (acd constraintAssignments at: 'x') <= 9.
]

{ #category : #tests }
ASPIntegrationTest >> testRequired1 [
	| answers |
	answers := EzSMT solveProgram: 'cspdomain(fd). cspvar(x).
		required(ezcsp__geq(x, 10)).'.
	self assert: answers size equals: 1.
	self assert: (answers first constraintAssignments at: 'x') >= 10

]
