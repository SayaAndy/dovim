<div class="placeholder">
    {$c->svgIcon("Newspaper-Fold--Streamline-Freehand")}
    {if="$me"}
        <h4>{$c->__('communityposts.empty_me_text')}</h4>
        <br />
        <a class="button" href="{$c->route('publish')}">
            {$c->svgIcon("Send-Email-Pop-Up--Streamline-Freehand")}
            {$c->__('communityposts.empty_me_button')}
        </a>
    {else}
        <h4>{$c->__('post.empty')}</h4>
    {/if}
</div>
