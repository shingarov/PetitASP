Class {
	#name : #CspRequiredParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'term',
		'application',
		'leaf',
		'args',
		'id',
		'number'
	],
	#category : #PetitASP
}

{ #category : #accessing }
CspRequiredParser >> application [
	^ (#word asParser, (#word asParser / $_ asParser) star) flatten,
		$( asParser,
		args,
		$) asParser
	==> [ :x | EzCspExpression functor: x first args: x third ]
]

{ #category : #accessing }
CspRequiredParser >> args [
	^(term, ($, asParser, term) star) optional
	==> [ :x | {x first}, (x second collect: #second) ]
]

{ #category : #accessing }
CspRequiredParser >> id [
	^(#letter asParser, #word asParser star) flatten
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
	^ 'required(' asParser, application, ')' asParser
	==> [ :x | x second ]
]

{ #category : #accessing }
CspRequiredParser >> term [
	^ application / leaf
]
