{loop="$list"}<li class="block" id="blocked-{$value->id|cleanupId}">
    <span class="control icon active" onclick="MovimUtils.reload('{$c->route('contact', $value->id)}');">
        {autoescape="off"}{$c->svg('Composition-Man--Streamline-Freehand')}{/autoescape}
    </span>
    <span class="control icon active divided" onclick="Blocked_ajaxUnblock('{$value->id|echapJS}')">
        <i class="material-symbols">close</i>
    </span>
    <div>
        <p class="line">
            {$value->id}
        </p>
    </div>
</li>{/loop}
