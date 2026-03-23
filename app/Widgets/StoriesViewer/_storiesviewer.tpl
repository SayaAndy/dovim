<ul class="list controls middle">
    <li>
        <span class="primary icon active" onclick="history.back()" title="{$c->__('button.close')}">
            <i class="material-symbols">arrow_back</i>
        </span>
    </li>
</ul>
<article class="story">
    <img class="main" src="{$story->picture->href|protectPicture}">
    <div class="next"><i class="material-symbols">chevron_right</i></div>
    <ul class="head list middle">
        <li>
            {if="$story->contact"}
                <span class="primary icon bubble small">
                    <img src="{$story->contact->getPicture()}">
                </span>
            {/if}
            {if="$story->isMine($c->me)"}
            <span class="control icon active" onclick="StoriesViewer.pause(); StoriesViewer_ajaxDelete('{$story->id}')">
                {autoescape="off"}{$c->svg('Garbage-Throw--Streamline-Freehand', 'fill')}{/autoescape}
            </span>
            {/if}
            <span class="control icon active" onclick="StoriesViewer.pause(); SendTo_ajaxSendContact('{$story->getRef()}')">
                {autoescape="off"}{$c->svg('Share-Circles--Streamline-Freehand')}{/autoescape}
            </span>
            <span class="control icon pause toggleable" onclick="StoriesViewer.start()">
                <i class="material-symbols fill">play_arrow</i>
            </span>
            <span class="control icon play toggleable" onclick="StoriesViewer.pause()">
                <i class="material-symbols fill">pause</i>
            </span>
            <div>
                <p class="line">
                    {if="$story->contact"}
                        <a href="#" onclick="MovimUtils.reload('{$c->route('contact', $story->aid)}')">
                            {$story->truename}
                        </a>
                    {else}
                        {$story->server}
                    {/if}
                </p>
                <p>
                    {$count = $story->user_views_count}
                    {if="$count > 2"}
                        {$count} {autoescape="off"}{$c->svg('View-Eye-1--Streamline-Freehand')}{/autoescape} •
                    {/if}

                    {$c->prepareDate($story->published, true)}
                </p>
            </div>
        </li>
    </ul>
    <ul class="list middle">
        <li>
            <div>
                <p class="title">{autoescape="off"}{$story->title|addHashtagsLinks}{/autoescape}</p>
            </div>
        </li>
        {if="!$story->isMine($c->me) && $story->contact"}
        <li class="comment">
            <span class="control icon active" onclick="StoriesViewer.sendComment({$story->id})">
                {autoescape="off"}{$c->svg('Send-Email-Fly--Streamline-Freehand')}{/autoescape}
            </span>
            <form name="storycomment" onsubmit="return false;">
                <div>
                    <input name="comment" autocomplete="off" type="text" {if="$story->contact"}placeholder="{$c->__('stories.comment', $story->contact->truename)}"{/if} onfocus="StoriesViewer.pause()" onblur="StoriesViewer_ajaxStart()">
                </div>
            </form>
        </li>
        {/if}
    </ul>
</article>