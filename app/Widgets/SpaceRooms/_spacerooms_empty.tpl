<div class="placeholder">
    {autoescape="off"}{$c->svg('Share-Circles--Streamline-Freehand')}{/autoescape}

    {if="$subscription && $subscription->info"}
        <h1>
            {autoescape="off"}{$subscription->info->name|addEmojis}{/autoescape}
        </h1>
    {/if}
</div>