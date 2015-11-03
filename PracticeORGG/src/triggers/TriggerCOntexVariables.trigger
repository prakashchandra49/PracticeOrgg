trigger TriggerCOntexVariables on Account (after Update) {
            system.debug('111111111111111111  trigger.new'+trigger.new);
            system.debug('22222222222222  trigger.old'+trigger.old);
            system.debug('3333333333333333  trigger.newMap'+trigger.newMap);
            system.debug('4444444444444444  trigger.oldMap'+trigger.oldMap);
}