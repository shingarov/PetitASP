Class {
	#name : #CspRequiredParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'term',
		'leaf',
		'args',
		'id',
		'number',
		'application',
		'escapedFunctor',
		'codepoint'
	],
	#category : #'PetitASP-ASP'
}

{ #category : #accessing }
CspRequiredParser >> application [ 
	^'ezcsp_appl(' asParser,
	escapedFunctor,
	(($, asParser,
	term) star ==> [ :x | x collect: #second ]),
	$) asParser
	==> [ :x | ApplicationTerm functor: x second args: x third ]
]

{ #category : #accessing }
CspRequiredParser >> args [
	^(term, ($, asParser, term) star) optional
	==> [ :x | {x first}, (x second collect: #second) ]
]

{ #category : #accessing }
CspRequiredParser >> codepoint [
	^(#hex asParser,
	#hex asParser,
	#hex asParser,
	#hex asParser) flatten
	==> [ :x | Character value: (Integer readFrom: x base: 16) ]
]

{ #category : #accessing }
CspRequiredParser >> escapedFunctor [
	^'ezcsp_escape_' asParser, codepoint plus
	==> [ :x | Symbol withAll: x second ]
]

{ #category : #accessing }
CspRequiredParser >> id [
	^(#letter asParser, (#word asParser / $_ asParser) star) flatten ==> [ :x | Cosa named: x ]
]

{ #category : #accessing }
CspRequiredParser >> leaf [
	^id/number
]

{ #category : #accessing }
CspRequiredParser >> number [
	^$- asParser optional, (#digit asParser, #digit asParser star) flatten
	==> [ :x |
		| abs |
		abs := x second asInteger.
		x first = $- ifTrue: [ abs negated ] ifFalse: [ abs ] ]

]

{ #category : #accessing }
CspRequiredParser >> start [ 
	^ 'ezcsp_required(' asParser, term, ')' asParser
	==> [ :x | x second ]
]

{ #category : #accessing }
CspRequiredParser >> term [
	^ application / leaf
]
