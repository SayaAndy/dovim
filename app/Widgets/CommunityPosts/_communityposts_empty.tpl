<div class="placeholder">
    {autoescape="off"}{$c->svg('Newspaper-Fold--Streamline-Freehand')}{/autoescape}
    {if="$me"}
        <h4>{$c->__('communityposts.empty_me_text')}</h4>
        <br />
        <a class="button" href="{$c->route('publish')}">
            {autoescape="off"}{$c->svg('Send-Email-Pop-Up--Streamline-Freehand')}{/autoescape}
            {$c->__('communityposts.empty_me_button')}
        </a>
    {else}
        <h4>{$c->__('post.empty')}</h4>
    {/if}
</div>
