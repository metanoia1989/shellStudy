<?php

//****************************************************** 
// swoole + inotify 异步非阻塞监听文件
//****************************************************** 

Co::set(['hook_flags' => SWOOLE_HOOK_ALL | SWOOLE_HOOK_CURL]); //真正的hook所有类型，包括CURL

// 创建一个 inotify 句柄
$fd = inotify_init();

// 监听文件，仅监听删除操作和修改操作
$path = "/www/wwwroot/invt/public/uploads/";
$dir = dir($path);
$listen_dirs = [];
while (($entry = $dir->read()) !== false ) {
    if($entry == "." || $entry == "..") continue;
    $entry = $path.$entry;
    if(!is_dir($entry)) continue;
    $watch_descriptor = inotify_add_watch($fd, $entry, IN_MOVE|IN_DELETE);
    $listen_dirs[$watch_descriptor] = $entry;
}

// 事件描述
$mask_descs = [
    IN_ACCESS => 'File Accessed',
    IN_MODIFY => 'File Modified',
    IN_ATTRIB => 'File Metadata Modified',
    IN_CLOSE_WRITE => 'File Closed, Opened for Writing',
    IN_CLOSE_NOWRITE => 'File Closed, Opened for Read',
    IN_OPEN => 'File Opened',
    IN_MOVE => 'File Moved',
    IN_MOVED_FROM  => '文件移出了观察目录',
    IN_MOVED_TO => '文件移入了观察目录',
    IN_CREATE => 'File Created',
    IN_DELETE => 'File Deleted'
];

$dsn = "mysql:host=127.0.0.1;dbname=invitation";
$user = "invitation";
$passwd = "********";
$pdo = new PDO($dsn, $user, $passwd);

function insert_log($remark)
{
    global $pdo;
    try {
        $action_ip = ip2long("127.0.0.1");
        $stm = $pdo->prepare("INSERT INTO dp_admin_log (`model`, `remark`, `create_time`, `action_ip`) 
            VALUES ('delete_file', :remark, :create_time, $action_ip)");
        $row = ["remark" => $remark, "create_time" => time()];
        $stm->execute($row);
        echo $remark."\n";
        // $stm->debugDumpParams();
    } catch (\Throwable $th) {
        echo "{$th->getMessage()}.\n";
    }
    
}


// 加入到 swoole 的事件循环中
Swoole\Coroutine\run(function () use ($fd, $mask_descs, $listen_dirs) {
    echo "开始监听文件移动和删除！\n";
    while (($events = inotify_read($fd))) {
        foreach ($events as $event) {
            $name = $mask_descs[$event['mask']] ?? ""; 
            echo "intofy Event@{$name}: ".var_export($event, 1)."\n";
            $filename = $listen_dirs[$event['wd']].$event['name'];
            insert_log($name." ".$filename);
        }
    }
});
