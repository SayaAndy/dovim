<ul class="list thick">
    <li>
        <span class="primary icon gray">
            {autoescape="off"}{$c->svg('Mobilephone-Action-Notification-Allowed--Streamline-Freehand')}{/autoescape}
        </span>
        <div>
            <button
                name="submit"
                class="button oppose green"
                onclick="Notif.request(); Dialog_ajaxClear()">
                {$c->__('notification.request_button')}
            </button>
            <p>{$c->__('notification.request_info')}</p>
            <p>{$c->__('notification.request_info2')}</p>
        </div>
    </li>
</ul>
