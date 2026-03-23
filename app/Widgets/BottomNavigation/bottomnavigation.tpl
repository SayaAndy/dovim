<ul id="bottomnavigation" class="navigation active">
    <li onclick="{if="$page == 'chat'"}Rooms.toggleScroll(){else}MovimUtils.reload('{$c->route('chat')}'){/if}"
        {if="$page == 'chat' || $page == 'space'"}class="active"{/if}
        title="{$c->__('page.chats')}"
    >
        <span class="primary icon bubble" id="bottomchatcounter">
            <i class="material-symbols">{if="$page == 'space'"}speaker_notes{elseif="array_key_exists('rooms', $_GET)"}forum{else}chat_bubble{/if}</i>
        </span>
    </li>
    {if="$c->me->hasPubsub()"}
        <li {if="$page == 'news'"}class="active"{/if}
            onclick="MovimUtils.reload('{$c->route('news')}')"
            title="{$c->__('page.news')}"
        >
            <span class="primary icon">
                {autoescape="off"}{$c->svg('Newspaper-Fold--Streamline-Freehand')}{/autoescape}
                <span data-key="news" class="counter"></span>
            </span>
        </li>
        <li {if="$page == 'explore' || $page == 'community'"}class="active"{/if}
            onclick="MovimUtils.reload('{$c->route('explore')}')"
            title="{$c->__('page.explore')}"
        >
            <span class="primary icon">{autoescape="off"}{$c->svg('View-Binocular--Streamline-Freehand')}{/autoescape}</span>
        </li>
    {/if}
    <li onclick="Notifications_ajaxRequest()"
        title="{$c->__('notifs.title')}"
    >
        <span class="primary icon">
            {autoescape="off"}{$c->svg('Alert-Alarm-Bell--Streamline-Freehand')}{/autoescape}
            <span class="counter notifications"></span>
        </span>
    </li>

    <li id="bottomnavigation_me">
        <span
            onclick="Presence_ajaxHttpMenu()"
            class="primary icon bubble
        ">
            <img src="{$me->getPicture(\Movim\ImageSize::M)}">
        </span>
    </li>
</ul>
