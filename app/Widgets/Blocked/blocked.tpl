<div class="tabelem" title="{$c->__('blocked.title')}" data-mobileicon="block" id="blocked_widget">
    <ul class="list thick">
        <li>
            <span class="primary icon gray">
                {autoescape="off"}{$c->svg('Keyboard-Asterisk-1--Streamline-Freehand')}{/autoescape}
            </span>
            <div>
                <p class="line">{$c->__('blocked.info')}</p>
                <p>{$c->__('blocked.info2')}</p>
            </div>
        </li>
    </ul>
    <ul class="list card thin flex shadow" id="blocked_widget_list"></ul>
    <div class="placeholder">
        <i class="material-symbols">block</i>
        <h4>{$c->__('blocked.placeholder')}</h4>
    </div>
</div>
