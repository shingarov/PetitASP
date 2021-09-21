Class {
	#name : #FirstASPTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'PetitASP-Tests'
}

{ #category : #tests }
FirstASPTest >> test2of4 [
	| answers |
	answers := EzSMT solveProgram: '2 { f(1..4) } 2.'.
	self assert: answers size equals: 6.
	self assert: (answers allSatisfy: [ :ans |
		ans trueAtoms size = 2])
	
]

{ #category : #tests }
FirstASPTest >> testEX1 [
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
FirstASPTest >> testFoundedChain [
	| answers |
	answers := EzSMT solveProgram: 'a :- b. b :- c. c.'.
	self assert: answers size equals: 1.
	self deny: answers first trueAtoms isEmpty
	
]

{ #category : #tests }
FirstASPTest >> testNonTight [
	| answers |
	answers := EzSMT solveProgram: '
		a :- c, not b.
		b :- d, not a.
		c :- d, not b.
		c :- d, not a.
		d :- c, not a.
		d :- not e, not b.
		e :- a, b.
		e :- not a, not b.
'.
	self assert: answers size equals: 2.
	self assert: ((answers detect: [ :ans | ans trueAtoms size = 1 ]) trueAtoms) equals: #('e').
]

{ #category : #tests }
FirstASPTest >> testRequired1 [
	| answers |
	answers := EzSMT solveProgram: 'cspdomain(fd). cspvar(x).
		required(ezcsp__geq(x, 10)).'.
	self assert: answers size equals: 1.
	self assert: (answers first constraintAssignments at: 'x') >= 10

]

{ #category : #tests }
FirstASPTest >> testSyntaxError [
	self should: [EzSMT solveProgram: '(].'] raise: GringoSyntaxError 
]

{ #category : #tests }
FirstASPTest >> testUnfoundedChain [
	| answers |
	answers := EzSMT solveProgram: 'a :- b. b :- c.'.
	self assert: answers size equals: 1.
	self assert: answers first trueAtoms isEmpty 
	
]
