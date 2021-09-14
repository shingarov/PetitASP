Class {
	#name : #DIMACS,
	#superclass : #Object,
	#instVars : [
		'lines',
		'solver',
		'bools',
		'theory',
		'atomDict',
		'declaredFunctions'
	],
	#category : #PetitASP
}

{ #category : #'as yet unclassified' }
DIMACS class >> boolFromLiteral [
	^[ :literal |
		literal first = $-
			ifTrue: [ (Bool var: literal allButFirst) not ]
			ifFalse: [ Bool var: literal ]]
]

{ #category : #'instance creation' }
DIMACS class >> parseFile: path [ 
	^self parseText: (FileReference / path) readStream contents
]

{ #category : #'as yet unclassified' }
DIMACS class >> parseText: aString [ 
	| lines |
	lines := aString lines.
	^super new 
		headerLine: lines first 
		lines: lines allButFirst 
]

{ #category : #'as yet unclassified' }
DIMACS >> assertCNF [
	lines do: [ :aLine | self assertCNF: aLine ]
]

{ #category : #'as yet unclassified' }
DIMACS >> assertCNF: aLine [
	"aLine is actually a ST Array of strings representing disjunct literals"
	| disjuncts |
	disjuncts := aLine collect: [ :literalString |
		| isNegative atom |
		isNegative := literalString first = $-.
		atom := isNegative ifTrue: [ literalString allButFirst ] ifFalse: [ literalString ].
		atom := declaredFunctions at: atom.
		isNegative ifTrue: [ atom not ] ifFalse: [ atom ]].
	
	self solver assert: (Bool or: disjuncts)
]

{ #category : #'as yet unclassified' }
DIMACS >> declareBool: anAtom [
	declaredFunctions at: anAtom put: (Bool var: anAtom)
]

{ #category : #'as yet unclassified' }
DIMACS >> declareBools [
	declaredFunctions := Dictionary new.
	bools do: [ :aBool | self declareBool: aBool ]
]

{ #category : #'as yet unclassified' }
DIMACS >> declareCspExpression: aBool [
	| tree |
	tree := CspRequiredParser parse: aBool.
	tree isPetitFailure ifTrue: [ ^self ].
	self solver assert: (Bool var: aBool) ==> tree toBool
]

{ #category : #'as yet unclassified' }
DIMACS >> declareCspExpressions [
	bools do: [ :aDimacsBool | self declareCspExpression: aDimacsBool ]
]

{ #category : #'as yet unclassified' }
DIMACS >> declareCspVar: aBool [
	| tree |
	tree := CspVarParser parse: aBool.
	tree isPetitFailure ifTrue: [ ^self ].
	tree second isNil 
		ifTrue: [ self declareInt: tree first ]
		ifFalse: [ self declareInt: tree first lbound: tree second x ubound: tree second y ]
]

{ #category : #'as yet unclassified' }
DIMACS >> declareCspVars [
	bools do: [ :aDimacsBool | self declareCspVar: aDimacsBool ]
]

{ #category : #'as yet unclassified' }
DIMACS >> declareInt: id [
	self maintainCspVars: id.
	^ declaredFunctions at: id put: (self domainConstNamed: id)

]

{ #category : #'as yet unclassified' }
DIMACS >> declareInt: id lbound: l ubound: u [
	| x |
	x := self declareInt: id.
	self solver
		assert: x >= l;
		assert: x <= u
]

{ #category : #'as yet unclassified' }
DIMACS >> defineMacros [
	"Including necessary SMT functions"
	"Those things like,
	(define-fun max ((x Int) (y Int)) Int (ite (< x y) y x))"
	"This doesn't really work.  See Leonardo's explanation at
	https://stackoverflow.com/questions/7740556/equivalent-of-define-fun-in-z3-api
	"
]

{ #category : #'as yet unclassified' }
DIMACS >> domainConstNamed: id [ 
	"TODO: The interesting part. Now we just assume LIA." 
	^Int const: id
]

{ #category : #'as yet unclassified' }
DIMACS >> gatherDimacsBools [
	bools := Set new.
	lines do: [ :line |
		line do: [ :literal |
			| atom |
			atom := literal first = $-
				ifTrue: [ literal allButFirst ] ifFalse: [ literal ].
			bools add: atom ] ]
]

{ #category : #'as yet unclassified' }
DIMACS >> headerLine: hd lines: ll [
	lines := ll collect: [ :l | l substrings allButLast ].
	self gatherDimacsBools.
	self declareBools.
	self assertCNF.
	self maintainAtoms.
	self declareCspVars.
	self declareCspExpressions
]

{ #category : #'as yet unclassified' }
DIMACS >> logic [
	^'QF_LIA'
]

{ #category : #'as yet unclassified' }
DIMACS >> maintainAtoms [
	atomDict := Dictionary new.
	bools do: [ :id | self maintainAtoms: id ]
]

{ #category : #'as yet unclassified' }
DIMACS >> maintainAtoms: id [
	atomDict at: id put: #YETUNKNOWN
]

{ #category : #'as yet unclassified' }
DIMACS >> maintainCspVars: id [
	"PY says: Necessary for the sum global constraint. Keep track of all predicates and their arity." 
	
	"TODO"

]

{ #category : #accessing }
DIMACS >> solver [
	solver isNil ifTrue: [ solver := Z3Solver for: self logic ].
	^ solver
]
