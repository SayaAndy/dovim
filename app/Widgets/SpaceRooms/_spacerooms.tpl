{loop="$subscription->spaceRooms"}
    <li onclick="Chat.getRoom('{$value->conference}')" id="space{$value->conference|cleanupId}"
        data-jid="{$value->conference}">
        <span class="primary icon gray"
            id="{$value->conference|cleanupId}-rooms-primary">
            {autoescape="off"}
                {$c->prepareRoomCounter($value)}
            {/autoescape}
        </span>

        {if="$edit"}
            <span class="control icon gray active" onclick="SpaceRooms_ajaxAskEdit('{$value->space_server}', '{$value->space_node}', '{$value->conference}')">
                <i class="material-symbols">edit</i>
            </span>
            <span class="control icon gray active" onclick="SpaceRooms_ajaxAskDestroy('{$value->space_server}', '{$value->space_node}', '{$value->conference}')">
                {autoescape="off"}{$c->svg('Garbage-Throw--Streamline-Freehand')}{/autoescape}
            </span>
        {/if}
        <div>
            <p class="line">
                {if="$value->pinned"}
                    <span class="info">
                        <i class="material-symbols fill" title="{$c->__('room.pinned')}">push_pin</i>
                    </span>
                {/if}
                {$value->name}
            </p>
        </div>
    </li>
{/loop}

{if="$subscription->spaceRooms->isEmpty()"}
    <div class="placeholder">
        {autoescape="off"}{$c->svg('Smiley-Crying-Rainbow--Streamline-Freehand', 'fill')}{/autoescape}
        <h1>{$c->__('chats.empty_title')}</h1>
    </div>
{/if}
