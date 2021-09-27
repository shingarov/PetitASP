Class {
	#name : #EzSMT,
	#superclass : #Object,
	#instVars : [
		'ptr'
	],
	#category : #PetitASP
}

{ #category : #clausification }
EzSMT class >> clausify: anAspProgramString [
	| ez cnf errorString |
	ez := LibEzSMT uniqueInstance ezsmt_mk.
	cnf := LibEzSMT uniqueInstance ezsmt_clausify: ez _: anAspProgramString.
	cnf isNil ifFalse: [ ^cnf ].
	errorString := LibEzSMT uniqueInstance ezsmt_get_error: ez.
	LibEzSMT uniqueInstance ezsmt_del: ez.
	GringoSyntaxError signal: errorString
]

{ #category : #solving }
EzSMT class >> getAllModelsFrom: solver [
	| model answerSet negations |
	solver check ifFalse: [^OrderedCollection new].
	model := solver getModel.
	answerSet := AnswerSet from: model.
	negations := (answerSet trueAtoms  collect: [ :anAtom | (Bool var: anAtom) not ]),
	             (answerSet falseAtoms collect: [ :anAtom |  Bool var: anAtom      ]).
	solver assert: (Bool or: negations).
	^(self getAllModelsFrom: solver) add: answerSet; yourself
]

{ #category : #solving }
EzSMT class >> solveProgram: anAspProgramString [ 
	| cnf dimacs |
	cnf := self clausify: anAspProgramString.
	dimacs := DIMACS parseText: cnf.
	^ self getAllModelsFrom: dimacs solver.

]
