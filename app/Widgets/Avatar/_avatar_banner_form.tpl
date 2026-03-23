<section class="scroll">
    <form name="bannerform">
        <img class="avatar" src="{$me->getBanner(\Movim\ImageSize::O) ?? ''}">
        <div class="placeholder">
            <i class="material-symbols">image</i>
            <h1>{$c->__('banner.missing')}</h1>
        </div>
        <input type="hidden" name="photobin"/>
    </form>
    <ul class="list thick divided">
        <li>
            <span class="primary icon bubble color green">
                {autoescape="off"}{$c->svg('Form-Edition-Image-Attach--Streamline-Freehand')}{/autoescape}
            </span>
            <div>
                <p>{$c->__('avatar.file')}</p>
                <p><input type="file" onchange="MovimAvatar.file(this.files, 'bannerform', 1280, 320);"></p>
            </div>
        </li>
    </ul>
</section>
<footer>
    <button onclick="Dialog_ajaxClear()" class="button flat">
        {$c->__('button.close')}
    </button>
    <button
        type="button"
        onclick="
            Avatar_ajaxBannerSubmit(MovimUtils.formToJson('bannerform'));
            this.value = '{$c->__('button.submitting')}';
            this.className='button flat inactive';"
        class="button flat"
        >
        {$c->__('button.submit')}
    </button>
</footer>
