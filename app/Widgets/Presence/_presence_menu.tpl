<section>
    <header class="big color {$contact->color}"
        style="background-image: linear-gradient(to bottom, rgba(23,23,23,0.8) 0%, rgba(23,23,23,0.5) 100%), url('{$contact->getBanner(\Movim\ImageSize::XXL)}');"
        >
        <ul class="list thick">
            <li>
                <span class="primary icon bubble active status
                    {if="$presence->value != null"}{$presencetxt[$presence->value]}{/if}
                ">
                    <img src="{$contact->getPicture()}">
                </span>

                <span class="control icon active white divided" onclick="Presence_ajaxAskLogout(); Drawer.clear('menu')"
                    title="{$c->__('status.disconnect')}">
                    {$c->svgIcon("Safety-Exit-Door--Streamline-Freehand")}
                </span>
                <div>
                    <p class="line">{$contact->truename}</p>
                    <p class="line">{$contact->id}</p>
                </div>
            </li>
        </ul>
    </header>

    <ul class="list active">
        <li title="{$c->__('status.visit_blog')}"
            onclick="MovimUtils.reload('{$c->route('contact', $c->me->id)}')"
        >
            <span class="primary icon gray">
                {$c->svgIcon("Taking-Pictures-Man--Streamline-Freehand")}
            </span>
            <span class="control icon gray">
                <i class="material-symbols">chevron_right</i>
            </span>
            <div>
                <p class="line">{$c->__('status.visit_blog')}</p>
            </div>
        </li>
        {if="$c->me->hasPubsub()"}
            <li onclick="MovimUtils.reload('{$c->route('subscriptions')}')"
                title="{$c->__('communityaffiliation.subscriptions')}"
            >
                <span class="primary icon gray">
                    {$c->svgIcon("Book-Library-Shelf-1--Streamline-Freehand")}
                </span>
                <span class="control icon gray">
                    <i class="material-symbols">chevron_right</i>
                </span>
                <div>
                    <p>{$c->__('communityaffiliation.subscriptions')}</p>
                </div>
            </li>
        {/if}

        <hr />

        <li onclick="MovimUtils.reload('{$c->route('configuration')}')"
            title="{$c->__('page.configuration')}">
            <span class="primary icon gray">
                {$c->svgIcon("Controls-Sliders-Vertical--Streamline-Freehand")}
            </span>
            <span class="control icon gray">
                <i class="material-symbols">chevron_right</i>
            </span>
            <div>
                <p class="line">{$c->__('page.configuration')}</p>
            </div>
        </li>
        {if="$c->me->admin"}
            <li onclick="MovimUtils.reload('{$c->route('admin')}')"
                title="{$c->__('page.administration')}">
                <span class="primary icon gray">
                    {$c->svgIcon("Settings-Cog--Streamline-Freehand")}
                </span>
                <span class="control icon gray">
                    <i class="material-symbols">chevron_right</i>
                </span>
                <div>
                    <p class="line">{$c->__('page.administration')}</p>
                </div>
            </li>
        {/if}

        <li onclick="MovimUtils.reload('{$c->route('help')}')"
            title="{$c->__('page.help')}"
        >
            <span class="primary icon gray">
                {$c->svgIcon("Help-Question-Circle--Streamline-Freehand")}
            </span>
            <span class="control icon gray">
                <i class="material-symbols">chevron_right</i>
            </span>
            <div>
                <p class="line">{$c->__('page.help')}</p>
            </div>
        </li>
    </ul>

    <ul class="list thick">
        <li>
            <div>
                <p class="center">
                    <i class="material-symbols" style="margin-right: 1rem;">cloud_queue</i>
                    Powered by <a target="_blank" href="https://movim.eu">Movim</a></a>
                </p>
            </div>
        </li>
    </ul>
</section>