<div class="placeholder">
    {$c->svgIcon("Share-Circles--Streamline-Freehand")}

    {if="$subscription && $subscription->info"}
        <h1>
            {autoescape="off"}{$subscription->info->name|addEmojis}{/autoescape}
        </h1>
    {/if}
</div>