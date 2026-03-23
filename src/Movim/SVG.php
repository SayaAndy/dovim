<?php
/*
 * SPDX-FileCopyrightText: 2026 Saya Andy
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

namespace Movim;

class SVG
{
    private const CACHE_PATH = CACHE_PATH . 'streamlinehq/';

    private static $instance;
    private $streamlinehqMap = [];

    public function __construct() {
        $paths = glob(SVG::CACHE_PATH . '*.svg', GLOB_NOSORT);
        foreach ($paths as $path) {
            if (!is_file($path)) {
                continue;
            }
            $this->streamlinehqMap[basename($path, '.svg')] = file_get_contents($path);
        }
    }

    public static function start()
    {
        if (!isset(self::$instance)) {
            self::$instance = new self();
        }

        return self::$instance;
    }

    /*
     * @desc Read from cache and return SVG HTML element; if not, just returns an id with escaped html special chars
     */
    public function get(string $id, string ...$classes): string
    {
        if (!array_key_exists($id, $this->streamlinehqMap)) {
            return htmlspecialchars($id);
        }

        $content = $this->streamlinehqMap[$id];
        if (count($classes) > 0) {
            $content = str_replace("<svg ", "<svg class=\"" . implode(" ", $classes) . "\" ", $content);
        }

        return call_user_func_array("sprintf", [$content]);
    }
}
