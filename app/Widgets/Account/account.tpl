<div class="tabelem" title="{$c->__('account.title')}" data-mobileicon="account_circle" id="account_widget">
    <div id="account_presences"></div>
    {if="$c->me->hasOMEMO()"}<div id="account_fingerprints"></div>{/if}
    <div id="account_gateways"></div>
    <ul class="list active">
        <li class="subheader">
            <div>
                <p>{$c->__('account.account_management')}</p>
            </div>
        </li>
        {if="$c->me->hasRegister()"}
            <li onclick="Account_ajaxChangePassword()">
                <span class="primary icon">
                    {autoescape="off"}{$c->svg('Lock-Key-1--Streamline-Freehand')}{/autoescape}
                </span>
                <span class="control icon gray">
                    <i class="material-symbols">chevron_right</i>
                </span>
                <div>
                    <p class="line">{$c->__('account.password_change_title')}</p>
                </div>
            </li>
        {/if}
        <li onclick="Account_ajaxClearAccount()">
            <span class="primary icon orange">
                {autoescape="off"}{$c->svg('Keyboard-Eject-Button--Streamline-Freehand')}{/autoescape}
            </span>
            <span class="control icon gray">
                <i class="material-symbols">chevron_right</i>
            </span>
            <div>
                <p class="line">{$c->__('account.clear')}</p>
            </div>
        </li>
        {if="$c->me->hasRegister()"}
            <li onclick="Account_ajaxRemoveAccount()">
                <span class="primary icon red">
                    {autoescape="off"}{$c->svg('Garbage-Throw--Streamline-Freehand')}{/autoescape}
                </span>
                <span class="control icon gray">
                    <i class="material-symbols">chevron_right</i>
                </span>
                <div>
                    <p class="line">{$c->__('account.delete')}</p>
                </div>
            </li>
        {/if}
    </ul>
</div>
