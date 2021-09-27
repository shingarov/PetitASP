Class {
	#name : #ASPTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'PetitASP-Tests'
}

{ #category : #tests }
ASPTest >> test2of4 [
	| answers |
	answers := EzSMT solveProgram: '2 { f(1..4) } 2.'.
	self assert: answers size equals: 6.
	self assert: (answers allSatisfy: [ :ans |
		ans trueAtoms size = 2])
	
]

{ #category : #tests }
ASPTest >> testDisjunction [
	"There is a subtle difference between (Program 4.14 in LPARSE Manual p.35)
	
		a | b :- c.
		c :- not d.  d :- not c.
	
	and
	
		1 { a; b } :- c.
		c :- not d.  d :- not c.
	
	The former will produce 3 stable models, because {a,b,c} is not minimal.
	The latter will produce 4 stable models including {a,b,c}.
	"
	| answers |
	answers := EzSMT solveProgram: '1 { a; b } :- c. c :- not d. d :- not c.'.
	self assert: answers size equals: 4	
]

{ #category : #tests }
ASPTest >> testFoundedChain [
	| answers |
	answers := EzSMT solveProgram: 'a :- b. b :- c. c.'.
	self assert: answers size equals: 1.
	self deny: answers first trueAtoms isEmpty
	
]

{ #category : #tests }
ASPTest >> testNonTight [
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
ASPTest >> testSyntaxError [
	self should: [EzSMT solveProgram: '(].'] raise: GringoSyntaxError 
]

{ #category : #tests }
ASPTest >> testTowerOfHanoi [
	| answers solution moves moves3 firstMove |
	answers := EzSMT solveProgram: self towerOfHanoi.
	self assert: answers size equals: 1.
	solution := answers first.
	moves := solution trueAtoms select: [ :atm | atm beginsWith: 'move(' ].
	self assert: moves size equals: 30. "15*move/2 and 15*move/3"
	moves3 := moves select: [ :m | ($, split: m) size = 3 ].
	self assert: moves3 size equals: 15.
	firstMove := moves3 select: [ :m | ($, split: m) last = '1)' ].
	self assert: firstMove size equals: 1.
	firstMove := firstMove first.
	self assert: firstMove equals: 'move(4,b,1)'.
]

{ #category : #tests }
ASPTest >> testUnfoundedChain [
	| answers |
	answers := EzSMT solveProgram: 'a :- b. b :- c.'.
	self assert: answers size equals: 1.
	self assert: answers first trueAtoms isEmpty 
	
]

{ #category : #tests }
ASPTest >> towerOfHanoi [
	^'
disk(1..4).
peg(a;b;c).
init_on(1..4,a).
goal_on(1..4,c).
moves(15).

1 { move(D,P,T) : disk(D), peg(P) } 1 :- T = 1..M, moves(M).

move(D,T) :- move(D,_,T).
on(D,P,0) :- init_on(D,P).
on(D,P,T) :- move(D,P,T).
on(D,P,T+1) :- on(D,P,T), not move(D,T+1), not moves(T).
blocked(D-1,P,T+1) :- on(D,P,T), not moves(T).
blocked(D-1,P,T) :- blocked(D,P,T), disk(D).

:- move(D,P,T), blocked(D-1,P,T).
:- move(D,T), on(D,P,T-1), blocked(D,P,T).
:- not 1 { on(D,P,T) : peg(P) } 1, disk(D), T=1..M, moves(M).

:- goal_on(D,P), not on(D,P,M), moves(M).'
]
