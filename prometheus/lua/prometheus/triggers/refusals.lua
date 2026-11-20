-- Things you can't do (yet): wait timers, locked hatches, not enough of something.
-- Trigger functions for worlds/plugins/prometheus/refusals.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- ^Wait (\d+) (seconds?|minutes?)\.$
function Refusals_WaitSecondsMinutes(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- No repair drones available.
function Refusals_NoRepairDronesAvailable(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Only owners can do this.
function Refusals_OnlyOwnersCanDoThis(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You can't * while *.
function Refusals_YouCanWhile(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You must wait another * while the * generator recharges.
function Refusals_YouMustWaitAnotherWhileThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Repair the * first.
function Refusals_RepairTheFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The ship is already in the process of harvesting *.
function Refusals_TheShipIsAlreadyInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot teleport * a ship with active shields.
function Refusals_YouCannotTeleportAShipWith(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot salvage while the ship is in motion.
function Refusals_YouCannotSalvageWhileTheShip(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The ship is currently unable to move.
function Refusals_TheShipIsCurrentlyUnableTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You should stop the ship before attempting this.
function Refusals_YouShouldStopTheShipBefore(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Unlock the beam first.
function Refusals_UnlockTheBeamFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The starship's NAVI drive is already engaged.
function Refusals_TheStarshipNaviDriveIsAlready(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Please do not attempt to salvage while your ship is in the midst of probing a derelict starship.
function Refusals_PleaseDoNotAttemptToSalvage(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Wait for the acceleration to hyperspace first.
function Refusals_WaitForTheAccelerationToHyperspace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Please deactivate * first.
function Refusals_PleaseDeactivateFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The power controls of this ship are locked due to it being under construction.
function Refusals_ThePowerControlsOfThisShip(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The weapons are not powered up.
function Refusals_TheWeaponsAreNotPoweredUp(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot deploy probes while the starship is moving.
function Refusals_YouCannotDeployProbesWhileThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot salvage while landing.
function Refusals_YouCannotSalvageWhileLanding(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- No shipwrecks found. Cannot continue grabbing process.
function Refusals_NoShipwrecksFoundCannotContinueGrabbing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Hyperspace drive could not be activated due to the vessle being in motion.
function Refusals_HyperspaceDriveCouldNotBeActivated(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The sublight drive is still recharging: * remaining.
function Refusals_TheSublightDriveIsStillRecharging(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- That target is no longer here.
function Refusals_ThatTargetIsNoLongerHere(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The ship is already salvaging.
function Refusals_TheShipIsAlreadySalvaging(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The * is already firing.
function Refusals_TheIsAlreadyFiring(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- >> Command Aborted <<
function Refusals_CommandAborted(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
  Note("Aborted.")
end

-- Buying less than one? Nice try!
function Refusals_BuyingLessThanOneNiceTry(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Invalid*
function Refusals_Invalid(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Oops, wrong amount!
function Refusals_OopsWrongAmount(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * tr*to enter *, but * turned away by the locked hatch.
function Refusals_TrToEnterButTurnedAway(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/CantGo"..math.random(1, 5)..".ogg")
end

-- You hear somebody trying to enter the ship.
function Refusals_YouHearSomebodyTryingToEnter(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/CantGo"..math.random(1, 5)..".ogg")
end

-- A weapon is already being repaired.
function Refusals_AWeaponIsAlreadyBeingRepaired(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You can't teleport for *.
function Refusals_YouCanTeleportFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * to autopilot first.
function Refusals_ToAutopilotFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * to manual pilot first.
function Refusals_ToManualPilotFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Hyperspace jumps cannot be aborted.
function Refusals_HyperspaceJumpsCannotBeAborted(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The * is already in that sector.
function Refusals_TheIsAlreadyInThatSector(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The * is not moving.
function Refusals_TheIsNotMoving(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The * is already moving.
function Refusals_TheIsAlreadyMoving(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You're already there.
function Refusals_YouReAlreadyThere(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Hyperspace jump not possible while shielded.
function Refusals_HyperspaceJumpNotPossibleWhileShielded(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The launchers do not need reloading.
function Refusals_TheLaunchersDoNotNeedReloading(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- There are still * left in the banks.
function Refusals_ThereAreStillLeftInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Invalid coordinates. Range: * to *
function Refusals_InvalidCoordinatesRangeTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The starship is already on * alert.
function Refusals_TheStarshipIsAlreadyOnAlert(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Those coordinates are too far away to establish a lock.
function Refusals_ThoseCoordinatesAreTooFarAway(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Those controls are already in use.
function Refusals_ThoseControlsAreAlreadyInUse(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Either the launchers do not need reloading, or the ship lacks the required ammunition.
function Refusals_EitherTheLaunchersDoNotNeed(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Grabbing is already in progress.
function Refusals_GrabbingIsAlreadyInProgress(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot grab any more.
function Refusals_YouCannotGrabAnyMore(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Excavation impossible due to damaged equipment.
function Refusals_ExcavationImpossibleDueToDamagedEquipment(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- There are no destinations to which you can teleport at present.
function Refusals_ThereAreNoDestinationsToWhich(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You can't go that way.
function Refusals_YouCanGoThatWay(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/CantGo"..math.random(1, 5)..".ogg")
end

-- *bump*into the locked door leading *.
function Refusals_BumpIntoTheLockedDoorLeading(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/CantGo"..math.random(1, 5)..".ogg")
end

-- The * launchers are cooling down.
function Refusals_TheLaunchersAreCoolingDown(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * are already being fired.
function Refusals_AreAlreadyBeingFired(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The LRL is recharging: * remaining.
function Refusals_TheLrlIsRechargingRemaining(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- I see no "*" here.
function Refusals_SeeNoHere(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- There are no salvage lines available.
function Refusals_ThereAreNoSalvageLinesAvailable(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Things can only be transferred at a landing pad or when docked to another ship via the docking ring.
function Refusals_ThingsCanOnlyBeTransferredAt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You'll need to land at a properly equipped landing pad to transfer.
function Refusals_YouLlNeedToLandAt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Drive could not be activated due to the vessel being in motion.
function Refusals_DriveCouldNotBeActivatedDue(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Please drop your shields first.
function Refusals_PleaseDropYourShieldsFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You can not scoop while the vehicle is moving.
function Refusals_YouCanNotScoopWhileThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You can not move while attempting to scoop.
function Refusals_YouCanNotMoveWhileAttempting(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- There is not a star in the sector.
function Refusals_ThereIsNotAStarIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * should not be moving.
function Refusals_ShouldNotBeMoving(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot use that in hyperspace.
function Refusals_YouCannotUseThatInHyperspace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Finish your hyper jump first.
function Refusals_FinishYourHyperJumpFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Hyperspace drive could not be activated due to the vessel being in motion.
function Refusals_HyperspaceDriveCouldNotBeActivated2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You're no longer in that sector.
function Refusals_YouReNoLongerInThat(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You are having a hard time using the controls do to your uncoordinated state.
function Refusals_YouAreHavingAHardTime(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- ^([^\[].*) (remove|removes|unstrap|unstraps) (.*?)\.$
-- (Lines starting with "[" are channel messages; they're left to the channel trigger.)
function Refusals_RemoveRemovesUnstrapUnstraps(name, line, wildcards)
  if (string.match(wildcards[3], "your electronic gadgets first") or string.match(wildcards[3], "before")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
  elseif (string.match(wildcards[3], "from")) then
    -- Do nothing as this should be ignored.
  else
    CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemUnwear.ogg")
  end -- If.
end

-- The * banks are already full.
function Refusals_TheBanksAreAlreadyFull(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Due to the amount of energy drawn by the cloaking generator, you can not fire weapons while cloaked.
function Refusals_DueToTheAmountOfEnergy(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You already have that!
function Refusals_YouAlreadyHaveThat(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The equipment is non-functional when damaged. Please repair it fully before proceeding.
function Refusals_TheEquipmentIsNonFunctionalWhen(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- There is nothing to be transfered.
function Refusals_ThereIsNothingToBeTransfered(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- All drones are busy repairing.
function Refusals_AllDronesAreBusyRepairing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You can't lock on this ship!
function Refusals_YouCanLockOnThisShip(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You are having a hard time using the controls due to your uncoordinated state.
function Refusals_YouAreHavingAHardTime2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end
