Class {
	#name : #EzSMT,
	#superclass : #Object,
	#category : #PetitASP
}

{ #category : #clausification }
EzSMT >> clausify: anAspProgramString [
	| ez cnf errorString |
	ez := LibEzSMT uniqueInstance ezsmt_mk.
	cnf := LibEzSMT uniqueInstance ezsmt_clausify: ez _: anAspProgramString.
	cnf isNil ifFalse: [ ^cnf ].
	errorString := LibEzSMT uniqueInstance ezsmt_get_error: ez.
	LibEzSMT uniqueInstance ezsmt_del: ez.
	GringoSyntaxError signal: errorString
]

{ #category : #solving }
EzSMT >> getAllModelsFrom: solver [
	| one answerSet negations |
	one := self getOneModelFrom: solver.
	one isEmpty ifTrue: [^one].
	answerSet := one first.
	negations := (answerSet trueAtoms  collect: [ :anAtom | (Bool var: anAtom) not ]),
	             (answerSet falseAtoms collect: [ :anAtom |  Bool var: anAtom      ]).
	solver assert: (Bool or: negations).
	^(self getAllModelsFrom: solver) add: answerSet; yourself
]

{ #category : #solving }
EzSMT >> getOneModelFrom: solver [
	| model answerSet |
	solver check ifFalse: [^OrderedCollection new].
	model := solver getModel.
	answerSet := AnswerSet from: model.
	^OrderedCollection with: answerSet
]

{ #category : #solving }
EzSMT >> solveProgram: anAspProgramString [ 
	| cnf dimacs |
	cnf := self clausify: anAspProgramString.
	dimacs := DIMACS parseText: cnf.
	^ self getAllModelsFrom: dimacs solver.

]

{ #category : #solving }
EzSMT >> solveProgramOnce: anAspProgramString [ 
	| cnf dimacs |
	cnf := self clausify: anAspProgramString.
	dimacs := DIMACS parseText: cnf.
	^ self getOneModelFrom: dimacs solver

]
