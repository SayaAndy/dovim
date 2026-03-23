{loop="$spaces"}
    <li {if="$value->space_in"}onclick="SpacesMenu.get('{$value->server}', '{$value->node}', '{$c->route('space', [$value->server, $value->node])}')"
        class="{if="$value->pinned"}pinned{/if} {if="$node && $value->node == $node"}enabled{/if}"
        {else}onclick="SpacesMenu_ajaxLockedMenu('{$value->server}', '{$value->node}')"{/if}>
        <span class="primary icon bubble space symbol {if="!$value->space_in"}locked{/if}"
            {if="$value->info"}title="{$value->info->name}"{/if}
            {$unreads = $value->spaceUnreads($c->me)}
            id="{$value->counterId}"
            {if="$unreads > 0"}data-counter="{$unreads}"{/if}
            >
            {if="$value->info"}
                <img src="{$value->info->getPicture(placeholder: $value->info->name)}">
            {else}
                {autoescape="off"}{$c->svg('Loading-Spinning-Star--Streamline-Freehand', 'spin')}{/autoescape}
            {/if}
            <span data-key="space{$value->server}{$value->node}" class="counter notifications"></span>
        </span>

        <span class="control icon gray">
            {autoescape="off"}{$c->svg('Share-Circles--Streamline-Freehand')}{/autoescape}
        </span>
        <div>
            <p class="line">
                {if="$value->info"}
                    {$value->info->name}
                {else}
                    {$c->__('spacesmenu.loading_space_info')}
                {/if}
            </p>
        </div>
    </li>
{/loop}

<li onclick="SpacesMenu_ajaxAdd()">
    <span class="primary icon bubble space_add">
        {autoescape="off"}{$c->svg('Add-Sign-Bold--Streamline-Freehand')}{/autoescape}
    </span>
    <div>
        <p class="line">{$c->__('spacesmenu.create_space_title')}</p>
    </div>
</li>
