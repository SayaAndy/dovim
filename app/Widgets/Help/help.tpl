<div class="tabelem" title="{$c->__('page.help')}" id="help_widget">
    <ul class="list middle">
        <li class="subheader">
            <div>
                <p>{$c->__('faq.title')}</p>
            </div>
        </li>
        <li class="block">
            <span class="primary icon gray">
                {autoescape="off"}{$c->svg('Podcast-Microphone-International-1--Streamline-Freehand')}{/autoescape}
            </span>
            <div>
                <p>{$c->__('faq.permission_title')}</p>
                <p class="all">{$c->__('faq.permission_text')}</p>
            </div>
        </li>
        <li class="block">
            <span class="primary icon gray">
                {autoescape="off"}{$c->svg('Worldwide-Web-Users--Streamline-Freehand')}{/autoescape}
            </span>
            <div>
                <p>{$c->__('faq.permission_community_title')}</p>
                <p class="all">{$c->__('faq.permission_community_text')}</p>
            </div>
        </li>
        <li class="block">
            <span class="primary icon gray">
                {autoescape="off"}{$c->svg('Conversation-Question-Warning-3--Streamline-Freehand')}{/autoescape}
            </span>
            <div>
                <p>{$c->__('faq.chatrooms_title')}</p>
                <p class="all">
                    <a href="https://search.jabber.network" target="_blank">search.jabber.network</a>
                </p>
            </div>
        </li>
        <li class="block">
            <span class="primary icon gray">
                {autoescape="off"}{$c->svg('Search-Magnifier--Streamline-Freehand')}{/autoescape}
            </span>
            <div>
                <p>{$c->__('faq.find_contacts_title')}</p>
                <p class="all">{$c->__('faq.find_contacts_text')}</p>
            </div>
        </li>
    </ul>
    <br />
    <hr />
    <ul class="list divided middle">
        <li class="subheader">
            <div>
                <p>{$c->__('page.help')}</p>
            </div>
        </li>
        <li class="block">
            <span class="primary icon gray">
                {autoescape="off"}{$c->svg('Messages-Bubble-Square-Text--Streamline-Freehand')}{/autoescape}
            </span>
            <div>
                <p>{$c->__('chatroom.question')}</p>
                <p class="all">
                    <a href="#" onclick="Help_ajaxAddChatroom()">
                        {$c->__('chatroom.button')} movim@conference.movim.eu
                    </a>
                </p>
            </div>
        </li>
    </ul>
    <br />
    <hr />
    <ul class="list thick block hide" id="pwa">
        <li class="subheader">
            <div>
                <p>{$c->__('apps.title')}</p>
            </div>
        </li>
        <li class="block active">
            <span class="primary icon gray">
                {autoescape="off"}{$c->svg('Drawer-Download--Streamline-Freehand', 'on_desktop')}{/autoescape}
                {autoescape="off"}{$c->svg('Drawer-Download--Streamline-Freehand', 'on_mobile')}{/autoescape}
            </span>
            <span class="control icon gray">
                <i class="material-symbols">chevron_right</i>
            </span>
            <div>
                <p class="line">{$c->__('apps.install')}<p>
                <p class="all">
                    {$c->__('apps.install_text')}
                </p>
            </div>
        </li>
    </ul>
    <ul class="list">
        <li class="subheader">
            <div>
                <p>{$c->__('apps.recommend')}</p>
            </div>
        </li>
        <li class="block">
            <span class="primary icon green">
                {autoescape="off"}{$c->svg('Android-Logo--Streamline-Freehand')}{/autoescape}
            </span>
            <div>
                <p class="line">
                    Conversations
                    <a class="button flat" href="https://play.google.com/store/apps/details?id=eu.siacs.conversations" target="_blank">
                        {autoescape="off"}{$c->svg('Android-Logo--Streamline-Freehand')}{/autoescape} Play Store
                    </a>
                    <a class="button flat" href="https://f-droid.org/packages/eu.siacs.conversations/" target="_blank">
                        <i class="material-symbols">adb</i> F-Droid
                    </a>
                </p>
            </div>
        </li>
        <li class="block">
            <span class="primary icon purple">
                {autoescape="off"}{$c->svg('Desktop-Monitor--Streamline-Freehand')}{/autoescape}
            </span>
            <div>
                <p class="line">
                    Dino
                    <a class="button flat" href="https://dino.im/" target="_blank">
                        {autoescape="off"}{$c->svg('Share-Forward--Streamline-Freehand')}{/autoescape} Website
                    </a>
                </p>
            </div>
        </li>
        <li class="block">
            <span class="primary icon blue">
                {autoescape="off"}{$c->svg('Desktop-Monitor--Streamline-Freehand')}{/autoescape}
            </span>
            <div>
                <p class="line">
                    Gajim
                    <a class="button flat" href="https://gajim.org/" target="_blank">
                        {autoescape="off"}{$c->svg('Share-Forward--Streamline-Freehand')}{/autoescape} Website
                    </a>
                </p>
            </div>
        </li>
    </ul>
    {if="$info && (!empty($info->adminaddresses) || !empty($info->abuseaddresses) || !empty($info->supportaddresses)  || !empty($info->securityaddresses))"}
        <hr />
        <ul class="list flex">
            <li class="subheader">
                <div>
                    <p>{$c->__('contact.title')}</p>
                </div>
            </li>
            {$addresses = array_unique(array_merge($info->adminaddresses, $info->abuseaddresses, $info->supportaddresses, $info->securityaddresses))}
            {loop="$addresses"}
                <li class="block">
                    {$parsed = parse_url($value)}
                    {if="$parsed['scheme'] == 'xmpp'"}
                        {if="isset($parsed['query']) && $parsed['query'] == 'join'"}
                        <span class="primary icon gray">
                            <i class="material-symbols">mode_comment</i>
                        </span>
                        <div>
                            <p>
                                <a href="{$c->route('chat', [$parsed['path'], 'room'])}">
                                    {$parsed['path']}
                                </a>
                            </p>
                        </div>
                        {else}
                        <span class="primary icon gray">
                            {autoescape="off"}{$c->svg('Messages-Bubble-Square-Text--Streamline-Freehand')}{/autoescape}
                        </span>
                        <div>
                            <p>
                                <a href="{$c->route('chat', $parsed['path'])}">
                                    {$parsed['path']}
                                </a>
                            </p>
                        </div>
                        {/if}
                    {else}
                        <span class="primary icon gray">
                            {autoescape="off"}{$c->svg('Mailbox-Post-1--Streamline-Freehand')}{/autoescape}
                        </span>
                        <div>
                            <p>
                                <a href="{$value}" target="_blank" rel="noopener noreferrer">
                                    {$parsed['path']}
                                </a>
                            </p>
                        </div>
                    {/if}
                </li>
            {/loop}
        </ul>
    {/if}
</div>
