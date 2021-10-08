Class {
	#name : #EzEscapeTest,
	#superclass : #TestCase,
	#category : #'PetitASP-Tests-ASP'
}

{ #category : #tests }
EzEscapeTest >> testEscaping [ 
	self assert: #< ezEscape equals: 'ezcsp_escape_003C'
]

{ #category : #tests }
EzEscapeTest >> testEscapingADD [
	self assert: #+ ezEscape equals: 'ezcsp_escape_002B'
]

{ #category : #tests }
EzEscapeTest >> testEscapingEQ [
	self assert: #=== ezEscape equals: 'ezcsp_escape_003D003D003D'
]

{ #category : #tests }
EzEscapeTest >> testEscapingGEQ [
	self assert: #>= ezEscape equals: 'ezcsp_escape_003E003D'
]

{ #category : #tests }
EzEscapeTest >> testParseRequired [
	| tree |
	tree := CspRequiredParser parse: 'ezcsp_required(ezcsp_appl(ezcsp_escape_003C,x,10))'.
	self assert: tree functor equals: #<

]
