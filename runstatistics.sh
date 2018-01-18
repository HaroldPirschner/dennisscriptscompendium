#!/bin/bash

nodeAmount=0
keyNodeAmount="node_"
gameStates=0
keyGameStates="runtime.clear("
# entryPoints=0
# keyEntryPoints="generated.node_" 
# -> entry states cannot be acurately discriminated from the data set - at least by this
exitNodes=0
keyExitNodes="callback("
hierarchyCalls=0
keyHierarchyCalls="function(exitLabel)"
inventoryAdds=0
keyInventoryAdds="runtime.addToInventory"
inventoryRemoves=0
keyInventoryRemoves="runtime.removeFromInventory"
inventoryChecks=0
keyInventoryChecks="runtime.checkInventory"
branchDefault=0
keyBranchDefault="runtime.setDefaultBranch"
branchOption=0
keyBranchOption="runtime.addOptionBranch"
branchCountdown=0
keyBranchCountdown="runtime.setCountdownBranch"
branchMatchCircle=0
keyBranchMatchCircle="runtime.addMatchCircularRegionBranch"
branchMatchRectangle=0
keyBranchMatchRectangle="runtime.addMatchRectangularRegionBranch"
branchTextCheck=0
keyBranchTextCheck="runtime.addMatchTextualInputBranch"
linesOfCode=0

if [ "$1x" == "x" ] 
then
	echo "Execution aborted!"
	echo "Please give me a file to be parsed for input!"
	exit 1
fi
if [[ "${1}" == *generated.js ]] 
then
	nodeAmount=`grep ${keyNodeAmount} "${1}" -a | grep generated.${keyNodeAmount} -v | wc -l`
	# nodeAmount needs to be filtered to include only those instances where "node_" is not part of a "generated.node_" call
	gameStates=`grep ${keyGameStates} "${1}" -a | wc -l`
	exitNodes=`grep ${keyExitNodes} "${1}" -a | wc -l`
	hierarchyCalls=`grep ${keyHierarchyCalls} "${1}" -a | wc -l`
	inventoryAdds=`grep ${keyInventoryAdds} "${1}" -a | wc -l`
	inventoryRemoves=`grep ${keyInventoryRemoves} "${1}" -a | wc -l`
	inventoryChecks=`grep ${keyInventoryChecks} "${1}" -a | wc -l`
	branchDefault=`grep ${keyBranchDefault} "${1}" -a | wc -l`
	branchOption=`grep ${keyBranchOption} "${1}" -a | wc -l`
	branchCountdown=`grep ${keyBranchCountdown} "${1}" -a | wc -l`
	branchMatchCircle=`grep ${keyBranchMatchCircle} "${1}" -a | wc -l`
	branchMatchRectangle=`grep ${keyBranchMatchRectangle} "${1}" -a | wc -l`
	branchTextCheck=`grep ${keyBranchTextCheck} "${1}" -a | wc -l`
	linesOfCode=`wc -l < "${1}"`
	echo "\"${1}\",$nodeAmount,$exitNodes,$gameStates,$hierarchyCalls,$inventoryAdds,$inventoryRemoves,$inventoryChecks,$branchDefault,$branchOption,$branchCountdown,$branchMatchCircle,$branchMatchRectangle,$branchTextCheck,$linesOfCode"
else
	echo "Execution aborted!"
	echo "Please know that this only works for the generated.js files in Cinco AdventureGames."
	exit 1
fi

