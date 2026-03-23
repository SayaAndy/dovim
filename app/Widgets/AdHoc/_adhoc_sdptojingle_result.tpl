<section class="scroll">
    <form>
        <div>
            <ul class="list">
                <li>
                    <span class="primary icon gray">
                        {autoescape="off"}{$c->svg('File-Code--Streamline-Freehand')}{/autoescape}
                    </span>
                    <div>
                        <textarea dir="auto" name="sdp" id="sdp" placeholder="" style="min-height: 60rem;" data-autoheight="true">{$jingle->ownerDocument->saveXML($jingle)}</textarea>
                        <label for="sdp">{$c->__('tools.jingle_title')}</label>
                    </div>
                </li>
            </ul>
        </div>
    </form>
</section>
<footer>
    <button onclick="AdHoc_ajaxSDPToJingle()" class="button flat">
        {$c->__('button.previous')}
    </button>
    <button onclick="Dialog_ajaxClear()" class="button flat">
        {$c->__('button.close')}
    </button>
</footer>
