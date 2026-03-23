{if="$users->isNotEmpty()"}
    {autoescape="off"}
        {$c->prepareUsers($users)}
    {/autoescape}
{else}
    <div class="placeholder">
        {autoescape="off"}{$c->svg('Search-Magnifier--Streamline-Freehand')}{/autoescape}
        <h4>{$c->__('input.open_me_using')} <span class="chip outline">Ctrl</span> + <span class="chip outline">M</span></h4>
    </div>
{/if}
