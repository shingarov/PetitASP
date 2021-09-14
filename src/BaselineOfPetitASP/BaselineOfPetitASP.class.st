Class {
	#name : #BaselineOfPetitASP,
	#superclass : #BaselineOf,
	#category : #BaselineOfPetitASP
}

{ #category : #baselines }
BaselineOfPetitASP >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			spec baseline: 'PetitParser' with: [
				spec loads: 'Core'. 
				spec loads: 'Analyzer'. 
				"
				HACK: We have to use forked PetitParser with XInclude processing
				support forward-ported. This is not used by ArchC, but it *IS* 
				used by ULD and we intend to use ULD.
				There are better ways to deal with this but no time now.
				"
				"spec repository: 'github://moosetechnology/PetitParser'"
				spec repository: 'github://shingarov/PetitParser:ULD'
			].
			
			spec baseline: 'MachineArithmetic' with: [
				spec repository: 'github://shingarov/MachineArithmetic:pure-z3'
			].

			spec
				package: #'PetitASP';
				package: #'PetitASP-Tests'.
			]
]
