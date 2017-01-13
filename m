Received: from eggs.gnu.org ([2001:4830:134:3::10]:60038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33i-0003qs-7d
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33M-0006b1-MY
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS33L-0006aJ-Ow
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:04 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF43581240
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:42:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:28 +0100
Message-Id: <20170113144135.5150-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 14/21] (SQUASHED) move doc to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qmp-commands: move 'add_client' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-name' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-kvm' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-status' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-uuid' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-chardev' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-chardev-backends' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'ringbuf-write' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'ringbuf-read' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-events' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-migrate' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'migrate-set-capabilities' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-migrate-capabilities' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'migrate-set-parameters' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-migrate-parameters' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'client_migrate_info' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'migrate-start-postcopy' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-mice' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-cpus' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-iothreads' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-vnc' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-spice' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-balloon' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-pci' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'quit' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'stop' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'system_reset' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'system_powerdown' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'cpu-add' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'memsave' doc to schema

Notice that "cpu" argument is actually "cpu-index" in the json.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'pmemsave' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'cont' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'system_wakeup' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'inject-nmi' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'set_link' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'balloon' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'transaction' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'human-monitor-command' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'migrate_cancel' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'migrate_set_downtime' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'migrate_set_speed' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-migrate-cache-size' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'set_password' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'expire_password' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'change' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'migrate' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'migrate-incoming' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'xen-save-devices-state' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'xen-set-global-dirty-log' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'device_del' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'dump-guest-memory' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-dump-guest-memory-capability' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'dump-skeys' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'netdev_add' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'netdev_del' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'object-add' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'object-del' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'getfd' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'closefd' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'add-fd' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'remove-fd' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-fdsets' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'send-key' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'screendump' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'chardev-add' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'chardev-remove' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-tpm-models' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-tpm-types' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-tpm' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-command-line-options' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-rx-filter' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'input-send-event' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-memdev' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-memory-devices' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-acpi-ospm-status' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'rtc-reset-reinjection' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-block' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-blockstats' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'block_passwd' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'block_resize' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'blockdev-snapshot-sync' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'blockdev-snapshot' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'change-backing-file' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'block-commit' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'drive-backup' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'blockdev-backup' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-named-block-nodes' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'drive-mirror' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'block-dirty-bitmap-add' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'block-dirty-bitmap-remove' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'block-dirty-bitmap-clear' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'block_set_io_throttle' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'block-stream' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'blockdev-add' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'x-blockdev-del' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'blockdev-open-tray' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'blockdev-close-tray' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'x-blockdev-remove-medium' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'x-blockdev-insert-medium' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'blockdev-change-medium' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'block-set-write-threshold' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'blockdev-snapshot-internal-sync' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'blockdev-snapshot-delete-internal-sync' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'eject' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-version' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-commands' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-rocker' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-rocker-ports' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-rocker-of-dpa-flows' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-rocker-of-dpa-groups' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'trace-event-get-state' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'trace-event-set-state' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-hotpluggable-cpus' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-gic-capabilities' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'x-blockdev-change' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'blockdev-mirror' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'query-dump' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'migrate-set-cache-size' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'xen-load-devices-state' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move 'x-colo-lost-heartbeat' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: remove query-qmp-schema from txt

It's better described in the schema already.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: remove qmp_capabilities from txt

It's better described in the schema already.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: remove cpu from txt

The cpu command is deprecated since commit 755f196898.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: remove device_add from txt

It's already fully described in the schema. Fix the schema to document
the command and not the argument (place doc before first arg).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-commands: move documentation bits to schema

Moving the remaining bits of documentation to the json
file (text improvements is not the objective of this patch)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'BLOCK_IMAGE_CORRUPTED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'BLOCK_IO_ERROR' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'BLOCK_JOB_COMPLETED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'BLOCK_JOB_CANCELLED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'BLOCK_JOB_ERROR' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'BLOCK_JOB_READY' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'DEVICE_TRAY_MOVED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'SHUTDOWN' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'POWERDOWN' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'RESET' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'STOP' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'RESUME' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'SUSPEND' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'SUSPEND_DISK' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'WAKEUP' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'RTC_CHANGE' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'WATCHDOG' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'DEVICE_DELETED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'NIC_RX_FILTER_CHANGED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'VNC_CONNECTED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'VNC_INITIALIZED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'VNC_DISCONNECTED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'SPICE_CONNECTED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'SPICE_INITIALIZED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'SPICE_DISCONNECTED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'SPICE_MIGRATE_COMPLETED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'MIGRATION' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'ACPI_DEVICE_OST' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'BALLOON_CHANGE' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'GUEST_PANICKED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'QUORUM_FAILURE' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'QUORUM_REPORT_BAD' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'VSERPORT_CHANGE' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'MEM_UNPLUG_ERROR' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'DUMP_COMPLETED' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qmp-events: move 'MIGRATION_PASS' doc to schema

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json      | 1271 +++++++++++++++-
 qapi/block-core.json  |  670 ++++++++-
 qapi/block.json       |   56 +-
 qapi/common.json      |   32 +
 qapi/event.json       |  240 ++++
 qapi/rocker.json      |   57 +-
 qapi/trace.json       |   14 +
 Makefile              |    1 -
 docs/qmp-commands.txt | 3824 -------------------------------------------=
------
 docs/qmp-events.txt   |  731 ----------
 10 files changed, 2300 insertions(+), 4596 deletions(-)
 delete mode 100644 docs/qmp-commands.txt
 delete mode 100644 docs/qmp-events.txt

diff --git a/qapi-schema.json b/qapi-schema.json
index 54c3e48ba9..804e2d8c5b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1,6 +1,53 @@
 # -*- Mode: Python -*-
+##
+# =3D Introduction
+#
+# This document describes all commands currently supported by QMP.
+#
+# Most of the time their usage is exactly the same as in the user Monito=
r, this
+# means that any other document which also describe commands (the manpag=
e,
+# QEMU's manual, etc) can and should be consulted.
+#
+# QMP has two types of commands: regular and query commands. Regular com=
mands
+# usually change the Virtual Machine's state someway, while query comman=
ds just
+# return information. The sections below are divided accordingly.
+#
+# It's important to observe that all communication examples are formatte=
d in
+# a reader-friendly way, so that they're easier to understand. However, =
in real
+# protocol usage, they're emitted as a single line.
+#
+# Also, the following notation is used to denote data flow:
+#
+# Example:
+#
+# | -> data issued by the Client
+# | <- Server data response
+#
+# Please, refer to the QMP specification (docs/qmp-spec.txt) for
+# detailed information on the Server command and response formats.
+#
+# =3D Stability Considerations
+#
+# The current QMP command set (described in this file) may be useful for=
 a
+# number of use cases, however it's limited and several commands have ba=
d
+# defined semantics, specially with regard to command completion.
+#
+# These problems are going to be solved incrementally in the next QEMU r=
eleases
+# and we're going to establish a deprecation policy for badly defined co=
mmands.
+#
+# If you're planning to adopt QMP, please observe the following:
 #
-# QAPI Schema
+#     1. The deprecation policy will take effect and be documented soon,=
 please
+#        check the documentation of each used command as soon as a new r=
elease of
+#        QEMU is available
+#
+#     2. DO NOT rely on anything which is not explicit documented
+#
+#     3. Errors, in special, are not documented. Applications should NOT=
 check
+#        for specific errors classes or data (it's strongly recommended =
to only
+#        check for the "error" key)
+#
+##
=20
 # QAPI common definitions
 { 'include': 'qapi/common.json' }
@@ -89,6 +136,13 @@
 # Returns: nothing on success.
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "add_client", "arguments": { "protocol": "vnc",
+#                                              "fdname": "myclient" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'add_client',
   'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
@@ -113,6 +167,12 @@
 # Returns: @NameInfo of the guest
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-name" }
+# <- { "return": { "name": "qemu-name" } }
+#
 ##
 { 'command': 'query-name', 'returns': 'NameInfo' }
=20
@@ -137,6 +197,12 @@
 # Returns: @KvmInfo
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-kvm" }
+# <- { "return": { "enabled": true, "present": true } }
+#
 ##
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
=20
@@ -217,13 +283,21 @@
 # Returns: @StatusInfo reflecting all VCPUs
 #
 # Since:  0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-status" }
+# <- { "return": { "running": true,
+#                  "singlestep": false,
+#                  "status": "running" } }
+#
 ##
 { 'command': 'query-status', 'returns': 'StatusInfo' }
=20
 ##
 # @UuidInfo:
 #
-# Guest UUID information.
+# Guest UUID information (Universally Unique Identifier).
 #
 # @UUID: the UUID of the guest
 #
@@ -241,6 +315,12 @@
 # Returns: The @UuidInfo for the guest
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-uuid" }
+# <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
+#
 ##
 { 'command': 'query-uuid', 'returns': 'UuidInfo' }
=20
@@ -274,6 +354,30 @@
 # Returns: a list of @ChardevInfo
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-chardev" }
+# <- {
+#       "return": [
+#          {
+#             "label": "charchannel0",
+#             "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.agen=
t,server",
+#             "frontend-open": false
+#          },
+#          {
+#             "label": "charmonitor",
+#             "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.moni=
tor,server",
+#             "frontend-open": true
+#          },
+#          {
+#             "label": "charserial0",
+#             "filename": "pty:/dev/pts/2",
+#             "frontend-open": true
+#          }
+#       ]
+#    }
+#
 ##
 { 'command': 'query-chardev', 'returns': ['ChardevInfo'] }
=20
@@ -296,6 +400,27 @@
 # Returns: a list of @ChardevBackendInfo
 #
 # Since: 2.0
+#
+# Example:
+#
+# -> { "execute": "query-chardev-backends" }
+# <- {
+#       "return":[
+#          {
+#             "name":"udp"
+#          },
+#          {
+#             "name":"tcp"
+#          },
+#          {
+#             "name":"unix"
+#          },
+#          {
+#             "name":"spiceport"
+#          }
+#       ]
+#    }
+#
 ##
 { 'command': 'query-chardev-backends', 'returns': ['ChardevBackendInfo']=
 }
=20
@@ -332,6 +457,15 @@
 # Returns: Nothing on success
 #
 # Since: 1.4
+#
+# Example:
+#
+# -> { "execute": "ringbuf-write",
+#      "arguments": { "device": "foo",
+#                     "data": "abcdefgh",
+#                     "format": "utf8" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'ringbuf-write',
   'data': {'device': 'str', 'data': 'str',
@@ -359,6 +493,15 @@
 # Returns: data read from the device
 #
 # Since: 1.4
+#
+# Example:
+#
+# -> { "execute": "ringbuf-read",
+#      "arguments": { "device": "foo",
+#                     "size": 1000,
+#                     "format": "utf8" } }
+# <- { "return": "abcdefgh" }
+#
 ##
 { 'command': 'ringbuf-read',
   'data': {'device': 'str', 'size': 'int', '*format': 'DataFormat'},
@@ -383,6 +526,23 @@
 # Returns: A list of @EventInfo for all supported events
 #
 # Since: 1.2.0
+#
+# Example:
+#
+# -> { "execute": "query-events" }
+# <- {
+#      "return": [
+#          {
+#             "name":"SHUTDOWN"
+#          },
+#          {
+#             "name":"RESET"
+#          }
+#       ]
+#    }
+#
+# Note: This example has been shortened as the real response is too long=
.
+#
 ##
 { 'command': 'query-events', 'returns': ['EventInfo'] }
=20
@@ -542,11 +702,124 @@
 ##
 # @query-migrate:
 #
-# Returns information about current migration process.
+# Returns information about current migration process. If migration
+# is active there will be another json-object with RAM migration
+# status and if block migration is active another one with block
+# migration status.
 #
 # Returns: @MigrationInfo
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# 1. Before the first migration
+#
+# -> { "execute": "query-migrate" }
+# <- { "return": {} }
+#
+# 2. Migration is done and has succeeded
+#
+# -> { "execute": "query-migrate" }
+# <- { "return": {
+#         "status": "completed",
+#         "ram":{
+#           "transferred":123,
+#           "remaining":123,
+#           "total":246,
+#           "total-time":12345,
+#           "setup-time":12345,
+#           "downtime":12345,
+#           "duplicate":123,
+#           "normal":123,
+#           "normal-bytes":123456,
+#           "dirty-sync-count":15
+#         }
+#      }
+#    }
+#
+# 3. Migration is done and has failed
+#
+# -> { "execute": "query-migrate" }
+# <- { "return": { "status": "failed" } }
+#
+# 4. Migration is being performed and is not a block migration:
+#
+# -> { "execute": "query-migrate" }
+# <- {
+#       "return":{
+#          "status":"active",
+#          "ram":{
+#             "transferred":123,
+#             "remaining":123,
+#             "total":246,
+#             "total-time":12345,
+#             "setup-time":12345,
+#             "expected-downtime":12345,
+#             "duplicate":123,
+#             "normal":123,
+#             "normal-bytes":123456,
+#             "dirty-sync-count":15
+#          }
+#       }
+#    }
+#
+# 5. Migration is being performed and is a block migration:
+#
+# -> { "execute": "query-migrate" }
+# <- {
+#       "return":{
+#          "status":"active",
+#          "ram":{
+#             "total":1057024,
+#             "remaining":1053304,
+#             "transferred":3720,
+#             "total-time":12345,
+#             "setup-time":12345,
+#             "expected-downtime":12345,
+#             "duplicate":123,
+#             "normal":123,
+#             "normal-bytes":123456,
+#             "dirty-sync-count":15
+#          },
+#          "disk":{
+#             "total":20971520,
+#             "remaining":20880384,
+#             "transferred":91136
+#          }
+#       }
+#    }
+#
+# 6. Migration is being performed and XBZRLE is active:
+#
+# -> { "execute": "query-migrate" }
+# <- {
+#       "return":{
+#          "status":"active",
+#          "capabilities" : [ { "capability": "xbzrle", "state" : true }=
 ],
+#          "ram":{
+#             "total":1057024,
+#             "remaining":1053304,
+#             "transferred":3720,
+#             "total-time":12345,
+#             "setup-time":12345,
+#             "expected-downtime":12345,
+#             "duplicate":10,
+#             "normal":3333,
+#             "normal-bytes":3412992,
+#             "dirty-sync-count":15
+#          },
+#          "xbzrle-cache":{
+#             "cache-size":67108864,
+#             "bytes":20971520,
+#             "pages":2444343,
+#             "cache-miss":2244,
+#             "cache-miss-rate":0.123,
+#             "overflow":34434
+#          }
+#       }
+#    }
+#
 ##
 { 'command': 'query-migrate', 'returns': 'MigrationInfo' }
=20
@@ -620,6 +893,12 @@
 # @capabilities: json array of capability modifications to make
 #
 # Since: 1.2
+#
+# Example:
+#
+# -> { "execute": "migrate-set-capabilities" , "arguments":
+#      { "capabilities": [ { "capability": "xbzrle", "state": true } ] }=
 }
+#
 ##
 { 'command': 'migrate-set-capabilities',
   'data': { 'capabilities': ['MigrationCapabilityStatus'] } }
@@ -632,6 +911,21 @@
 # Returns: @MigrationCapabilitiesStatus
 #
 # Since: 1.2
+#
+# Example:
+#
+# -> { "execute": "query-migrate-capabilities" }
+# <- { "return": [
+#       {"state": false, "capability": "xbzrle"},
+#       {"state": false, "capability": "rdma-pin-all"},
+#       {"state": false, "capability": "auto-converge"},
+#       {"state": false, "capability": "zero-blocks"},
+#       {"state": false, "capability": "compress"},
+#       {"state": true, "capability": "events"},
+#       {"state": false, "capability": "postcopy-ram"},
+#       {"state": false, "capability": "x-colo"}
+#    ]}
+#
 ##
 { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapab=
ilityStatus']}
=20
@@ -700,6 +994,12 @@
 # Set various migration parameters.  See MigrationParameters for details=
.
 #
 # Since: 2.4
+#
+# Example:
+#
+# -> { "execute": "migrate-set-parameters" ,
+#      "arguments": { "compress-level": 1 } }
+#
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
   'data': 'MigrationParameters' }
@@ -771,6 +1071,21 @@
 # Returns: @MigrationParameters
 #
 # Since: 2.4
+#
+# Example:
+#
+# -> { "execute": "query-migrate-parameters" }
+# <- { "return": {
+#          "decompress-threads": 2,
+#          "cpu-throttle-increment": 10,
+#          "compress-threads": 8,
+#          "compress-level": 1,
+#          "cpu-throttle-initial": 20,
+#          "max-bandwidth": 33554432,
+#          "downtime-limit": 300
+#       }
+#    }
+#
 ##
 { 'command': 'query-migrate-parameters',
   'returns': 'MigrationParameters' }
@@ -789,6 +1104,15 @@
 # @cert-subject: #optional server certificate subject
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "client_migrate_info",
+#      "arguments": { "protocol": "spice",
+#                     "hostname": "virt42.lab.kraxel.org",
+#                     "port": 1234 } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'client_migrate_info',
   'data': { 'protocol': 'str', 'hostname': 'str', '*port': 'int',
@@ -802,6 +1126,12 @@
 # command.
 #
 # Since: 2.5
+#
+# Example:
+#
+# -> { "execute": "migrate-start-postcopy" }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate-start-postcopy' }
=20
@@ -874,6 +1204,12 @@
 # then takes over server operation to become the service VM.
 #
 # Since: 2.8
+#
+# Example:
+#
+# -> { "execute": "x-colo-lost-heartbeat" }
+# <- { "return": {} }
+#
 ##
 { 'command': 'x-colo-lost-heartbeat' }
=20
@@ -904,6 +1240,26 @@
 # Returns: a list of @MouseInfo for each device
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-mice" }
+# <- { "return": [
+#          {
+#             "name":"QEMU Microsoft Mouse",
+#             "index":0,
+#             "current":false,
+#             "absolute":false
+#          },
+#          {
+#             "name":"QEMU PS/2 Mouse",
+#             "index":1,
+#             "current":true,
+#             "absolute":true
+#          }
+#       ]
+#    }
+#
 ##
 { 'command': 'query-mice', 'returns': ['MouseInfo'] }
=20
@@ -1028,6 +1384,32 @@
 # Returns: a list of @CpuInfo for each virtual CPU
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-cpus" }
+# <- { "return": [
+#          {
+#             "CPU":0,
+#             "current":true,
+#             "halted":false,
+#             "qom_path":"/machine/unattached/device[0]",
+#             "arch":"x86",
+#             "pc":3227107138,
+#             "thread_id":3134
+#          },
+#          {
+#             "CPU":1,
+#             "current":false,
+#             "halted":true,
+#             "qom_path":"/machine/unattached/device[2]",
+#             "arch":"x86",
+#             "pc":7108165,
+#             "thread_id":3135
+#          }
+#       ]
+#    }
+#
 ##
 { 'command': 'query-cpus', 'returns': ['CpuInfo'] }
=20
@@ -1057,6 +1439,22 @@
 # Returns: a list of @IOThreadInfo for each iothread
 #
 # Since: 2.0
+#
+# Example:
+#
+# -> { "execute": "query-iothreads" }
+# <- { "return": [
+#          {
+#             "id":"iothread0",
+#             "thread-id":3134
+#          },
+#          {
+#             "id":"iothread1",
+#             "thread-id":3135
+#          }
+#       ]
+#    }
+#
 ##
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'] }
=20
@@ -1239,6 +1637,26 @@
 # Returns: @VncInfo
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-vnc" }
+# <- { "return": {
+#          "enabled":true,
+#          "host":"0.0.0.0",
+#          "service":"50402",
+#          "auth":"vnc",
+#          "family":"ipv4",
+#          "clients":[
+#             {
+#                "host":"127.0.0.1",
+#                "service":"50401",
+#                "family":"ipv4"
+#             }
+#          ]
+#       }
+#    }
+#
 ##
 { 'command': 'query-vnc', 'returns': 'VncInfo' }
=20
@@ -1336,7 +1754,7 @@
 # @enabled: true if the SPICE server is enabled, false otherwise
 #
 # @migrated: true if the last guest migration completed and spice
-#            migration had completed as well. false otherwise.
+#            migration had completed as well. false otherwise. (since 1.=
4)
 #
 # @host: #optional The hostname the SPICE server is bound to.  This depe=
nds on
 #        the name resolution on the host and may be an IP address.
@@ -1354,9 +1772,7 @@
 #
 # @mouse-mode: The mode in which the mouse cursor is displayed currently=
. Can
 #              be determined by the client or the server, or unknown if =
spice
-#              server doesn't provide this information.
-#
-#              Since: 1.1
+#              server doesn't provide this information. (since: 1.1)
 #
 # @channels: a list of @SpiceChannel for each active spice channel
 #
@@ -1375,6 +1791,40 @@
 # Returns: @SpiceInfo
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-spice" }
+# <- { "return": {
+#          "enabled": true,
+#          "auth": "spice",
+#          "port": 5920,
+#          "tls-port": 5921,
+#          "host": "0.0.0.0",
+#          "channels": [
+#             {
+#                "port": "54924",
+#                "family": "ipv4",
+#                "channel-type": 1,
+#                "connection-id": 1804289383,
+#                "host": "127.0.0.1",
+#                "channel-id": 0,
+#                "tls": true
+#             },
+#             {
+#                "port": "36710",
+#                "family": "ipv4",
+#                "channel-type": 4,
+#                "connection-id": 1804289383,
+#                "host": "127.0.0.1",
+#                "channel-id": 0,
+#                "tls": false
+#             },
+#             [ ... more channels follow ... ]
+#          ]
+#       }
+#    }
+#
 ##
 { 'command': 'query-spice', 'returns': 'SpiceInfo' }
=20
@@ -1396,11 +1846,22 @@
 # Return information about the balloon device.
 #
 # Returns: @BalloonInfo on success
+#
 #          If the balloon driver is enabled but not functional because t=
he KVM
 #          kernel module cannot support it, KvmMissingCap
+#
 #          If no balloon device is present, DeviceNotActive
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-balloon" }
+# <- { "return": {
+#          "actual": 1073741824,
+#       }
+#    }
+#
 ##
 { 'command': 'query-balloon', 'returns': 'BalloonInfo' }
=20
@@ -1427,6 +1888,8 @@
 # @type: 'io' if the region is a PIO region
 #        'memory' if the region is a MMIO region
 #
+# @size: memory size
+#
 # @prefetch: #optional if @type is 'memory', true if the memory is prefe=
tchable
 #
 # @mem_type_64: #optional if @type is 'memory', true if the BAR is 64-bi=
t
@@ -1560,9 +2023,144 @@
 #
 # Return information about the PCI bus topology of the guest.
 #
-# Returns: a list of @PciInfo for each PCI bus
+# Returns: a list of @PciInfo for each PCI bus. Each bus is
+# represented by a json-object, which has a key with a json-array of
+# all PCI devices attached to it. Each device is represented by a
+# json-object.
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-pci" }
+# <- { "return": [
+#          {
+#             "bus": 0,
+#             "devices": [
+#                {
+#                   "bus": 0,
+#                   "qdev_id": "",
+#                   "slot": 0,
+#                   "class_info": {
+#                      "class": 1536,
+#                      "desc": "Host bridge"
+#                   },
+#                   "id": {
+#                      "device": 32902,
+#                      "vendor": 4663
+#                   },
+#                   "function": 0,
+#                   "regions": [
+#                   ]
+#                },
+#                {
+#                   "bus": 0,
+#                   "qdev_id": "",
+#                   "slot": 1,
+#                   "class_info": {
+#                      "class": 1537,
+#                      "desc": "ISA bridge"
+#                   },
+#                   "id": {
+#                      "device": 32902,
+#                      "vendor": 28672
+#                   },
+#                   "function": 0,
+#                   "regions": [
+#                   ]
+#                },
+#                {
+#                   "bus": 0,
+#                   "qdev_id": "",
+#                   "slot": 1,
+#                   "class_info": {
+#                      "class": 257,
+#                      "desc": "IDE controller"
+#                   },
+#                   "id": {
+#                      "device": 32902,
+#                      "vendor": 28688
+#                   },
+#                   "function": 1,
+#                   "regions": [
+#                      {
+#                         "bar": 4,
+#                         "size": 16,
+#                         "address": 49152,
+#                         "type": "io"
+#                      }
+#                   ]
+#                },
+#                {
+#                   "bus": 0,
+#                   "qdev_id": "",
+#                   "slot": 2,
+#                   "class_info": {
+#                      "class": 768,
+#                      "desc": "VGA controller"
+#                   },
+#                   "id": {
+#                      "device": 4115,
+#                      "vendor": 184
+#                   },
+#                   "function": 0,
+#                   "regions": [
+#                      {
+#                         "prefetch": true,
+#                         "mem_type_64": false,
+#                         "bar": 0,
+#                         "size": 33554432,
+#                         "address": 4026531840,
+#                         "type": "memory"
+#                      },
+#                      {
+#                         "prefetch": false,
+#                         "mem_type_64": false,
+#                         "bar": 1,
+#                         "size": 4096,
+#                         "address": 4060086272,
+#                         "type": "memory"
+#                      },
+#                      {
+#                         "prefetch": false,
+#                         "mem_type_64": false,
+#                         "bar": 6,
+#                         "size": 65536,
+#                         "address": -1,
+#                         "type": "memory"
+#                      }
+#                   ]
+#                },
+#                {
+#                   "bus": 0,
+#                   "qdev_id": "",
+#                   "irq": 11,
+#                   "slot": 4,
+#                   "class_info": {
+#                      "class": 1280,
+#                      "desc": "RAM controller"
+#                   },
+#                   "id": {
+#                      "device": 6900,
+#                      "vendor": 4098
+#                   },
+#                   "function": 0,
+#                   "regions": [
+#                      {
+#                         "bar": 0,
+#                         "size": 32,
+#                         "address": 49280,
+#                         "type": "io"
+#                      }
+#                   ]
+#                }
+#             ]
+#          }
+#       ]
+#    }
+#
+# Note: This example has been shortened as the real response is too long=
.
+#
 ##
 { 'command': 'query-pci', 'returns': ['PciInfo'] }
=20
@@ -1575,6 +2173,11 @@
 # unexpected.
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "quit" }
+# <- { "return": {} }
 ##
 { 'command': 'quit' }
=20
@@ -1589,6 +2192,12 @@
 #         state.  In "inmigrate" state, it will ensure that the guest
 #         remains paused once migration finishes, as if the -S option wa=
s
 #         passed on the command line.
+#
+# Example:
+#
+# -> { "execute": "stop" }
+# <- { "return": {} }
+#
 ##
 { 'command': 'stop' }
=20
@@ -1598,6 +2207,12 @@
 # Performs a hard reset of a guest.
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "system_reset" }
+# <- { "return": {} }
+#
 ##
 { 'command': 'system_reset' }
=20
@@ -1612,6 +2227,11 @@
 #        returning does not indicate that a guest has accepted the reque=
st or
 #        that it has shut down.  Many guests will respond to this comman=
d by
 #        prompting the user in some way.
+# Example:
+#
+# -> { "execute": "system_powerdown" }
+# <- { "return": {} }
+#
 ##
 { 'command': 'system_powerdown' }
=20
@@ -1636,6 +2256,12 @@
 # Returns: Nothing on success
 #
 # Since: 1.5
+#
+# Example:
+#
+# -> { "execute": "cpu-add", "arguments": { "id": 2 } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'cpu-add', 'data': {'id': 'int'} }
=20
@@ -1658,6 +2284,15 @@
 # Since: 0.14.0
 #
 # Notes: Errors were not reliably returned until 1.1
+#
+# Example:
+#
+# -> { "execute": "memsave",
+#      "arguments": { "val": 10,
+#                     "size": 100,
+#                     "filename": "/tmp/virtual-mem-dump" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'memsave',
   'data': {'val': 'int', 'size': 'int', 'filename': 'str', '*cpu-index':=
 'int'} }
@@ -1678,6 +2313,15 @@
 # Since: 0.14.0
 #
 # Notes: Errors were not reliably returned until 1.1
+#
+# Example:
+#
+# -> { "execute": "pmemsave",
+#      "arguments": { "val": 10,
+#                     "size": 100,
+#                     "filename": "/tmp/physical-mem-dump" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'pmemsave',
   'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
@@ -1698,6 +2342,12 @@
 #         this case, the effect of the command is to make sure the guest
 #         starts once migration finishes, removing the effect of the -S
 #         command line option if it was passed.
+#
+# Example:
+#
+# -> { "execute": "cont" }
+# <- { "return": {} }
+#
 ##
 { 'command': 'cont' }
=20
@@ -1709,6 +2359,12 @@
 # Since:  1.1
 #
 # Returns:  nothing.
+#
+# Example:
+#
+# -> { "execute": "system_wakeup" }
+# <- { "return": {} }
+#
 ##
 { 'command': 'system_wakeup' }
=20
@@ -1716,12 +2372,19 @@
 # @inject-nmi:
 #
 # Injects a Non-Maskable Interrupt into the default CPU (x86/s390) or al=
l CPUs (ppc64).
+# The command fails when the guest doesn't support injecting.
 #
 # Returns:  If successful, nothing
 #
 # Since:  0.14.0
 #
 # Note: prior to 2.1, this command was only supported for x86 and s390 V=
Ms
+#
+# Example:
+#
+# -> { "execute": "inject-nmi" }
+# <- { "return": {} }
+#
 ##
 { 'command': 'inject-nmi' }
=20
@@ -1742,6 +2405,13 @@
 # Notes: Not all network adapters support setting link status.  This com=
mand
 #        will succeed even if the network adapter does not support link =
status
 #        notification.
+#
+# Example:
+#
+# -> { "execute": "set_link",
+#      "arguments": { "name": "e1000.0", "up": false } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'set_link', 'data': {'name': 'str', 'up': 'bool'} }
=20
@@ -1762,6 +2432,12 @@
 #        size independent of this command.
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'balloon', 'data': {'value': 'int'} }
=20
@@ -1848,6 +2524,28 @@
 # operation fails, then the entire set of actions will be abandoned and =
the
 # appropriate error returned.
 #
+# For external snapshots, the dictionary contains the device, the file t=
o use for
+# the new snapshot, and the format.  The default format, if not specifie=
d, is
+# qcow2.
+#
+# Each new snapshot defaults to being created by QEMU (wiping any
+# contents if the file already exists), but it is also possible to reuse
+# an externally-created file.  In the latter case, you should ensure tha=
t
+# the new image file has the same contents as the current one; QEMU cann=
ot
+# perform any meaningful check.  Typically this is achieved by using the
+# current image file as the backing file for the new image.
+#
+# On failure, the original disks pre-snapshot attempt will be used.
+#
+# For internal snapshots, the dictionary contains the device and the sna=
pshot's
+# name.  If an internal snapshot matching name already exists, the reque=
st will
+# be rejected.  Only some image formats support it, for example, qcow2, =
rbd,
+# and sheepdog.
+#
+# On failure, qemu will try delete the newly created internal snapshot i=
n the
+# transaction.  When an I/O error occurs during deletion, the user needs=
 to fix
+# it later with qemu-img or other command.
+#
 # @actions: List of @TransactionAction;
 #           information needed for the respective operations.
 #
@@ -1856,6 +2554,7 @@
 #              for additional detail.
 #
 # Returns: nothing on success
+#
 #          Errors depend on the operations of the transaction
 #
 # Note: The transaction aborts on the first failure.  Therefore, there w=
ill be
@@ -1863,6 +2562,28 @@
 # subsequent actions will not have been attempted.
 #
 # Since: 1.1
+#
+# Example:
+#
+# -> { "execute": "transaction",
+#      "arguments": { "actions": [
+#          { "type": "blockdev-snapshot-sync", "data" : { "device": "ide=
-hd0",
+#                                      "snapshot-file": "/some/place/my-=
image",
+#                                      "format": "qcow2" } },
+#          { "type": "blockdev-snapshot-sync", "data" : { "node-name": "=
myfile",
+#                                      "snapshot-file": "/some/place/my-=
image2",
+#                                      "snapshot-node-name": "node3432",
+#                                      "mode": "existing",
+#                                      "format": "qcow2" } },
+#          { "type": "blockdev-snapshot-sync", "data" : { "device": "ide=
-hd1",
+#                                      "snapshot-file": "/some/place/my-=
image2",
+#                                      "mode": "existing",
+#                                      "format": "qcow2" } },
+#          { "type": "blockdev-snapshot-internal-sync", "data" : {
+#                                      "device": "ide-hd2",
+#                                      "name": "snapshot0" } } ] } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'transaction',
   'data': { 'actions': [ 'TransactionAction' ],
@@ -1884,7 +2605,11 @@
 # Since: 0.14.0
 #
 # Notes: This command only exists as a stop-gap.  Its use is highly
-#        discouraged.  The semantics of this command are not guaranteed.
+#        discouraged.  The semantics of this command are not
+#        guaranteed: this means that command names, arguments and
+#        responses can change or be removed at ANY time.  Applications
+#        that rely on long term stability guarantees should NOT
+#        use this command.
 #
 #        Known limitations:
 #
@@ -1893,6 +2618,13 @@
 #
 #        * Commands that prompt the user for data (eg. 'cont' when the b=
lock
 #          device is encrypted) don't currently work
+#
+# Example:
+#
+# -> { "execute": "human-monitor-command",
+#      "arguments": { "command-line": "info kvm" } }
+# <- { "return": "kvm support: enabled\r\n" }
+#
 ##
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
@@ -1908,6 +2640,12 @@
 # Notes: This command succeeds even if there is no migration process run=
ning.
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "migrate_cancel" }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate_cancel' }
=20
@@ -1923,6 +2661,12 @@
 # Notes: This command is deprecated in favor of 'migrate-set-parameters'
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "migrate_set_downtime", "arguments": { "value": 0.1 } =
}
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate_set_downtime', 'data': {'value': 'number'} }
=20
@@ -1931,20 +2675,26 @@
 #
 # Set maximum speed for migration.
 #
-# @value: maximum speed in bytes.
+# @value: maximum speed in bytes per second.
 #
 # Returns: nothing on success
 #
 # Notes: This command is deprecated in favor of 'migrate-set-parameters'
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "migrate_set_speed", "arguments": { "value": 1024 } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate_set_speed', 'data': {'value': 'int'} }
=20
 ##
 # @migrate-set-cache-size:
 #
-# Set XBZRLE cache size
+# Set cache size to be used by XBZRLE migration
 #
 # @value: cache size in bytes
 #
@@ -1954,17 +2704,30 @@
 # Returns: nothing on success
 #
 # Since: 1.2
+#
+# Example:
+#
+# -> { "execute": "migrate-set-cache-size",
+#      "arguments": { "value": 536870912 } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate-set-cache-size', 'data': {'value': 'int'} }
=20
 ##
 # @query-migrate-cache-size:
 #
-# query XBZRLE cache size
+# Query migration XBZRLE cache size
 #
 # Returns: XBZRLE cache size in bytes
 #
 # Since: 1.2
+#
+# Example:
+#
+# -> { "execute": "query-migrate-cache-size" }
+# <- { "return": 67108864 }
+#
 ##
 { 'command': 'query-migrate-cache-size', 'returns': 'int' }
=20
@@ -2081,6 +2844,13 @@
 #          If Spice is not enabled, DeviceNotFound
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "set_password", "arguments": { "protocol": "vnc",
+#                                                "password": "secret" } =
}
+# <- { "return": {} }
+#
 ##
 { 'command': 'set_password',
   'data': {'protocol': 'str', 'password': 'str', '*connected': 'str'} }
@@ -2107,6 +2877,13 @@
 #        coordinate server time with client time.  It is not recommended=
 to
 #        use the absolute time version of the @time parameter unless you=
're
 #        sure you are on the same machine as the QEMU instance.
+#
+# Example:
+#
+# -> { "execute": "expire_password", "arguments": { "protocol": "vnc",
+#                                                   "time": "+60" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'expire_password', 'data': {'protocol': 'str', 'time': 'str=
'} }
=20
@@ -2157,6 +2934,23 @@
 #         change-vnc-password.
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# 1. Change a removable medium
+#
+# -> { "execute": "change",
+#      "arguments": { "device": "ide1-cd0",
+#                     "target": "/srv/images/Fedora-12-x86_64-DVD.iso" }=
 }
+# <- { "return": {} }
+#
+# 2. Change VNC password
+#
+# -> { "execute": "change",
+#      "arguments": { "device": "vnc", "target": "password",
+#                     "arg": "foobar1" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'change',
   'data': {'device': 'str', 'target': 'str', '*arg': 'str'} }
@@ -2239,6 +3033,22 @@
 # Returns: nothing on success
 #
 # Since: 0.14.0
+#
+# Notes:
+#
+# 1. The 'query-migrate' command should be used to check migration's pro=
gress
+#    and final result (this information is provided by the 'status' memb=
er)
+#
+# 2. All boolean arguments default to false
+#
+# 3. The user Monitor's "detach" argument is invalid in QMP and should n=
ot
+#    be used
+#
+# Example:
+#
+# -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate',
   'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool', '*detach': 'boo=
l' } }
@@ -2255,9 +3065,24 @@
 # Returns: nothing on success
 #
 # Since: 2.3
-# Note: It's a bad idea to use a string for the uri, but it needs to sta=
y
-# compatible with -incoming and the format of the uri is already exposed
-# above libvirt
+#
+# Notes:
+#
+# 1. It's a bad idea to use a string for the uri, but it needs to stay
+#    compatible with -incoming and the format of the uri is already expo=
sed
+#    above libvirt.
+#
+# 2. QEMU must be started with -incoming defer to allow migrate-incoming=
 to
+#    be used.
+#
+# 3. The uri format is the same as for -incoming
+#
+# Example:
+#
+# -> { "execute": "migrate-incoming",
+#      "arguments": { "uri": "tcp::4446" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
=20
@@ -2274,6 +3099,13 @@
 # Returns: Nothing on success
 #
 # Since: 1.1
+#
+# Example:
+#
+# -> { "execute": "xen-save-devices-state",
+#      "arguments": { "filename": "/tmp/save" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'xen-save-devices-state', 'data': {'filename': 'str'} }
=20
@@ -2287,6 +3119,13 @@
 # Returns: nothing
 #
 # Since: 1.3
+#
+# Example:
+#
+# -> { "execute": "xen-set-global-dirty-log",
+#      "arguments": { "enable": true } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'xen-set-global-dirty-log', 'data': { 'enable': 'bool' } }
=20
@@ -2335,7 +3174,7 @@
 #
 # Remove a device from a guest
 #
-# @id: the name or QOM path of the device
+# @id: the device's ID or QOM path
 #
 # Returns: Nothing on success
 #          If @id is not a valid device, DeviceNotFound
@@ -2348,6 +3187,17 @@
 #        for all devices.
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "device_del",
+#      "arguments": { "id": "net1" } }
+# <- { "return": {} }
+#
+# -> { "execute": "device_del",
+#      "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'device_del', 'data': {'id': 'str'} }
=20
@@ -2414,9 +3264,18 @@
 #          @length is not allowed to be specified with non-elf @format a=
t the
 #          same time (since 2.0)
 #
+# Note: All boolean arguments default to false
+#
 # Returns: nothing on success
 #
 # Since: 1.2
+#
+# Example:
+#
+# -> { "execute": "dump-guest-memory",
+#      "arguments": { "protocol": "fd:dump" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'dump-guest-memory',
   'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
@@ -2467,6 +3326,13 @@
 # Returns: A @DumpStatus object showing the dump status.
 #
 # Since: 2.6
+#
+# Example:
+#
+# -> { "execute": "query-dump" }
+# <- { "return": { "status": "active", "completed": 1024000,
+#                  "total": 2048000 } }
+#
 ##
 { 'command': 'query-dump', 'returns': 'DumpQueryResult' }
=20
@@ -2490,6 +3356,13 @@
 #           dump-guest-memory
 #
 # Since: 2.0
+#
+# Example:
+#
+# -> { "execute": "query-dump-guest-memory-capability" }
+# <- { "return": { "formats":
+#                  ["elf", "kdump-zlib", "kdump-lzo", "kdump-snappy"] }
+#
 ##
 { 'command': 'query-dump-guest-memory-capability',
   'returns': 'DumpGuestMemoryCapability' }
@@ -2504,6 +3377,13 @@
 # This command is only supported on s390 architecture.
 #
 # Since: 2.5
+#
+# Example:
+#
+# -> { "execute": "dump-skeys",
+#      "arguments": { "filename": "/tmp/skeys" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'dump-skeys',
   'data': { 'filename': 'str' } }
@@ -2529,6 +3409,14 @@
 #
 # Returns: Nothing on success
 #          If @type is not a valid network backend, DeviceNotFound
+#
+# Example:
+#
+# -> { "execute": "netdev_add",
+#      "arguments": { "type": "user", "id": "netdev1",
+#                     "dnssearch": "example.org" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'netdev_add',
   'data': {'type': 'str', 'id': 'str'},
@@ -2545,6 +3433,12 @@
 #          If @id is not a valid network backend, DeviceNotFound
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "netdev_del", "arguments": { "id": "netdev1" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'netdev_del', 'data': {'id': 'str'} }
=20
@@ -2563,6 +3457,14 @@
 #          Error if @qom-type is not a valid class name
 #
 # Since: 2.0
+#
+# Example:
+#
+# -> { "execute": "object-add",
+#      "arguments": { "qom-type": "rng-random", "id": "rng1",
+#                     "props": { "filename": "/dev/hwrng" } } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'object-add',
   'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'} }
@@ -2578,6 +3480,12 @@
 #          Error if @id is not a valid id for a QOM object
 #
 # Since: 2.0
+#
+# Example:
+#
+# -> { "execute": "object-del", "arguments": { "id": "rng1" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'object-del', 'data': {'id': 'str'} }
=20
@@ -3152,8 +4060,15 @@
 # Notes: If @fdname already exists, the file descriptor assigned to
 #        it will be closed and replaced by the received file
 #        descriptor.
+#
 #        The 'closefd' command can be used to explicitly close the
 #        file descriptor when it is no longer needed.
+#
+# Example:
+#
+# -> { "execute": "getfd", "arguments": { "fdname": "fd1" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'getfd', 'data': {'fdname': 'str'} }
=20
@@ -3167,6 +4082,12 @@
 # Returns: Nothing on success
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "closefd", "arguments": { "fdname": "fd1" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'closefd', 'data': {'fdname': 'str'} }
=20
@@ -3516,7 +4437,9 @@
 # @opaque: #optional A free-form string that can be used to describe the=
 fd.
 #
 # Returns: @AddfdInfo on success
+#
 #          If file descriptor was not received, FdNotSupplied
+#
 #          If @fdset-id is a negative value, InvalidParameterValue
 #
 # Notes: The list of fd sets is shared by all monitor connections.
@@ -3524,6 +4447,12 @@
 #        If @fdset-id is not specified, a new fd set will be created.
 #
 # Since: 1.2.0
+#
+# Example:
+#
+# -> { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
+# <- { "return": { "fdset-id": 1, "fd": 3 } }
+#
 ##
 { 'command': 'add-fd', 'data': {'*fdset-id': 'int', '*opaque': 'str'},
   'returns': 'AddfdInfo' }
@@ -3546,6 +4475,12 @@
 #
 #        If @fd is not specified, all file descriptors in @fdset-id
 #        will be removed.
+#
+# Example:
+#
+# -> { "execute": "remove-fd", "arguments": { "fdset-id": 1, "fd": 3 } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'remove-fd', 'data': {'fdset-id': 'int', '*fd': 'int'} }
=20
@@ -3588,6 +4523,37 @@
 #
 # Note: The list of fd sets is shared by all monitor connections.
 #
+# Example:
+#
+# -> { "execute": "query-fdsets" }
+# <- { "return": [
+#        {
+#          "fds": [
+#            {
+#              "fd": 30,
+#              "opaque": "rdonly:/path/to/file"
+#            },
+#            {
+#              "fd": 24,
+#              "opaque": "rdwr:/path/to/file"
+#            }
+#          ],
+#          "fdset-id": 1
+#        },
+#        {
+#          "fds": [
+#            {
+#              "fd": 28
+#            },
+#            {
+#              "fd": 29
+#            }
+#          ],
+#          "fdset-id": 0
+#        }
+#      ]
+#    }
+#
 ##
 { 'command': 'query-fdsets', 'returns': ['FdsetInfo'] }
=20
@@ -3684,6 +4650,14 @@
 #
 # Since: 1.3.0
 #
+# Example:
+#
+# -> { "execute": "send-key",
+#      "arguments": { "keys": [ { "type": "qcode", "data": "ctrl" },
+#                               { "type": "qcode", "data": "alt" },
+#                               { "type": "qcode", "data": "delete" } ] =
} }
+# <- { "return": {} }
+#
 ##
 { 'command': 'send-key',
   'data': { 'keys': ['KeyValue'], '*hold-time': 'int' } }
@@ -3698,6 +4672,13 @@
 # Returns: Nothing on success
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "screendump",
+#      "arguments": { "filename": "/tmp/image" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'screendump', 'data': {'filename': 'str'} }
=20
@@ -3922,6 +4903,25 @@
 # Returns: ChardevReturn.
 #
 # Since: 1.4
+#
+# Example:
+#
+# -> { "execute" : "chardev-add",
+#      "arguments" : { "id" : "foo",
+#                      "backend" : { "type" : "null", "data" : {} } } }
+# <- { "return": {} }
+#
+# -> { "execute" : "chardev-add",
+#      "arguments" : { "id" : "bar",
+#                      "backend" : { "type" : "file",
+#                                    "data" : { "out" : "/tmp/bar.log" }=
 } } }
+# <- { "return": {} }
+#
+# -> { "execute" : "chardev-add",
+#      "arguments" : { "id" : "baz",
+#                      "backend" : { "type" : "pty", "data" : {} } } }
+# <- { "return": { "pty" : "/dev/pty/42" } }
+#
 ##
 { 'command': 'chardev-add', 'data': {'id'      : 'str',
                                      'backend' : 'ChardevBackend' },
@@ -3937,6 +4937,12 @@
 # Returns: Nothing on success
 #
 # Since: 1.4
+#
+# Example:
+#
+# -> { "execute": "chardev-remove", "arguments": { "id" : "foo" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'chardev-remove', 'data': {'id': 'str'} }
=20
@@ -3959,6 +4965,12 @@
 # Returns: a list of TpmModel
 #
 # Since: 1.5
+#
+# Example:
+#
+# -> { "execute": "query-tpm-models" }
+# <- { "return": [ "tpm-tis" ] }
+#
 ##
 { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
=20
@@ -3981,6 +4993,12 @@
 # Returns: a list of TpmType
 #
 # Since: 1.5
+#
+# Example:
+#
+# -> { "execute": "query-tpm-types" }
+# <- { "return": [ "passthrough" ] }
+#
 ##
 { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
=20
@@ -4037,6 +5055,25 @@
 # Returns: @TPMInfo on success
 #
 # Since: 1.5
+#
+# Example:
+#
+# -> { "execute": "query-tpm" }
+# <- { "return":
+#      [
+#        { "model": "tpm-tis",
+#          "options":
+#            { "type": "passthrough",
+#              "data":
+#                { "cancel-path": "/sys/class/misc/tpm0/device/cancel",
+#                  "path": "/dev/tpm0"
+#                }
+#            },
+#          "id": "tpm0"
+#        }
+#      ]
+#    }
+#
 ##
 { 'command': 'query-tpm', 'returns': ['TPMInfo'] }
=20
@@ -4163,6 +5200,28 @@
 #          @option).  Returns an error if the given @option doesn't exis=
t.
 #
 # Since: 1.5
+#
+# Example:
+#
+# -> { "execute": "query-command-line-options",
+#      "arguments": { "option": "option-rom" } }
+# <- { "return": [
+#         {
+#             "parameters": [
+#                 {
+#                     "name": "romfile",
+#                     "type": "string"
+#                 },
+#                 {
+#                     "name": "bootindex",
+#                     "type": "number"
+#                 }
+#             ],
+#             "option": "option-rom"
+#         }
+#      ]
+#    }
+#
 ##
 {'command': 'query-command-line-options', 'data': { '*option': 'str' },
  'returns': ['CommandLineOptionInfo'] }
@@ -4284,6 +5343,36 @@
 #          isn't a NIC.
 #
 # Since: 1.6
+#
+# Example:
+#
+# -> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
+# <- { "return": [
+#         {
+#             "promiscuous": true,
+#             "name": "vnet0",
+#             "main-mac": "52:54:00:12:34:56",
+#             "unicast": "normal",
+#             "vlan": "normal",
+#             "vlan-table": [
+#                 4,
+#                 0
+#             ],
+#             "unicast-table": [
+#             ],
+#             "multicast": "normal",
+#             "multicast-overflow": false,
+#             "unicast-overflow": false,
+#             "multicast-table": [
+#                 "01:00:5e:00:00:01",
+#                 "33:33:00:00:00:01",
+#                 "33:33:ff:12:34:56"
+#             ],
+#             "broadcast-allowed": false
+#         }
+#       ]
+#    }
+#
 ##
 { 'command': 'query-rx-filter', 'data': { '*name': 'str' },
   'returns': ['RxFilterInfo'] }
@@ -4382,9 +5471,9 @@
 #
 # Returns: Nothing on success.
 #
-# The @display and @head parameters can be used to send the input
-# event to specific input devices in case (a) multiple input devices
-# of the same kind are added to the virtual machine and (b) you have
+# The @device and @head parameters can be used to send the input event
+# to specific input devices in case (a) multiple input devices of the
+# same kind are added to the virtual machine and (b) you have
 # configured input routing (see docs/multiseat.txt) for those input
 # devices.  The parameters work exactly like the device and head
 # properties of input devices.  If @device is missing, only devices
@@ -4394,6 +5483,48 @@
 # precedence.
 #
 # Since: 2.6
+#
+# Note: The consoles are visible in the qom tree, under
+# /backend/console[$index]. They have a device link and head property,
+# so it is possible to map which console belongs to which device and
+# display.
+#
+# Example:
+#
+# 1. Press left mouse button.
+#
+# -> { "execute": "input-send-event",
+#     "arguments": { "device": "video0",
+#                    "events": [ { "type": "btn",
+#                    "data" : { "down": true, "button": "left" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "input-send-event",
+#     "arguments": { "device": "video0",
+#                    "events": [ { "type": "btn",
+#                    "data" : { "down": false, "button": "left" } } ] } =
}
+# <- { "return": {} }
+#
+# 2. Press ctrl-alt-del.
+#
+# -> { "execute": "input-send-event",
+#      "arguments": { "events": [
+#         { "type": "key", "data" : { "down": true,
+#           "key": {"type": "qcode", "data": "ctrl" } } },
+#         { "type": "key", "data" : { "down": true,
+#           "key": {"type": "qcode", "data": "alt" } } },
+#         { "type": "key", "data" : { "down": true,
+#           "key": {"type": "qcode", "data": "delete" } } } ] } }
+# <- { "return": {} }
+#
+# 3. Move mouse pointer to absolute coordinates (20000, 400).
+#
+# -> { "execute": "input-send-event" ,
+#   "arguments": { "events": [
+#                { "type": "abs", "data" : { "axis": "x", "value" : 2000=
0 } },
+#                { "type": "abs", "data" : { "axis": "y", "value" : 400 =
} } ] } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'input-send-event',
   'data': { '*device': 'str',
@@ -4493,6 +5624,30 @@
 # Returns: a list of @Memdev.
 #
 # Since: 2.1
+#
+# Example:
+#
+# -> { "execute": "query-memdev" }
+# <- { "return": [
+#        {
+#          "size": 536870912,
+#          "merge": false,
+#          "dump": true,
+#          "prealloc": false,
+#          "host-nodes": [0, 1],
+#          "policy": "bind"
+#        },
+#        {
+#          "size": 536870912,
+#          "merge": false,
+#          "dump": true,
+#          "prealloc": true,
+#          "host-nodes": [2, 3],
+#          "policy": "preferred"
+#        }
+#      ]
+#    }
+#
 ##
 { 'command': 'query-memdev', 'returns': ['Memdev'] }
=20
@@ -4546,6 +5701,22 @@
 # Lists available memory devices and their state
 #
 # Since: 2.1
+#
+# Example:
+#
+# -> { "execute": "query-memory-devices" }
+# <- { "return": [ { "data":
+#                       { "addr": 5368709120,
+#                         "hotpluggable": true,
+#                         "hotplugged": true,
+#                         "id": "d1",
+#                         "memdev": "/objects/memX",
+#                         "node": 0,
+#                         "size": 1073741824,
+#                         "slot": 0},
+#                    "type": "dimm"
+#                  } ] }
+#
 ##
 { 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
=20
@@ -4586,10 +5757,20 @@
 ##
 # @query-acpi-ospm-status:
 #
-# Lists ACPI OSPM status of ACPI device objects,
-# which might be reported via _OST method
+# Return a list of ACPIOSTInfo for devices that support status
+# reporting via ACPI _OST method.
 #
 # Since: 2.1
+#
+# Example:
+#
+# -> { "execute": "query-acpi-ospm-status" }
+# <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "=
source": 1, "status": 0},
+#                  { "slot": "1", "slot-type": "DIMM", "source": 0, "sta=
tus": 0},
+#                  { "slot": "2", "slot-type": "DIMM", "source": 0, "sta=
tus": 0},
+#                  { "slot": "3", "slot-type": "DIMM", "source": 0, "sta=
tus": 0}
+#    ]}
+#
 ##
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
=20
@@ -4656,6 +5837,12 @@
 # command.
 #
 # Since: 2.1
+#
+# Example:
+#
+# -> { "execute": "rtc-reset-reinjection" }
+# <- { "return": {} }
+#
 ##
 { 'command': 'rtc-reset-reinjection' }
=20
@@ -4691,6 +5878,13 @@
 # format.
 #
 # Since: 2.7
+#
+# Example:
+#
+# -> { "execute": "xen-load-devices-state",
+#      "arguments": { "filename": "/tmp/resume" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
=20
@@ -4727,6 +5921,13 @@
 # Returns: a list of GICCapability objects.
 #
 # Since: 2.6
+#
+# Example:
+#
+# -> { "execute": "query-gic-capabilities" }
+# <- { "return": [{ "version": 2, "emulated": true, "kernel": false },
+#                 { "version": 3, "emulated": false, "kernel": true } ] =
}
+#
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
=20
@@ -4783,5 +5984,33 @@
 # Returns: a list of HotpluggableCPU objects.
 #
 # Since: 2.7
+#
+# Example:
+#
+# For pseries machine type started with -smp 2,cores=3D2,maxcpus=3D4 -cp=
u POWER8:
+#
+# -> { "execute": "query-hotpluggable-cpus" }
+# <- {"return": [
+#      { "props": { "core": 8 }, "type": "POWER8-spapr-cpu-core",
+#        "vcpus-count": 1 },
+#      { "props": { "core": 0 }, "type": "POWER8-spapr-cpu-core",
+#        "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
+#    ]}'
+#
+# For pc machine type started with -smp 1,maxcpus=3D2:
+#
+# -> { "execute": "query-hotpluggable-cpus" }
+# <- {"return": [
+#      {
+#         "type": "qemu64-x86_64-cpu", "vcpus-count": 1,
+#         "props": {"core-id": 0, "socket-id": 1, "thread-id": 0}
+#      },
+#      {
+#         "qom-path": "/machine/unattached/device[0]",
+#         "type": "qemu64-x86_64-cpu", "vcpus-count": 1,
+#         "props": {"core-id": 0, "socket-id": 0, "thread-id": 0}
+#      }
+#    ]}
+#
 ##
 { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7f7f10bb49..1b3e6eb0e8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -469,6 +469,87 @@
 # Returns: a list of @BlockInfo describing each virtual block device
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-block" }
+# <- {
+#       "return":[
+#          {
+#             "io-status": "ok",
+#             "device":"ide0-hd0",
+#             "locked":false,
+#             "removable":false,
+#             "inserted":{
+#                "ro":false,
+#                "drv":"qcow2",
+#                "encrypted":false,
+#                "file":"disks/test.qcow2",
+#                "backing_file_depth":1,
+#                "bps":1000000,
+#                "bps_rd":0,
+#                "bps_wr":0,
+#                "iops":1000000,
+#                "iops_rd":0,
+#                "iops_wr":0,
+#                "bps_max": 8000000,
+#                "bps_rd_max": 0,
+#                "bps_wr_max": 0,
+#                "iops_max": 0,
+#                "iops_rd_max": 0,
+#                "iops_wr_max": 0,
+#                "iops_size": 0,
+#                "detect_zeroes": "on",
+#                "write_threshold": 0,
+#                "image":{
+#                   "filename":"disks/test.qcow2",
+#                   "format":"qcow2",
+#                   "virtual-size":2048000,
+#                   "backing_file":"base.qcow2",
+#                   "full-backing-filename":"disks/base.qcow2",
+#                   "backing-filename-format":"qcow2",
+#                   "snapshots":[
+#                      {
+#                         "id": "1",
+#                         "name": "snapshot1",
+#                         "vm-state-size": 0,
+#                         "date-sec": 10000200,
+#                         "date-nsec": 12,
+#                         "vm-clock-sec": 206,
+#                         "vm-clock-nsec": 30
+#                      }
+#                   ],
+#                   "backing-image":{
+#                       "filename":"disks/base.qcow2",
+#                       "format":"qcow2",
+#                       "virtual-size":2048000
+#                   }
+#                }
+#             },
+#             "type":"unknown"
+#          },
+#          {
+#             "io-status": "ok",
+#             "device":"ide1-cd0",
+#             "locked":false,
+#             "removable":true,
+#             "type":"unknown"
+#          },
+#          {
+#             "device":"floppy0",
+#             "locked":false,
+#             "removable":true,
+#             "type":"unknown"
+#          },
+#          {
+#             "device":"sd0",
+#             "locked":false,
+#             "removable":true,
+#             "type":"unknown"
+#          }
+#       ]
+#    }
+#
 ##
 { 'command': 'query-block', 'returns': ['BlockInfo'] }
=20
@@ -616,6 +697,9 @@
 # @stats:  A @BlockDeviceStats for the device.
 #
 # @parent: #optional This describes the file block device if it has one.
+#          Contains recursively the statistics of the underlying
+#          protocol (e.g. the host file for a qcow2 image). If there is
+#          no underlying protocol, this field is omitted
 #
 # @backing: #optional This describes the backing block device if it has =
one.
 #           (Since 2.0)
@@ -643,6 +727,106 @@
 # Returns: A list of @BlockStats for each virtual block devices.
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-blockstats" }
+# <- {
+#       "return":[
+#          {
+#             "device":"ide0-hd0",
+#             "parent":{
+#                "stats":{
+#                   "wr_highest_offset":3686448128,
+#                   "wr_bytes":9786368,
+#                   "wr_operations":751,
+#                   "rd_bytes":122567168,
+#                   "rd_operations":36772
+#                   "wr_total_times_ns":313253456
+#                   "rd_total_times_ns":3465673657
+#                   "flush_total_times_ns":49653
+#                   "flush_operations":61,
+#                   "rd_merged":0,
+#                   "wr_merged":0,
+#                   "idle_time_ns":2953431879,
+#                   "account_invalid":true,
+#                   "account_failed":false
+#                }
+#             },
+#             "stats":{
+#                "wr_highest_offset":2821110784,
+#                "wr_bytes":9786368,
+#                "wr_operations":692,
+#                "rd_bytes":122739200,
+#                "rd_operations":36604
+#                "flush_operations":51,
+#                "wr_total_times_ns":313253456
+#                "rd_total_times_ns":3465673657
+#                "flush_total_times_ns":49653,
+#                "rd_merged":0,
+#                "wr_merged":0,
+#                "idle_time_ns":2953431879,
+#                "account_invalid":true,
+#                "account_failed":false
+#             }
+#          },
+#          {
+#             "device":"ide1-cd0",
+#             "stats":{
+#                "wr_highest_offset":0,
+#                "wr_bytes":0,
+#                "wr_operations":0,
+#                "rd_bytes":0,
+#                "rd_operations":0
+#                "flush_operations":0,
+#                "wr_total_times_ns":0
+#                "rd_total_times_ns":0
+#                "flush_total_times_ns":0,
+#                "rd_merged":0,
+#                "wr_merged":0,
+#                "account_invalid":false,
+#                "account_failed":false
+#             }
+#          },
+#          {
+#             "device":"floppy0",
+#             "stats":{
+#                "wr_highest_offset":0,
+#                "wr_bytes":0,
+#                "wr_operations":0,
+#                "rd_bytes":0,
+#                "rd_operations":0
+#                "flush_operations":0,
+#                "wr_total_times_ns":0
+#                "rd_total_times_ns":0
+#                "flush_total_times_ns":0,
+#                "rd_merged":0,
+#                "wr_merged":0,
+#                "account_invalid":false,
+#                "account_failed":false
+#             }
+#          },
+#          {
+#             "device":"sd0",
+#             "stats":{
+#                "wr_highest_offset":0,
+#                "wr_bytes":0,
+#                "wr_operations":0,
+#                "rd_bytes":0,
+#                "rd_operations":0
+#                "flush_operations":0,
+#                "wr_total_times_ns":0
+#                "rd_total_times_ns":0
+#                "flush_total_times_ns":0,
+#                "rd_merged":0,
+#                "wr_merged":0,
+#                "account_invalid":false,
+#                "account_failed":false
+#             }
+#          }
+#       ]
+#    }
+#
 ##
 { 'command': 'query-blockstats',
   'data': { '*query-nodes': 'bool' },
@@ -787,6 +971,13 @@
 #         occur if an invalid password is specified.
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "block_passwd", "arguments": { "device": "ide0-hd0",
+#                                                "password": "12345" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'block_passwd', 'data': {'*device': 'str',
                                       '*node-name': 'str', 'password': '=
str'} }
@@ -808,6 +999,13 @@
 #          If @device is not a valid block device, DeviceNotFound
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "block_resize",
+#      "arguments": { "device": "scratch", "size": 1073741824 } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'block_resize', 'data': { '*device': 'str',
                                        '*node-name': 'str',
@@ -839,7 +1037,9 @@
 #
 # @node-name: #optional graph node name to generate the snapshot from (S=
ince 2.0)
 #
-# @snapshot-file: the target of the new image. A new file will be create=
d.
+# @snapshot-file: the target of the new image. If the file exists, or
+# if it is a device, the snapshot will be created in the existing
+# file/device. Otherwise, a new file will be created.
 #
 # @snapshot-node-name: #optional the graph node name of the new image (S=
ince 2.0)
 #
@@ -973,6 +1173,16 @@
 #          If @device is not a valid block device, DeviceNotFound
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "blockdev-snapshot-sync",
+#      "arguments": { "device": "ide-hd0",
+#                     "snapshot-file":
+#                     "/some/place/my-image",
+#                     "format": "qcow2" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'blockdev-snapshot-sync',
   'data': 'BlockdevSnapshotSync' }
@@ -983,9 +1193,31 @@
 #
 # Generates a snapshot of a block device.
 #
+# Create a snapshot, by installing 'node' as the backing image of
+# 'overlay'. Additionally, if 'node' is associated with a block
+# device, the block device changes to using 'overlay' as its new active
+# image.
+#
 # For the arguments, see the documentation of BlockdevSnapshot.
 #
 # Since: 2.5
+#
+# Example:
+#
+# -> { "execute": "blockdev-add",
+#      "arguments": { "options": { "driver": "qcow2",
+#                                  "node-name": "node1534",
+#                                  "file": { "driver": "file",
+#                                            "filename": "hd1.qcow2" },
+#                                  "backing": "" } } }
+#
+# <- { "return": {} }
+#
+# -> { "execute": "blockdev-snapshot",
+#      "arguments": { "node": "ide-hd0",
+#                     "overlay": "node1534" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'blockdev-snapshot',
   'data': 'BlockdevSnapshot' }
@@ -1001,7 +1233,9 @@
 # updated.
 #
 # @image-node-name: The name of the block driver state node of the
-#                   image to modify.
+#                   image to modify. The "device" argument is used
+#                   to verify "image-node-name" is in the chain
+#                   described by "device".
 #
 # @device:          The device name or node-name of the root node that o=
wns
 #                   image-node-name.
@@ -1011,6 +1245,10 @@
 #                   when specifying the string or the image chain may
 #                   not be able to be reopened again.
 #
+# Returns: Nothing on success
+#
+#          If "device" does not exist or cannot be determined, DeviceNot=
Found
+#
 # Since: 2.1
 ##
 { 'command': 'change-backing-file',
@@ -1029,7 +1267,7 @@
 # @device:  the device name or node-name of a root node
 #
 # @base:   #optional The file name of the backing image to write data in=
to.
-#                    If not specified, this is the deepest backing image
+#                    If not specified, this is the deepest backing image=
.
 #
 # @top:    #optional The file name of the backing image within the image=
 chain,
 #                    which contains the topmost data to be committed dow=
n. If
@@ -1075,6 +1313,13 @@
 #
 # Since: 1.3
 #
+# Example:
+#
+# -> { "execute": "block-commit",
+#      "arguments": { "device": "virtio0",
+#                     "top": "/tmp/snap1.qcow2" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'block-commit',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str', '*top': '=
str',
@@ -1095,6 +1340,15 @@
 #          If @device is not a valid block device, GenericError
 #
 # Since: 1.6
+#
+# Example:
+#
+# -> { "execute": "drive-backup",
+#      "arguments": { "device": "drive0",
+#                     "sync": "full",
+#                     "target": "backup.img" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'drive-backup', 'boxed': true,
   'data': 'DriveBackup' }
@@ -1114,6 +1368,14 @@
 #          If @device is not a valid block device, DeviceNotFound
 #
 # Since: 2.3
+#
+# Example:
+# -> { "execute": "blockdev-backup",
+#      "arguments": { "device": "src-id",
+#                     "sync": "full",
+#                     "target": "tgt-id" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'blockdev-backup', 'boxed': true,
   'data': 'BlockdevBackup' }
@@ -1127,13 +1389,67 @@
 # Returns: the list of BlockDeviceInfo
 #
 # Since: 2.0
+#
+# Example:
+#
+# -> { "execute": "query-named-block-nodes" }
+# <- { "return": [ { "ro":false,
+#                    "drv":"qcow2",
+#                    "encrypted":false,
+#                    "file":"disks/test.qcow2",
+#                    "node-name": "my-node",
+#                    "backing_file_depth":1,
+#                    "bps":1000000,
+#                    "bps_rd":0,
+#                    "bps_wr":0,
+#                    "iops":1000000,
+#                    "iops_rd":0,
+#                    "iops_wr":0,
+#                    "bps_max": 8000000,
+#                    "bps_rd_max": 0,
+#                    "bps_wr_max": 0,
+#                    "iops_max": 0,
+#                    "iops_rd_max": 0,
+#                    "iops_wr_max": 0,
+#                    "iops_size": 0,
+#                    "write_threshold": 0,
+#                    "image":{
+#                       "filename":"disks/test.qcow2",
+#                       "format":"qcow2",
+#                       "virtual-size":2048000,
+#                       "backing_file":"base.qcow2",
+#                       "full-backing-filename":"disks/base.qcow2",
+#                       "backing-filename-format":"qcow2",
+#                       "snapshots":[
+#                          {
+#                             "id": "1",
+#                             "name": "snapshot1",
+#                             "vm-state-size": 0,
+#                             "date-sec": 10000200,
+#                             "date-nsec": 12,
+#                             "vm-clock-sec": 206,
+#                             "vm-clock-nsec": 30
+#                          }
+#                       ],
+#                       "backing-image":{
+#                           "filename":"disks/base.qcow2",
+#                           "format":"qcow2",
+#                           "virtual-size":2048000
+#                       }
+#                    } } ] }
+#
 ##
 { 'command': 'query-named-block-nodes', 'returns': [ 'BlockDeviceInfo' ]=
 }
=20
 ##
 # @drive-mirror:
 #
-# Start mirroring a block device's writes to a new destination.
+# Start mirroring a block device's writes to a new destination. target
+# specifies the target of the new image. If the file exists, or if it
+# is a device, it will be used as the new destination for writes. If
+# it does not exist, a new file will be created. format specifies the
+# format of the mirror image, default is to probe if mode=3D'existing',
+# else the format of the source.
 #
 # See DriveMirror for parameter descriptions
 #
@@ -1141,6 +1457,16 @@
 #          If @device is not a valid block device, GenericError
 #
 # Since: 1.3
+#
+# Example:
+#
+# -> { "execute": "drive-mirror",
+#      "arguments": { "device": "ide-hd0",
+#                     "target": "/some/place/my-image",
+#                     "sync": "full",
+#                     "format": "qcow2" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'drive-mirror', 'boxed': true,
   'data': 'DriveMirror' }
@@ -1241,13 +1567,20 @@
 ##
 # @block-dirty-bitmap-add:
 #
-# Create a dirty bitmap with a name on the node
+# Create a dirty bitmap with a name on the node, and start tracking the =
writes.
 #
 # Returns: nothing on success
 #          If @node is not a valid block device or node, DeviceNotFound
 #          If @name is already taken, GenericError with an explanation
 #
 # Since: 2.4
+#
+# Example:
+#
+# -> { "execute": "block-dirty-bitmap-add",
+#      "arguments": { "node": "drive0", "name": "bitmap0" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'block-dirty-bitmap-add',
   'data': 'BlockDirtyBitmapAdd' }
@@ -1255,7 +1588,8 @@
 ##
 # @block-dirty-bitmap-remove:
 #
-# Remove a dirty bitmap on the node
+# Stop write tracking and remove the dirty bitmap that was created
+# with block-dirty-bitmap-add.
 #
 # Returns: nothing on success
 #          If @node is not a valid block device or node, DeviceNotFound
@@ -1263,6 +1597,13 @@
 #          if @name is frozen by an operation, GenericError
 #
 # Since: 2.4
+#
+# Example:
+#
+# -> { "execute": "block-dirty-bitmap-remove",
+#      "arguments": { "node": "drive0", "name": "bitmap0" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'block-dirty-bitmap-remove',
   'data': 'BlockDirtyBitmap' }
@@ -1270,13 +1611,22 @@
 ##
 # @block-dirty-bitmap-clear:
 #
-# Clear (reset) a dirty bitmap on the device
+# Clear (reset) a dirty bitmap on the device, so that an incremental
+# backup from this point in time forward will only backup clusters
+# modified after this clear operation.
 #
 # Returns: nothing on success
 #          If @node is not a valid block device, DeviceNotFound
 #          If @name is not found, GenericError with an explanation
 #
 # Since: 2.4
+#
+# Example:
+#
+# -> { "execute": "block-dirty-bitmap-clear",
+#      "arguments": { "node": "drive0", "name": "bitmap0" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'block-dirty-bitmap-clear',
   'data': 'BlockDirtyBitmap' }
@@ -1324,6 +1674,15 @@
 # Returns: nothing on success.
 #
 # Since: 2.6
+#
+# Example:
+#
+# -> { "execute": "blockdev-mirror",
+#      "arguments": { "device": "ide-hd0",
+#                     "target": "target0",
+#                     "sync": "full" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'blockdev-mirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
@@ -1365,6 +1724,26 @@
 #          If @device is not a valid block device, DeviceNotFound
 #
 # Since: 1.1
+#
+# Example:
+#
+# -> { "execute": "block_set_io_throttle",
+#      "arguments": { "id": "ide0-1-0",
+#                     "bps": 1000000,
+#                     "bps_rd": 0,
+#                     "bps_wr": 0,
+#                     "iops": 0,
+#                     "iops_rd": 0,
+#                     "iops_wr": 0,
+#                     "bps_max": 8000000,
+#                     "bps_rd_max": 0,
+#                     "bps_wr_max": 0,
+#                     "iops_max": 0,
+#                     "iops_rd_max": 0,
+#                     "iops_wr_max": 0,
+#                     "bps_max_length": 60,
+#                     "iops_size": 0 } }
+# <- { "return": {} }
 ##
 { 'command': 'block_set_io_throttle', 'boxed': true,
   'data': 'BlockIOThrottle' }
@@ -1513,7 +1892,17 @@
 #            'stop' and 'enospc' can only be used if the block device
 #            supports io-status (see BlockInfo).  Since 1.3.
 #
+# Returns: Nothing on success. If @device does not exist, DeviceNotFound=
.
+#
 # Since: 1.1
+#
+# Example:
+#
+# -> { "execute": "block-stream",
+#      "arguments": { "device": "virtio0",
+#                     "base": "/tmp/master.qcow2" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
@@ -2450,6 +2839,45 @@
 # to help with its development.
 #
 # Since: 1.7
+#
+# Example:
+#
+# 1.
+# -> { "execute": "blockdev-add",
+#      "arguments": {
+#          "options" : { "driver": "qcow2",
+#                        "file": { "driver": "file",
+#                                  "filename": "test.qcow2" } } } }
+# <- { "return": {} }
+#
+# 2.
+# -> { "execute": "blockdev-add",
+#      "arguments": {
+#          "options": {
+#            "driver": "qcow2",
+#            "node-name": "node0",
+#            "discard": "unmap",
+#            "cache": {
+#                "direct": true,
+#                "writeback": true
+#            },
+#            "file": {
+#                "driver": "file",
+#                "filename": "/tmp/test.qcow2"
+#            },
+#            "backing": {
+#                "driver": "raw",
+#                "file": {
+#                    "driver": "file",
+#                    "filename": "/dev/fdset/4"
+#                }
+#            }
+#          }
+#        }
+#      }
+#
+# <- { "return": {} }
+#
 ##
 { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true }
=20
@@ -2467,6 +2895,28 @@
 # development.
 #
 # Since: 2.5
+#
+# Example:
+#
+# -> { "execute": "blockdev-add",
+#      "arguments": {
+#          "options": {
+#              "driver": "qcow2",
+#              "node-name": "node0",
+#              "file": {
+#                  "driver": "file",
+#                  "filename": "test.qcow2"
+#              }
+#          }
+#      }
+#    }
+# <- { "return": {} }
+#
+# -> { "execute": "x-blockdev-del",
+#      "arguments": { "node-name": "node0" }
+#    }
+# <- { "return": {} }
+#
 ##
 { 'command': 'x-blockdev-del', 'data': { 'node-name': 'str' } }
=20
@@ -2498,6 +2948,21 @@
 #          it is locked
 #
 # Since: 2.5
+#
+# Example:
+#
+# -> { "execute": "blockdev-open-tray",
+#      "arguments": { "id": "ide0-1-0" } }
+#
+# <- { "timestamp": { "seconds": 1418751016,
+#                     "microseconds": 716996 },
+#      "event": "DEVICE_TRAY_MOVED",
+#      "data": { "device": "ide1-cd0",
+#                "id": "ide0-1-0",
+#                "tray-open": true } }
+#
+# <- { "return": {} }
+#
 ##
 { 'command': 'blockdev-open-tray',
   'data': { '*device': 'str',
@@ -2518,6 +2983,21 @@
 # @id:      #optional The name or QOM path of the guest device (since: 2=
.8)
 #
 # Since: 2.5
+#
+# Example:
+#
+# -> { "execute": "blockdev-close-tray",
+#      "arguments": { "id": "ide0-1-0" } }
+#
+# <- { "timestamp": { "seconds": 1418751345,
+#                     "microseconds": 272147 },
+#      "event": "DEVICE_TRAY_MOVED",
+#      "data": { "device": "ide1-cd0",
+#                "id": "ide0-1-0",
+#                "tray-open": false } }
+#
+# <- { "return": {} }
+#
 ##
 { 'command': 'blockdev-close-tray',
   'data': { '*device': 'str',
@@ -2540,6 +3020,32 @@
 # Stay away from it unless you want to help with its development.
 #
 # Since: 2.5
+#
+# Example:
+#
+# -> { "execute": "x-blockdev-remove-medium",
+#      "arguments": { "id": "ide0-1-0" } }
+#
+# <- { "error": { "class": "GenericError",
+#                 "desc": "Tray of device 'ide0-1-0' is not open" } }
+#
+# -> { "execute": "blockdev-open-tray",
+#      "arguments": { "id": "ide0-1-0" } }
+#
+# <- { "timestamp": { "seconds": 1418751627,
+#                     "microseconds": 549958 },
+#      "event": "DEVICE_TRAY_MOVED",
+#      "data": { "device": "ide1-cd0",
+#                "id": "ide0-1-0",
+#                "tray-open": true } }
+#
+# <- { "return": {} }
+#
+# -> { "execute": "x-blockdev-remove-medium",
+#      "arguments": { "device": "ide0-1-0" } }
+#
+# <- { "return": {} }
+#
 ##
 { 'command': 'x-blockdev-remove-medium',
   'data': { '*device': 'str',
@@ -2562,6 +3068,23 @@
 # Stay away from it unless you want to help with its development.
 #
 # Since: 2.5
+#
+# Example:
+#
+# -> { "execute": "blockdev-add",
+#      "arguments": {
+#          "options": { "node-name": "node0",
+#                       "driver": "raw",
+#                       "file": { "driver": "file",
+#                                 "filename": "fedora.iso" } } } }
+# <- { "return": {} }
+#
+# -> { "execute": "x-blockdev-insert-medium",
+#      "arguments": { "id": "ide0-1-0",
+#                     "node-name": "node0" } }
+#
+# <- { "return": {} }
+#
 ##
 { 'command': 'x-blockdev-insert-medium',
   'data': { '*device': 'str',
@@ -2582,6 +3105,7 @@
 # @read-write:  Makes the device writable
 #
 # Since: 2.3
+#
 ##
 { 'enum': 'BlockdevChangeReadOnlyMode',
   'data': ['retain', 'read-only', 'read-write'] }
@@ -2609,6 +3133,37 @@
 #                   to 'retain'
 #
 # Since: 2.5
+#
+# Examples:
+#
+# 1. Change a removable medium
+#
+# -> { "execute": "blockdev-change-medium",
+#      "arguments": { "id": "ide0-1-0",
+#                     "filename": "/srv/images/Fedora-12-x86_64-DVD.iso"=
,
+#                     "format": "raw" } }
+# <- { "return": {} }
+#
+# 2. Load a read-only medium into a writable drive
+#
+# -> { "execute": "blockdev-change-medium",
+#      "arguments": { "id": "floppyA",
+#                     "filename": "/srv/images/ro.img",
+#                     "format": "raw",
+#                     "read-only-mode": "retain" } }
+#
+# <- { "error":
+#      { "class": "GenericError",
+#        "desc": "Could not open '/srv/images/ro.img': Permission denied=
" } }
+#
+# -> { "execute": "blockdev-change-medium",
+#      "arguments": { "id": "floppyA",
+#                     "filename": "/srv/images/ro.img",
+#                     "format": "raw",
+#                     "read-only-mode": "read-only" } }
+#
+# <- { "return": {} }
+#
 ##
 { 'command': 'blockdev-change-medium',
   'data': { '*device': 'str',
@@ -2638,7 +3193,10 @@
 ##
 # @BLOCK_IMAGE_CORRUPTED:
 #
-# Emitted when a corruption has been detected in a disk image
+# Emitted when a disk image is being marked corrupt. The image can be
+# identified by its device or node name. The 'device' field is always
+# present for compatibility reasons, but it can be empty ("") if the
+# image does not have a device name associated.
 #
 # @device: device name. This is always present for compatibility
 #          reasons, but it can be empty ("") if the image does not
@@ -2656,10 +3214,21 @@
 # @size: #optional, if the corruption resulted from an image access, thi=
s is
 #        the access size
 #
-# fatal: if set, the image is marked corrupt and therefore unusable afte=
r this
+# @fatal: if set, the image is marked corrupt and therefore unusable aft=
er this
 #        event and must be repaired (Since 2.2; before, every
 #        BLOCK_IMAGE_CORRUPTED event was fatal)
 #
+# Note: If action is "stop", a STOP event will eventually follow the
+#       BLOCK_IO_ERROR event.
+#
+# Example:
+#
+# <- { "event": "BLOCK_IMAGE_CORRUPTED",
+#      "data": { "device": "ide0-hd0", "node-name": "node0",
+#                "msg": "Prevented active L1 table overwrite", "offset":=
 196608,
+#                "size": 65536 },
+#      "timestamp": { "seconds": 1378126126, "microseconds": 966463 } }
+#
 # Since: 1.7
 ##
 { 'event': 'BLOCK_IMAGE_CORRUPTED',
@@ -2700,6 +3269,16 @@
 # BLOCK_IO_ERROR event
 #
 # Since: 0.13.0
+#
+# Example:
+#
+# <- { "event": "BLOCK_IO_ERROR",
+#      "data": { "device": "ide0-hd1",
+#                "node-name": "#block212",
+#                "operation": "write",
+#                "action": "stop" },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
 ##
 { 'event': 'BLOCK_IO_ERROR',
   'data': { 'device': 'str', 'node-name': 'str', 'operation': 'IoOperati=
onType',
@@ -2729,6 +3308,15 @@
 #         interpret the error string
 #
 # Since: 1.1
+#
+# Example:
+#
+# <- { "event": "BLOCK_JOB_COMPLETED",
+#      "data": { "type": "stream", "device": "virtio-disk0",
+#                "len": 10737418240, "offset": 10737418240,
+#                "speed": 0 },
+#      "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#
 ##
 { 'event': 'BLOCK_JOB_COMPLETED',
   'data': { 'type'  : 'BlockJobType',
@@ -2756,6 +3344,15 @@
 # @speed: rate limit, bytes per second
 #
 # Since: 1.1
+#
+# Example:
+#
+# <- { "event": "BLOCK_JOB_CANCELLED",
+#      "data": { "type": "stream", "device": "virtio-disk0",
+#                "len": 10737418240, "offset": 134217728,
+#                "speed": 0 },
+#      "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#
 ##
 { 'event': 'BLOCK_JOB_CANCELLED',
   'data': { 'type'  : 'BlockJobType',
@@ -2777,6 +3374,15 @@
 # @action: action that has been taken
 #
 # Since: 1.3
+#
+# Example:
+#
+# <- { "event": "BLOCK_JOB_ERROR",
+#      "data": { "device": "ide0-hd1",
+#                "operation": "write",
+#                "action": "stop" },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
 ##
 { 'event': 'BLOCK_JOB_ERROR',
   'data': { 'device'   : 'str',
@@ -2804,6 +3410,14 @@
 # event
 #
 # Since: 1.3
+#
+# Example:
+#
+# <- { "event": "BLOCK_JOB_READY",
+#      "data": { "device": "drive0", "type": "mirror", "speed": 0,
+#                "len": 2097152, "offset": 2097152 }
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
 ##
 { 'event': 'BLOCK_JOB_READY',
   'data': { 'type'  : 'BlockJobType',
@@ -2856,8 +3470,12 @@
 ##
 # @block-set-write-threshold:
 #
-# Change the write threshold for a block drive. An event will be deliver=
ed
-# if a write to this block drive crosses the configured threshold.
+# Change the write threshold for a block drive. An event will be
+# delivered if a write to this block drive crosses the configured
+# threshold.  The threshold is an offset, thus must be
+# non-negative. Default is no write threshold. Setting the threshold
+# to zero disables it.
+#
 # This is useful to transparently resize thin-provisioned drives without
 # the guest OS noticing.
 #
@@ -2867,6 +3485,14 @@
 #                   Use 0 to disable the threshold.
 #
 # Since: 2.3
+#
+# Example:
+#
+# -> { "execute": "block-set-write-threshold",
+#      "arguments": { "node-name": "mydev",
+#                     "write-threshold": 17179869184 } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'block-set-write-threshold',
   'data': { 'node-name': 'str', 'write-threshold': 'uint64' } }
@@ -2897,6 +3523,28 @@
 # the rest of the array.
 #
 # Since: 2.7
+#
+# Example:
+#
+# 1. Add a new node to a quorum
+# -> { "execute": "blockdev-add",
+#      "arguments": {
+#          "options": { "driver": "raw",
+#                       "node-name": "new_node",
+#                        "file": { "driver": "file",
+#                                  "filename": "test.raw" } } } }
+# <- { "return": {} }
+# -> { "execute": "x-blockdev-change",
+#      "arguments": { "parent": "disk1",
+#                     "node": "new_node" } }
+# <- { "return": {} }
+#
+# 2. Delete a quorum's node
+# -> { "execute": "x-blockdev-change",
+#      "arguments": { "parent": "disk1",
+#                     "child": "children.1" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'x-blockdev-change',
   'data' : { 'parent': 'str',
diff --git a/qapi/block.json b/qapi/block.json
index 693e234779..22da91441b 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -81,19 +81,33 @@
 ##
 # @blockdev-snapshot-internal-sync:
 #
-# Synchronously take an internal snapshot of a block device, when the fo=
rmat
-# of the image used supports it.
+# Synchronously take an internal snapshot of a block device, when the
+# format of the image used supports it. If the name is an empty
+# string, or a snapshot with name already exists, the operation will
+# fail.
 #
 # For the arguments, see the documentation of BlockdevSnapshotInternal.
 #
 # Returns: nothing on success
+#
 #          If @device is not a valid block device, GenericError
+#
 #          If any snapshot matching @name exists, or @name is empty,
 #          GenericError
+#
 #          If the format of the image used does not support it,
 #          BlockFormatFeatureNotSupported
 #
 # Since: 1.7
+#
+# Example:
+#
+# -> { "execute": "blockdev-snapshot-internal-sync",
+#      "arguments": { "device": "ide-hd0",
+#                     "name": "snapshot0" }
+#    }
+# <- { "return": {} }
+#
 ##
 { 'command': 'blockdev-snapshot-internal-sync',
   'data': 'BlockdevSnapshotInternal' }
@@ -121,6 +135,24 @@
 #          If @id and @name are both not specified, GenericError
 #
 # Since: 1.7
+#
+# Example:
+#
+# -> { "execute": "blockdev-snapshot-delete-internal-sync",
+#      "arguments": { "device": "ide-hd0",
+#                     "name": "snapshot0" }
+#    }
+# <- { "return": {
+#                    "id": "1",
+#                    "name": "snapshot0",
+#                    "vm-state-size": 0,
+#                    "date-sec": 1000012,
+#                    "date-nsec": 10,
+#                    "vm-clock-sec": 100,
+#                    "vm-clock-nsec": 20
+#      }
+#    }
+#
 ##
 { 'command': 'blockdev-snapshot-delete-internal-sync',
   'data': { 'device': 'str', '*id': 'str', '*name': 'str'},
@@ -135,15 +167,21 @@
 #
 # @id:      #optional The name or QOM path of the guest device (since: 2=
.8)
 #
-# @force:   @optional If true, eject regardless of whether the drive is =
locked.
+# @force:   #optional If true, eject regardless of whether the drive is =
locked.
 #           If not specified, the default value is false.
 #
 # Returns:  Nothing on success
+#
 #           If @device is not a valid block device, DeviceNotFound
 #
-# Notes:    Ejecting a device will no media results in success
+# Notes:    Ejecting a device with no media results in success
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "eject", "arguments": { "device": "ide1-0-1" } }
+# <- { "return": {} }
 ##
 { 'command': 'eject',
   'data': { '*device': 'str',
@@ -210,6 +248,16 @@
 # @tray-open: true if the tray has been opened or false if it has been c=
losed
 #
 # Since: 1.1
+#
+# Example:
+#
+# <- { "event": "DEVICE_TRAY_MOVED",
+#      "data": { "device": "ide1-cd0",
+#                "id": "/machine/unattached/device[22]",
+#                "tray-open": true
+#      },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
 ##
 { 'event': 'DEVICE_TRAY_MOVED',
   'data': { 'device': 'str', 'id': 'str', 'tray-open': 'bool' } }
diff --git a/qapi/common.json b/qapi/common.json
index d93f159946..b626647b2f 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -77,6 +77,21 @@
 # Returns:  A @VersionInfo object describing the current version of QEMU=
.
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-version" }
+# <- {
+#       "return":{
+#          "qemu":{
+#             "major":0,
+#             "minor":11,
+#             "micro":5
+#          },
+#          "package":""
+#       }
+#    }
+#
 ##
 { 'command': 'query-version', 'returns': 'VersionInfo' }
=20
@@ -99,6 +114,23 @@
 # Returns: A list of @CommandInfo for all supported commands
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-commands" }
+# <- {
+#      "return":[
+#         {
+#            "name":"query-balloon"
+#         },
+#         {
+#            "name":"system_powerdown"
+#         }
+#      ]
+#    }
+#
+# Note: This example has been shortened as the real response is too long=
.
+#
 ##
 { 'command': 'query-commands', 'returns': ['CommandInfo'] }
=20
diff --git a/qapi/event.json b/qapi/event.json
index 0cd4b79ad8..f3737b771f 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -14,6 +14,12 @@
 # not exit, and a STOP event will eventually follow the SHUTDOWN event
 #
 # Since: 0.12.0
+#
+# Example:
+#
+# <- { "event": "SHUTDOWN",
+#      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#
 ##
 { 'event': 'SHUTDOWN' }
=20
@@ -24,6 +30,12 @@
 # system, such as via ACPI.
 #
 # Since: 0.12.0
+#
+# Example:
+#
+# <- { "event": "POWERDOWN",
+#      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#
 ##
 { 'event': 'POWERDOWN' }
=20
@@ -33,6 +45,12 @@
 # Emitted when the virtual machine is reset
 #
 # Since: 0.12.0
+#
+# Example:
+#
+# <- { "event": "RESET",
+#      "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
+#
 ##
 { 'event': 'RESET' }
=20
@@ -42,6 +60,12 @@
 # Emitted when the virtual machine is stopped
 #
 # Since: 0.12.0
+#
+# Example:
+#
+# <- { "event": "STOP",
+#      "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
+#
 ##
 { 'event': 'STOP' }
=20
@@ -51,6 +75,12 @@
 # Emitted when the virtual machine resumes execution
 #
 # Since: 0.12.0
+#
+# Example:
+#
+# <- { "event": "RESUME",
+#      "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
+#
 ##
 { 'event': 'RESUME' }
=20
@@ -61,6 +91,12 @@
 # which is sometimes called standby state
 #
 # Since: 1.1
+#
+# Example:
+#
+# <- { "event": "SUSPEND",
+#      "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
+#
 ##
 { 'event': 'SUSPEND' }
=20
@@ -73,6 +109,12 @@
 # Note: QEMU shuts down (similar to event @SHUTDOWN) when entering this =
state
 #
 # Since: 1.2
+#
+# Example:
+#
+# <-   { "event": "SUSPEND_DISK",
+#        "timestamp": { "seconds": 1344456160, "microseconds": 309119 } =
}
+#
 ##
 { 'event': 'SUSPEND_DISK' }
=20
@@ -82,6 +124,12 @@
 # Emitted when the guest has woken up from suspend state and is running
 #
 # Since: 1.1
+#
+# Example:
+#
+# <- { "event": "WAKEUP",
+#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#
 ##
 { 'event': 'WAKEUP' }
=20
@@ -93,7 +141,16 @@
 # @offset: offset between base RTC clock (as specified by -rtc base), an=
d
 #          new RTC clock value
 #
+# Note: This event is rate-limited.
+#
 # Since: 0.13.0
+#
+# Example:
+#
+# <-   { "event": "RTC_CHANGE",
+#        "data": { "offset": 78 },
+#        "timestamp": { "seconds": 1267020223, "microseconds": 435656 } =
}
+#
 ##
 { 'event': 'RTC_CHANGE',
   'data': { 'offset': 'int' } }
@@ -108,7 +165,16 @@
 # Note: If action is "reset", "shutdown", or "pause" the WATCHDOG event =
is
 # followed respectively by the RESET, SHUTDOWN, or STOP events
 #
+# Note: This event is rate-limited.
+#
 # Since: 0.13.0
+#
+# Example:
+#
+# <- { "event": "WATCHDOG",
+#      "data": { "action": "reset" },
+#      "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#
 ##
 { 'event': 'WATCHDOG',
   'data': { 'action': 'WatchdogExpirationAction' } }
@@ -125,6 +191,14 @@
 # @path: device path
 #
 # Since: 1.5
+#
+# Example:
+#
+# <- { "event": "DEVICE_DELETED",
+#      "data": { "device": "virtio-net-pci-0",
+#                "path": "/machine/peripheral/virtio-net-pci-0" },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
 ##
 { 'event': 'DEVICE_DELETED',
   'data': { '*device': 'str', 'path': 'str' } }
@@ -140,6 +214,15 @@
 # @path: device path
 #
 # Since: 1.6
+#
+# Example:
+#
+# <- { "event": "NIC_RX_FILTER_CHANGED",
+#      "data": { "name": "vnet0",
+#                "path": "/machine/peripheral/vnet0/virtio-backend" },
+#      "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
+#    }
+#
 ##
 { 'event': 'NIC_RX_FILTER_CHANGED',
   'data': { '*name': 'str', 'path': 'str' } }
@@ -157,6 +240,17 @@
 # the authentication ID is not provided
 #
 # Since: 0.13.0
+#
+# Example:
+#
+# <- { "event": "VNC_CONNECTED",
+#      "data": {
+#            "server": { "auth": "sasl", "family": "ipv4",
+#                        "service": "5901", "host": "0.0.0.0" },
+#            "client": { "family": "ipv4", "service": "58425",
+#                        "host": "127.0.0.1" } },
+#      "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#
 ##
 { 'event': 'VNC_CONNECTED',
   'data': { 'server': 'VncServerInfo',
@@ -173,6 +267,17 @@
 # @client: client information
 #
 # Since: 0.13.0
+#
+# Example:
+#
+# <-  { "event": "VNC_INITIALIZED",
+#       "data": {
+#            "server": { "auth": "sasl", "family": "ipv4",
+#                        "service": "5901", "host": "0.0.0.0"},
+#            "client": { "family": "ipv4", "service": "46089",
+#                        "host": "127.0.0.1", "sasl_username": "luiz" } =
},
+#       "timestamp": { "seconds": 1263475302, "microseconds": 150772 } }
+#
 ##
 { 'event': 'VNC_INITIALIZED',
   'data': { 'server': 'VncServerInfo',
@@ -188,6 +293,17 @@
 # @client: client information
 #
 # Since: 0.13.0
+#
+# Example:
+#
+# <- { "event": "VNC_DISCONNECTED",
+#      "data": {
+#            "server": { "auth": "sasl", "family": "ipv4",
+#                        "service": "5901", "host": "0.0.0.0" },
+#            "client": { "family": "ipv4", "service": "58425",
+#                        "host": "127.0.0.1", "sasl_username": "luiz" } =
},
+#      "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#
 ##
 { 'event': 'VNC_DISCONNECTED',
   'data': { 'server': 'VncServerInfo',
@@ -203,6 +319,16 @@
 # @client: client information
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
+#      "event": "SPICE_CONNECTED",
+#      "data": {
+#        "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.=
1"},
+#        "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.=
1"}
+#    }}
+#
 ##
 { 'event': 'SPICE_CONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
@@ -219,6 +345,18 @@
 # @client: client information
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
+#      "event": "SPICE_INITIALIZED",
+#      "data": {"server": {"auth": "spice", "port": "5921",
+#                          "family": "ipv4", "host": "127.0.0.1"},
+#               "client": {"port": "49004", "family": "ipv4", "channel-t=
ype": 3,
+#                          "connection-id": 1804289383, "host": "127.0.0=
.1",
+#                          "channel-id": 0, "tls": true}
+#    }}
+#
 ##
 { 'event': 'SPICE_INITIALIZED',
   'data': { 'server': 'SpiceServerInfo',
@@ -234,6 +372,16 @@
 # @client: client information
 #
 # Since: 0.14.0
+#
+# Example:
+#
+# <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
+#      "event": "SPICE_DISCONNECTED",
+#      "data": {
+#        "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.=
1"},
+#        "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.=
1"}
+#    }}
+#
 ##
 { 'event': 'SPICE_DISCONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
@@ -245,6 +393,12 @@
 # Emitted when SPICE migration has completed
 #
 # Since: 1.3
+#
+# Example:
+#
+# <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
+#      "event": "SPICE_MIGRATE_COMPLETED" }
+#
 ##
 { 'event': 'SPICE_MIGRATE_COMPLETED' }
=20
@@ -256,6 +410,13 @@
 # @status: @MigrationStatus describing the current migration status.
 #
 # Since: 2.4
+#
+# Example:
+#
+# <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
+#     "event": "MIGRATION",
+#     "data": {"status": "completed"} }
+#
 ##
 { 'event': 'MIGRATION',
   'data': {'status': 'MigrationStatus'}}
@@ -269,6 +430,12 @@
 # @pass: An incrementing count (starting at 1 on the first pass)
 #
 # Since: 2.6
+#
+# Example:
+#
+# { "timestamp": {"seconds": 1449669631, "microseconds": 239225},
+#   "event": "MIGRATION_PASS", "data": {"pass": 2} }
+#
 ##
 { 'event': 'MIGRATION_PASS',
   'data': { 'pass': 'int' } }
@@ -281,6 +448,13 @@
 # @info: ACPIOSTInfo type as described in qapi-schema.json
 #
 # Since: 2.1
+#
+# Example:
+#
+# <- { "event": "ACPI_DEVICE_OST",
+#      "data": { "device": "d1", "slot": "0",
+#                "slot-type": "DIMM", "source": 1, "status": 0 } }
+#
 ##
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
@@ -293,7 +467,16 @@
 #
 # @actual: actual level of the guest memory balloon in bytes
 #
+# Note: this event is rate-limited.
+#
 # Since: 1.2
+#
+# Example:
+#
+# <- { "event": "BALLOON_CHANGE",
+#      "data": { "actual": 944766976 },
+#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
+#
 ##
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
@@ -306,6 +489,12 @@
 # @action: action that has been taken, currently always "pause"
 #
 # Since: 1.5
+#
+# Example:
+#
+# <- { "event": "GUEST_PANICKED",
+#      "data": { "action": "pause" } }
+#
 ##
 { 'event': 'GUEST_PANICKED',
   'data': { 'action': 'GuestPanicAction' } }
@@ -321,7 +510,16 @@
 #
 # @sectors-count: failed read operation sector count
 #
+# Note: This event is rate-limited.
+#
 # Since: 2.0
+#
+# Example:
+#
+# <- { "event": "QUORUM_FAILURE",
+#      "data": { "reference": "usr1", "sector-num": 345435, "sectors-cou=
nt": 5 },
+#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#
 ##
 { 'event': 'QUORUM_FAILURE',
   'data': { 'reference': 'str', 'sector-num': 'int', 'sectors-count': 'i=
nt' } }
@@ -344,7 +542,26 @@
 #
 # @sectors-count: failed read operation sector count
 #
+# Note: This event is rate-limited.
+#
 # Since: 2.0
+#
+# Example:
+#
+# 1. Read operation
+#
+# { "event": "QUORUM_REPORT_BAD",
+#      "data": { "node-name": "node0", "sector-num": 345435, "sectors-co=
unt": 5,
+#                "type": "read" },
+#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#
+# 2. Flush operation
+#
+# { "event": "QUORUM_REPORT_BAD",
+#      "data": { "node-name": "node0", "sector-num": 0, "sectors-count":=
 2097120,
+#                "type": "flush", "error": "Broken pipe" },
+#      "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
+#
 ##
 { 'event': 'QUORUM_REPORT_BAD',
   'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
@@ -360,6 +577,13 @@
 # @open: true if the guest has opened the virtio-serial port
 #
 # Since: 2.1
+#
+# Example:
+#
+# <- { "event": "VSERPORT_CHANGE",
+#      "data": { "id": "channel0", "open": true },
+#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#
 ##
 { 'event': 'VSERPORT_CHANGE',
   'data': { 'id': 'str', 'open': 'bool' } }
@@ -374,6 +598,15 @@
 # @msg: Informative message
 #
 # Since: 2.4
+#
+# Example:
+#
+# <- { "event": "MEM_UNPLUG_ERROR"
+#      "data": { "device": "dimm1",
+#                "msg": "acpi: device unplug for unsupported device"
+#      },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
 ##
 { 'event': 'MEM_UNPLUG_ERROR',
   'data': { 'device': 'str', 'msg': 'str' } }
@@ -390,6 +623,13 @@
 #         user should not try to interpret the error string.
 #
 # Since: 2.6
+#
+# Example:
+#
+# { "event": "DUMP_COMPLETED",
+#   "data": {"result": {"total": 1090650112, "status": "completed",
+#                       "completed": 1090650112} } }
+#
 ##
 { 'event': 'DUMP_COMPLETED' ,
   'data': { 'result': 'DumpQueryResult', '*error': 'str' } }
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 1e511cd37a..97e2b8376f 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -26,6 +26,12 @@
 # Returns: @Rocker information
 #
 # Since: 2.4
+#
+# Example:
+#
+# -> { "execute": "query-rocker", "arguments": { "name": "sw1" } }
+# <- { "return": {"name": "sw1", "ports": 2, "id": 1327446905938}}
+#
 ##
 { 'command': 'query-rocker',
   'data': { 'name': 'str' },
@@ -84,11 +90,21 @@
 ##
 # @query-rocker-ports:
 #
-# Return rocker switch information.
+# Return rocker switch port information.
 #
-# Returns: @Rocker information
+# Returns: a list of @RockerPort information
 #
 # Since: 2.4
+#
+# Example:
+#
+# -> { "execute": "query-rocker-ports", "arguments": { "name": "sw1" } }
+# <- { "return": [ {"duplex": "full", "enabled": true, "name": "sw1.1",
+#                   "autoneg": "off", "link-up": true, "speed": 10000},
+#                  {"duplex": "full", "enabled": true, "name": "sw1.2",
+#                   "autoneg": "off", "link-up": true, "speed": 10000}
+#    ]}
+#
 ##
 { 'command': 'query-rocker-ports',
   'data': { 'name': 'str' },
@@ -219,9 +235,23 @@
 # @tbl-id: #optional flow table ID.  If tbl-id is not specified, returns
 # flow information for all tables.
 #
-# Returns: @Rocker OF-DPA flow information
+# Returns: rocker OF-DPA flow information
 #
 # Since: 2.4
+#
+# Example:
+#
+# -> { "execute": "query-rocker-of-dpa-flows",
+#      "arguments": { "name": "sw1" } }
+# <- { "return": [ {"key": {"in-pport": 0, "priority": 1, "tbl-id": 0},
+#                   "hits": 138,
+#                   "cookie": 0,
+#                   "action": {"goto-tbl": 10},
+#                   "mask": {"in-pport": 4294901760}
+#                  },
+#                  {...more...},
+#    ]}
+#
 ##
 { 'command': 'query-rocker-of-dpa-flows',
   'data': { 'name': 'str', '*tbl-id': 'uint32' },
@@ -281,9 +311,28 @@
 # @type: #optional group type.  If type is not specified, returns
 # group information for all group types.
 #
-# Returns: @Rocker OF-DPA group information
+# Returns: rocker OF-DPA group information
 #
 # Since: 2.4
+#
+# Example:
+#
+# -> { "execute": "query-rocker-of-dpa-groups",
+#      "arguments": { "name": "sw1" } }
+# <- { "return": [ {"type": 0, "out-pport": 2,
+#                   "pport": 2, "vlan-id": 3841,
+#                   "pop-vlan": 1, "id": 251723778},
+#                  {"type": 0, "out-pport": 0,
+#                   "pport": 0, "vlan-id": 3841,
+#                   "pop-vlan": 1, "id": 251723776},
+#                  {"type": 0, "out-pport": 1,
+#                   "pport": 1, "vlan-id": 3840,
+#                   "pop-vlan": 1, "id": 251658241},
+#                  {"type": 0, "out-pport": 0,
+#                   "pport": 0, "vlan-id": 3840,
+#                   "pop-vlan": 1, "id": 251658240}
+#    ]}
+#
 ##
 { 'command': 'query-rocker-of-dpa-groups',
   'data': { 'name': 'str', '*type': 'uint8' },
diff --git a/qapi/trace.json b/qapi/trace.json
index 3ad7df7fdb..2bfda7ac7c 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -62,6 +62,13 @@
 # an error is returned.
 #
 # Since: 2.2
+#
+# Example:
+#
+# -> { "execute": "trace-event-get-state",
+#      "arguments": { "name": "qemu_memalign" } }
+# <- { "return": [ { "name": "qemu_memalign", "state": "disabled" } ] }
+#
 ##
 { 'command': 'trace-event-get-state',
   'data': {'name': 'str', '*vcpu': 'int'},
@@ -87,6 +94,13 @@
 # error is returned.
 #
 # Since: 2.2
+#
+# Example:
+#
+# -> { "execute": "trace-event-set-state",
+#      "arguments": { "name": "qemu_memalign", "enable": "true" } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'trace-event-set-state',
   'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool=
',
diff --git a/Makefile b/Makefile
index 1a8bfb225c..360a6a24a2 100644
--- a/Makefile
+++ b/Makefile
@@ -429,7 +429,6 @@ endif
 install-doc: $(DOCS)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) $(SRC_PATH)/docs/qmp-commands.txt "$(DESTDIR)$(qemu_doc=
dir)"
 ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
deleted file mode 100644
index abf210a596..0000000000
--- a/docs/qmp-commands.txt
+++ /dev/null
@@ -1,3824 +0,0 @@
-                        QMP Supported Commands
-                        ----------------------
-
-This document describes all commands currently supported by QMP.
-
-Most of the time their usage is exactly the same as in the user Monitor,=
 this
-means that any other document which also describe commands (the manpage,
-QEMU's manual, etc) can and should be consulted.
-
-QMP has two types of commands: regular and query commands. Regular comma=
nds
-usually change the Virtual Machine's state someway, while query commands=
 just
-return information. The sections below are divided accordingly.
-
-It's important to observe that all communication examples are formatted =
in
-a reader-friendly way, so that they're easier to understand. However, in=
 real
-protocol usage, they're emitted as a single line.
-
-Also, the following notation is used to denote data flow:
-
--> data issued by the Client
-<- Server data response
-
-Please, refer to the QMP specification (docs/qmp-spec.txt) for detailed
-information on the Server command and response formats.
-
-NOTE: This document is temporary and will be replaced soon.
-
-1. Stability Considerations
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
-
-The current QMP command set (described in this file) may be useful for a
-number of use cases, however it's limited and several commands have bad
-defined semantics, specially with regard to command completion.
-
-These problems are going to be solved incrementally in the next QEMU rel=
eases
-and we're going to establish a deprecation policy for badly defined comm=
ands.
-
-If you're planning to adopt QMP, please observe the following:
-
-    1. The deprecation policy will take effect and be documented soon, p=
lease
-       check the documentation of each used command as soon as a new rel=
ease of
-       QEMU is available
-
-    2. DO NOT rely on anything which is not explicit documented
-
-    3. Errors, in special, are not documented. Applications should NOT c=
heck
-       for specific errors classes or data (it's strongly recommended to=
 only
-       check for the "error" key)
-
-2. Regular Commands
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Server's responses in the examples below are always a success response, =
please
-refer to the QMP specification for more details on error responses.
-
-quit
-----
-
-Quit the emulator.
-
-Arguments: None.
-
-Example:
-
--> { "execute": "quit" }
-<- { "return": {} }
-
-eject
------
-
-Eject a removable medium.
-
-Arguments:
-
-- "force": force ejection (json-bool, optional)
-- "device": block device name (deprecated, use @id instead)
-            (json-string, optional)
-- "id": the name or QOM path of the guest device (json-string, optional)
-
-Example:
-
--> { "execute": "eject", "arguments": { "id": "ide0-1-0" } }
-<- { "return": {} }
-
-Note: The "force" argument defaults to false.
-
-change
-------
-
-Change a removable medium or VNC configuration.
-
-Arguments:
-
-- "device": device name (json-string)
-- "target": filename or item (json-string)
-- "arg": additional argument (json-string, optional)
-
-Examples:
-
-1. Change a removable medium
-
--> { "execute": "change",
-             "arguments": { "device": "ide1-cd0",
-                            "target": "/srv/images/Fedora-12-x86_64-DVD.=
iso" } }
-<- { "return": {} }
-
-2. Change VNC password
-
--> { "execute": "change",
-             "arguments": { "device": "vnc", "target": "password",
-                            "arg": "foobar1" } }
-<- { "return": {} }
-
-screendump
-----------
-
-Save screen into PPM image.
-
-Arguments:
-
-- "filename": file path (json-string)
-
-Example:
-
--> { "execute": "screendump", "arguments": { "filename": "/tmp/image" } =
}
-<- { "return": {} }
-
-stop
-----
-
-Stop the emulator.
-
-Arguments: None.
-
-Example:
-
--> { "execute": "stop" }
-<- { "return": {} }
-
-cont
-----
-
-Resume emulation.
-
-Arguments: None.
-
-Example:
-
--> { "execute": "cont" }
-<- { "return": {} }
-
-system_wakeup
--------------
-
-Wakeup guest from suspend.
-
-Arguments: None.
-
-Example:
-
--> { "execute": "system_wakeup" }
-<- { "return": {} }
-
-system_reset
-------------
-
-Reset the system.
-
-Arguments: None.
-
-Example:
-
--> { "execute": "system_reset" }
-<- { "return": {} }
-
-system_powerdown
-----------------
-
-Send system power down event.
-
-Arguments: None.
-
-Example:
-
--> { "execute": "system_powerdown" }
-<- { "return": {} }
-
-device_add
-----------
-
-Add a device.
-
-Arguments:
-
-- "driver": the name of the new device's driver (json-string)
-- "bus": the device's parent bus (device tree path, json-string, optiona=
l)
-- "id": the device's ID, must be unique (json-string)
-- device properties
-
-Example:
-
--> { "execute": "device_add", "arguments": { "driver": "e1000", "id": "n=
et1" } }
-<- { "return": {} }
-
-Notes:
-
-(1) For detailed information about this command, please refer to the
-    'docs/qdev-device-use.txt' file.
-
-(2) It's possible to list device properties by running QEMU with the
-    "-device DEVICE,\?" command-line argument, where DEVICE is the devic=
e's name
-
-device_del
-----------
-
-Remove a device.
-
-Arguments:
-
-- "id": the device's ID or QOM path (json-string)
-
-Example:
-
--> { "execute": "device_del", "arguments": { "id": "net1" } }
-<- { "return": {} }
-
-Example:
-
--> { "execute": "device_del", "arguments": { "id": "/machine/peripheral-=
anon/device[0]" } }
-<- { "return": {} }
-
-send-key
-----------
-
-Send keys to VM.
-
-Arguments:
-
-keys array:
-    - "key": key sequence (a json-array of key union values,
-             union can be number or qcode enum)
-
-- hold-time: time to delay key up events, milliseconds. Defaults to 100
-             (json-int, optional)
-
-Example:
-
--> { "execute": "send-key",
-     "arguments": { "keys": [ { "type": "qcode", "data": "ctrl" },
-                              { "type": "qcode", "data": "alt" },
-                              { "type": "qcode", "data": "delete" } ] } =
}
-<- { "return": {} }
-
-cpu
----
-
-Set the default CPU.
-
-Arguments:
-
-- "index": the CPU's index (json-int)
-
-Example:
-
--> { "execute": "cpu", "arguments": { "index": 0 } }
-<- { "return": {} }
-
-Note: CPUs' indexes are obtained with the 'query-cpus' command.
-
-cpu-add
--------
-
-Adds virtual cpu
-
-Arguments:
-
-- "id": cpu id (json-int)
-
-Example:
-
--> { "execute": "cpu-add", "arguments": { "id": 2 } }
-<- { "return": {} }
-
-memsave
--------
-
-Save to disk virtual memory dump starting at 'val' of size 'size'.
-
-Arguments:
-
-- "val": the starting address (json-int)
-- "size": the memory size, in bytes (json-int)
-- "filename": file path (json-string)
-- "cpu": virtual CPU index (json-int, optional)
-
-Example:
-
--> { "execute": "memsave",
-             "arguments": { "val": 10,
-                            "size": 100,
-                            "filename": "/tmp/virtual-mem-dump" } }
-<- { "return": {} }
-
-pmemsave
---------
-
-Save to disk physical memory dump starting at 'val' of size 'size'.
-
-Arguments:
-
-- "val": the starting address (json-int)
-- "size": the memory size, in bytes (json-int)
-- "filename": file path (json-string)
-
-Example:
-
--> { "execute": "pmemsave",
-             "arguments": { "val": 10,
-                            "size": 100,
-                            "filename": "/tmp/physical-mem-dump" } }
-<- { "return": {} }
-
-inject-nmi
-----------
-
-Inject an NMI on the default CPU (x86/s390) or all CPUs (ppc64).
-
-Arguments: None.
-
-Example:
-
--> { "execute": "inject-nmi" }
-<- { "return": {} }
-
-Note: inject-nmi fails when the guest doesn't support injecting.
-
-ringbuf-write
--------------
-
-Write to a ring buffer character device.
-
-Arguments:
-
-- "device": ring buffer character device name (json-string)
-- "data": data to write (json-string)
-- "format": data format (json-string, optional)
-          - Possible values: "utf8" (default), "base64"
-
-Example:
-
--> { "execute": "ringbuf-write",
-                "arguments": { "device": "foo",
-                               "data": "abcdefgh",
-                               "format": "utf8" } }
-<- { "return": {} }
-
-ringbuf-read
--------------
-
-Read from a ring buffer character device.
-
-Arguments:
-
-- "device": ring buffer character device name (json-string)
-- "size": how many bytes to read at most (json-int)
-          - Number of data bytes, not number of characters in encoded da=
ta
-- "format": data format (json-string, optional)
-          - Possible values: "utf8" (default), "base64"
-          - Naturally, format "utf8" works only when the ring buffer
-            contains valid UTF-8 text.  Invalid UTF-8 sequences get
-            replaced.  Bug: replacement doesn't work.  Bug: can screw
-            up on encountering NUL characters, after the ring buffer
-            lost data, and when reading stops because the size limit
-            is reached.
-
-Example:
-
--> { "execute": "ringbuf-read",
-                "arguments": { "device": "foo",
-                               "size": 1000,
-                               "format": "utf8" } }
-<- {"return": "abcdefgh"}
-
-xen-save-devices-state
--------
-
-Save the state of all devices to file. The RAM and the block devices
-of the VM are not saved by this command.
-
-Arguments:
-
-- "filename": the file to save the state of the devices to as binary
-data. See xen-save-devices-state.txt for a description of the binary
-format.
-
-Example:
-
--> { "execute": "xen-save-devices-state",
-     "arguments": { "filename": "/tmp/save" } }
-<- { "return": {} }
-
-xen-load-devices-state
-----------------------
-
-Load the state of all devices from file. The RAM and the block devices
-of the VM are not loaded by this command.
-
-Arguments:
-
-- "filename": the file to load the state of the devices from as binary
-data. See xen-save-devices-state.txt for a description of the binary
-format.
-
-Example:
-
--> { "execute": "xen-load-devices-state",
-     "arguments": { "filename": "/tmp/resume" } }
-<- { "return": {} }
-
-xen-set-global-dirty-log
--------
-
-Enable or disable the global dirty log mode.
-
-Arguments:
-
-- "enable": Enable it or disable it.
-
-Example:
-
--> { "execute": "xen-set-global-dirty-log",
-     "arguments": { "enable": true } }
-<- { "return": {} }
-
-migrate
--------
-
-Migrate to URI.
-
-Arguments:
-
-- "blk": block migration, full disk copy (json-bool, optional)
-- "inc": incremental disk copy (json-bool, optional)
-- "uri": Destination URI (json-string)
-
-Example:
-
--> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
-<- { "return": {} }
-
-Notes:
-
-(1) The 'query-migrate' command should be used to check migration's prog=
ress
-    and final result (this information is provided by the 'status' membe=
r)
-(2) All boolean arguments default to false
-(3) The user Monitor's "detach" argument is invalid in QMP and should no=
t
-    be used
-
-migrate_cancel
---------------
-
-Cancel the current migration.
-
-Arguments: None.
-
-Example:
-
--> { "execute": "migrate_cancel" }
-<- { "return": {} }
-
-migrate-incoming
-----------------
-
-Continue an incoming migration
-
-Arguments:
-
-- "uri": Source/listening URI (json-string)
-
-Example:
-
--> { "execute": "migrate-incoming", "arguments": { "uri": "tcp::4446" } =
}
-<- { "return": {} }
-
-Notes:
-
-(1) QEMU must be started with -incoming defer to allow migrate-incoming =
to
-    be used
-(2) The uri format is the same as for -incoming
-
-migrate-set-cache-size
-----------------------
-
-Set cache size to be used by XBZRLE migration, the cache size will be ro=
unded
-down to the nearest power of 2
-
-Arguments:
-
-- "value": cache size in bytes (json-int)
-
-Example:
-
--> { "execute": "migrate-set-cache-size", "arguments": { "value": 536870=
912 } }
-<- { "return": {} }
-
-migrate-start-postcopy
-----------------------
-
-Switch an in-progress migration to postcopy mode. Ignored after the end =
of
-migration (or once already in postcopy).
-
-Example:
--> { "execute": "migrate-start-postcopy" }
-<- { "return": {} }
-
-query-migrate-cache-size
-------------------------
-
-Show cache size to be used by XBZRLE migration
-
-returns a json-object with the following information:
-- "size" : json-int
-
-Example:
-
--> { "execute": "query-migrate-cache-size" }
-<- { "return": 67108864 }
-
-migrate_set_speed
------------------
-
-Set maximum speed for migrations.
-
-Arguments:
-
-- "value": maximum speed, in bytes per second (json-int)
-
-Example:
-
--> { "execute": "migrate_set_speed", "arguments": { "value": 1024 } }
-<- { "return": {} }
-
-migrate_set_downtime
---------------------
-
-Set maximum tolerated downtime (in seconds) for migrations.
-
-Arguments:
-
-- "value": maximum downtime (json-number)
-
-Example:
-
--> { "execute": "migrate_set_downtime", "arguments": { "value": 0.1 } }
-<- { "return": {} }
-
-x-colo-lost-heartbeat
---------------------
-
-Tell COLO that heartbeat is lost, a failover or takeover is needed.
-
-Example:
-
--> { "execute": "x-colo-lost-heartbeat" }
-<- { "return": {} }
-
-client_migrate_info
--------------------
-
-Set migration information for remote display.  This makes the server
-ask the client to automatically reconnect using the new parameters
-once migration finished successfully.  Only implemented for SPICE.
-
-Arguments:
-
-- "protocol":     must be "spice" (json-string)
-- "hostname":     migration target hostname (json-string)
-- "port":         spice tcp port for plaintext channels (json-int, optio=
nal)
-- "tls-port":     spice tcp port for tls-secured channels (json-int, opt=
ional)
-- "cert-subject": server certificate subject (json-string, optional)
-
-Example:
-
--> { "execute": "client_migrate_info",
-     "arguments": { "protocol": "spice",
-                    "hostname": "virt42.lab.kraxel.org",
-                    "port": 1234 } }
-<- { "return": {} }
-
-dump
-
-
-Dump guest memory to file. The file can be processed with crash or gdb.
-
-Arguments:
-
-- "paging": do paging to get guest's memory mapping (json-bool)
-- "protocol": destination file(started with "file:") or destination file
-              descriptor (started with "fd:") (json-string)
-- "detach": if specified, command will return immediately, without waiti=
ng
-            for the dump to finish. The user can track progress using
-            "query-dump". (json-bool)
-- "begin": the starting physical address. It's optional, and should be s=
pecified
-           with length together (json-int)
-- "length": the memory size, in bytes. It's optional, and should be spec=
ified
-            with begin together (json-int)
-- "format": the format of guest memory dump. It's optional, and can be
-            elf|kdump-zlib|kdump-lzo|kdump-snappy, but non-elf formats w=
ill
-            conflict with paging and filter, ie. begin and length (json-=
string)
-
-Example:
-
--> { "execute": "dump-guest-memory", "arguments": { "protocol": "fd:dump=
" } }
-<- { "return": {} }
-
-Notes:
-
-(1) All boolean arguments default to false
-
-query-dump-guest-memory-capability
-----------
-
-Show available formats for 'dump-guest-memory'
-
-Example:
-
--> { "execute": "query-dump-guest-memory-capability" }
-<- { "return": { "formats":
-                    ["elf", "kdump-zlib", "kdump-lzo", "kdump-snappy"] }
-
-query-dump
-----------
-
-Query background dump status.
-
-Arguments: None.
-
-Example:
-
--> { "execute": "query-dump" }
-<- { "return": { "status": "active", "completed": 1024000,
-                 "total": 2048000 } }
-
-dump-skeys
-----------
-
-Save guest storage keys to file.
-
-Arguments:
-
-- "filename": file path (json-string)
-
-Example:
-
--> { "execute": "dump-skeys", "arguments": { "filename": "/tmp/skeys" } =
}
-<- { "return": {} }
-
-netdev_add
-----------
-
-Add host network device.
-
-Arguments:
-
-- "type": the device type, "tap", "user", ... (json-string)
-- "id": the device's ID, must be unique (json-string)
-- device options
-
-Example:
-
--> { "execute": "netdev_add",
-     "arguments": { "type": "user", "id": "netdev1",
-                    "dnssearch": "example.org" } }
-<- { "return": {} }
-
-Note: The supported device options are the same ones supported by the '-=
netdev'
-      command-line argument, which are listed in the '-help' output or Q=
EMU's
-      manual
-
-netdev_del
-----------
-
-Remove host network device.
-
-Arguments:
-
-- "id": the device's ID, must be unique (json-string)
-
-Example:
-
--> { "execute": "netdev_del", "arguments": { "id": "netdev1" } }
-<- { "return": {} }
-
-
-object-add
-----------
-
-Create QOM object.
-
-Arguments:
-
-- "qom-type": the object's QOM type, i.e. the class name (json-string)
-- "id": the object's ID, must be unique (json-string)
-- "props": a dictionary of object property values (optional, json-dict)
-
-Example:
-
--> { "execute": "object-add", "arguments": { "qom-type": "rng-random", "=
id": "rng1",
-     "props": { "filename": "/dev/hwrng" } } }
-<- { "return": {} }
-
-object-del
-----------
-
-Remove QOM object.
-
-Arguments:
-
-- "id": the object's ID (json-string)
-
-Example:
-
--> { "execute": "object-del", "arguments": { "id": "rng1" } }
-<- { "return": {} }
-
-
-block_resize
-------------
-
-Resize a block image while a guest is running.
-
-Arguments:
-
-- "device": the device's ID, must be unique (json-string)
-- "node-name": the node name in the block driver state graph (json-strin=
g)
-- "size": new size
-
-Example:
-
--> { "execute": "block_resize", "arguments": { "device": "scratch", "siz=
e": 1073741824 } }
-<- { "return": {} }
-
-block-stream
-------------
-
-Copy data from a backing file into a block device.
-
-Arguments:
-
-- "job-id": Identifier for the newly-created block job. If omitted,
-            the device name will be used. (json-string, optional)
-- "device": The device name or node-name of a root node (json-string)
-- "base": The file name of the backing image above which copying starts.
-          It cannot be set if 'base-node' is also set (json-string, opti=
onal)
-- "base-node": the node name of the backing image above which copying st=
arts.
-               It cannot be set if 'base' is also set.
-               (json-string, optional) (Since 2.8)
-- "backing-file": The backing file string to write into the active layer=
. This
-                  filename is not validated.
-
-                  If a pathname string is such that it cannot be resolve=
d by
-                  QEMU, that means that subsequent QMP or HMP commands m=
ust use
-                  node-names for the image in question, as filename look=
up
-                  methods will fail.
-
-                  If not specified, QEMU will automatically determine th=
e
-                  backing file string to use, or error out if there is n=
o
-                  obvious choice.  Care should be taken when specifying =
the
-                  string, to specify a valid filename or protocol.
-                  (json-string, optional) (Since 2.1)
-- "speed":  the maximum speed, in bytes per second (json-int, optional)
-- "on-error": the action to take on an error (default 'report').  'stop'=
 and
-              'enospc' can only be used if the block device supports io-=
status.
-              (json-string, optional) (Since 2.1)
-
-Example:
-
--> { "execute": "block-stream", "arguments": { "device": "virtio0",
-                                               "base": "/tmp/master.qcow=
2" } }
-<- { "return": {} }
-
-block-commit
-------------
-
-Live commit of data from overlay image nodes into backing nodes - i.e., =
writes
-data between 'top' and 'base' into 'base'.
-
-Arguments:
-
-- "job-id": Identifier for the newly-created block job. If omitted,
-            the device name will be used. (json-string, optional)
-- "device": The device name or node-name of a root node (json-string)
-- "base": The file name of the backing image to write data into.
-          If not specified, this is the deepest backing image
-          (json-string, optional)
-- "top":  The file name of the backing image within the image chain,
-          which contains the topmost data to be committed down. If
-          not specified, this is the active layer. (json-string, optiona=
l)
-
-- backing-file:     The backing file string to write into the overlay
-                    image of 'top'.  If 'top' is the active layer,
-                    specifying a backing file string is an error. This
-                    filename is not validated.
-
-                    If a pathname string is such that it cannot be
-                    resolved by QEMU, that means that subsequent QMP or
-                    HMP commands must use node-names for the image in
-                    question, as filename lookup methods will fail.
-
-                    If not specified, QEMU will automatically determine
-                    the backing file string to use, or error out if
-                    there is no obvious choice. Care should be taken
-                    when specifying the string, to specify a valid
-                    filename or protocol.
-                    (json-string, optional) (Since 2.1)
-
-          If top =3D=3D base, that is an error.
-          If top =3D=3D active, the job will not be completed by itself,
-          user needs to complete the job with the block-job-complete
-          command after getting the ready event. (Since 2.0)
-
-          If the base image is smaller than top, then the base image
-          will be resized to be the same size as top.  If top is
-          smaller than the base image, the base will not be
-          truncated.  If you want the base image size to match the
-          size of the smaller top, you can safely truncate it
-          yourself once the commit operation successfully completes.
-          (json-string)
-- "speed":  the maximum speed, in bytes per second (json-int, optional)
-
-
-Example:
-
--> { "execute": "block-commit", "arguments": { "device": "virtio0",
-                                              "top": "/tmp/snap1.qcow2" =
} }
-<- { "return": {} }
-
-drive-backup
-------------
-
-Start a point-in-time copy of a block device to a new destination.  The
-status of ongoing drive-backup operations can be checked with
-query-block-jobs where the BlockJobInfo.type field has the value 'backup=
'.
-The operation can be stopped before it has completed using the
-block-job-cancel command.
-
-Arguments:
-
-- "job-id": Identifier for the newly-created block job. If omitted,
-            the device name will be used. (json-string, optional)
-- "device": the device name or node-name of a root node which should be =
copied.
-            (json-string)
-- "target": the target of the new image. If the file exists, or if it is=
 a
-            device, the existing file/device will be used as the new
-            destination.  If it does not exist, a new file will be creat=
ed.
-            (json-string)
-- "format": the format of the new destination, default is to probe if 'm=
ode' is
-            'existing', else the format of the source
-            (json-string, optional)
-- "sync": what parts of the disk image should be copied to the destinati=
on;
-  possibilities include "full" for all the disk, "top" for only the sect=
ors
-  allocated in the topmost image, "incremental" for only the dirty secto=
rs in
-  the bitmap, or "none" to only replicate new I/O (MirrorSyncMode).
-- "bitmap": dirty bitmap name for sync=3D=3Dincremental. Must be present=
 if sync
-            is "incremental", must NOT be present otherwise.
-- "mode": whether and how QEMU should create a new image
-          (NewImageMode, optional, default 'absolute-paths')
-- "speed": the maximum speed, in bytes per second (json-int, optional)
-- "compress": true to compress data, if the target format supports it.
-              (json-bool, optional, default false)
-- "on-source-error": the action to take on an error on the source, defau=
lt
-                     'report'.  'stop' and 'enospc' can only be used
-                     if the block device supports io-status.
-                     (BlockdevOnError, optional)
-- "on-target-error": the action to take on an error on the target, defau=
lt
-                     'report' (no limitations, since this applies to
-                     a different block device than device).
-                     (BlockdevOnError, optional)
-
-Example:
--> { "execute": "drive-backup", "arguments": { "device": "drive0",
-                                               "sync": "full",
-                                               "target": "backup.img" } =
}
-<- { "return": {} }
-
-blockdev-backup
----------------
-
-The device version of drive-backup: this command takes an existing named=
 device
-as backup target.
-
-Arguments:
-
-- "job-id": Identifier for the newly-created block job. If omitted,
-            the device name will be used. (json-string, optional)
-- "device": the device name or node-name of a root node which should be =
copied.
-            (json-string)
-- "target": the name of the backup target device. (json-string)
-- "sync": what parts of the disk image should be copied to the destinati=
on;
-          possibilities include "full" for all the disk, "top" for only =
the
-          sectors allocated in the topmost image, or "none" to only repl=
icate
-          new I/O (MirrorSyncMode).
-- "speed": the maximum speed, in bytes per second (json-int, optional)
-- "compress": true to compress data, if the target format supports it.
-              (json-bool, optional, default false)
-- "on-source-error": the action to take on an error on the source, defau=
lt
-                     'report'.  'stop' and 'enospc' can only be used
-                     if the block device supports io-status.
-                     (BlockdevOnError, optional)
-- "on-target-error": the action to take on an error on the target, defau=
lt
-                     'report' (no limitations, since this applies to
-                     a different block device than device).
-                     (BlockdevOnError, optional)
-
-Example:
--> { "execute": "blockdev-backup", "arguments": { "device": "src-id",
-                                                  "sync": "full",
-                                                  "target": "tgt-id" } }
-<- { "return": {} }
-
-transaction
------------
-
-Atomically operate on one or more block devices.  Operations that are
-currently supported:
-
-    - drive-backup
-    - blockdev-backup
-    - blockdev-snapshot-sync
-    - blockdev-snapshot-internal-sync
-    - abort
-    - block-dirty-bitmap-add
-    - block-dirty-bitmap-clear
-
-Refer to the qemu/qapi-schema.json file for minimum required QEMU
-versions for these operations.  A list of dictionaries is accepted,
-that contains the actions to be performed.  If there is any failure
-performing any of the operations, all operations for the group are
-abandoned.
-
-For external snapshots, the dictionary contains the device, the file to =
use for
-the new snapshot, and the format.  The default format, if not specified,=
 is
-qcow2.
-
-Each new snapshot defaults to being created by QEMU (wiping any
-contents if the file already exists), but it is also possible to reuse
-an externally-created file.  In the latter case, you should ensure that
-the new image file has the same contents as the current one; QEMU cannot
-perform any meaningful check.  Typically this is achieved by using the
-current image file as the backing file for the new image.
-
-On failure, the original disks pre-snapshot attempt will be used.
-
-For internal snapshots, the dictionary contains the device and the snaps=
hot's
-name.  If an internal snapshot matching name already exists, the request=
 will
-be rejected.  Only some image formats support it, for example, qcow2, rb=
d,
-and sheepdog.
-
-On failure, qemu will try delete the newly created internal snapshot in =
the
-transaction.  When an I/O error occurs during deletion, the user needs t=
o fix
-it later with qemu-img or other command.
-
-Arguments:
-
-actions array:
-    - "type": the operation to perform (json-string).  Possible
-              values: "drive-backup", "blockdev-backup",
-                      "blockdev-snapshot-sync",
-                      "blockdev-snapshot-internal-sync",
-                      "abort", "block-dirty-bitmap-add",
-                      "block-dirty-bitmap-clear"
-    - "data": a dictionary.  The contents depend on the value
-      of "type".  When "type" is "blockdev-snapshot-sync":
-      - "device": device name to snapshot (json-string)
-      - "node-name": graph node name to snapshot (json-string)
-      - "snapshot-file": name of new image file (json-string)
-      - "snapshot-node-name": graph node name of the new snapshot (json-=
string)
-      - "format": format of new image (json-string, optional)
-      - "mode": whether and how QEMU should create the snapshot file
-        (NewImageMode, optional, default "absolute-paths")
-      When "type" is "blockdev-snapshot-internal-sync":
-      - "device": the device name or node-name of a root node to snapsho=
t
-                  (json-string)
-      - "name": name of the new snapshot (json-string)
-
-Example:
-
--> { "execute": "transaction",
-     "arguments": { "actions": [
-         { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-h=
d0",
-                                         "snapshot-file": "/some/place/m=
y-image",
-                                         "format": "qcow2" } },
-         { "type": "blockdev-snapshot-sync", "data" : { "node-name": "my=
file",
-                                         "snapshot-file": "/some/place/m=
y-image2",
-                                         "snapshot-node-name": "node3432=
",
-                                         "mode": "existing",
-                                         "format": "qcow2" } },
-         { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-h=
d1",
-                                         "snapshot-file": "/some/place/m=
y-image2",
-                                         "mode": "existing",
-                                         "format": "qcow2" } },
-         { "type": "blockdev-snapshot-internal-sync", "data" : {
-                                         "device": "ide-hd2",
-                                         "name": "snapshot0" } } ] } }
-<- { "return": {} }
-
-block-dirty-bitmap-add
-----------------------
-Since 2.4
-
-Create a dirty bitmap with a name on the device, and start tracking the =
writes.
-
-Arguments:
-
-- "node": device/node on which to create dirty bitmap (json-string)
-- "name": name of the new dirty bitmap (json-string)
-- "granularity": granularity to track writes with (int, optional)
-
-Example:
-
--> { "execute": "block-dirty-bitmap-add", "arguments": { "node": "drive0=
",
-                                                   "name": "bitmap0" } }
-<- { "return": {} }
-
-block-dirty-bitmap-remove
--------------------------
-Since 2.4
-
-Stop write tracking and remove the dirty bitmap that was created with
-block-dirty-bitmap-add.
-
-Arguments:
-
-- "node": device/node on which to remove dirty bitmap (json-string)
-- "name": name of the dirty bitmap to remove (json-string)
-
-Example:
-
--> { "execute": "block-dirty-bitmap-remove", "arguments": { "node": "dri=
ve0",
-                                                      "name": "bitmap0" =
} }
-<- { "return": {} }
-
-block-dirty-bitmap-clear
-------------------------
-Since 2.4
-
-Reset the dirty bitmap associated with a node so that an incremental bac=
kup
-from this point in time forward will only backup clusters modified after=
 this
-clear operation.
-
-Arguments:
-
-- "node": device/node on which to remove dirty bitmap (json-string)
-- "name": name of the dirty bitmap to remove (json-string)
-
-Example:
-
--> { "execute": "block-dirty-bitmap-clear", "arguments": { "node": "driv=
e0",
-                                                           "name": "bitm=
ap0" } }
-<- { "return": {} }
-
-blockdev-snapshot-sync
-----------------------
-
-Synchronous snapshot of a block device. snapshot-file specifies the
-target of the new image. If the file exists, or if it is a device, the
-snapshot will be created in the existing file/device. If does not
-exist, a new file will be created. format specifies the format of the
-snapshot image, default is qcow2.
-
-Arguments:
-
-- "device": device name to snapshot (json-string)
-- "node-name": graph node name to snapshot (json-string)
-- "snapshot-file": name of new image file (json-string)
-- "snapshot-node-name": graph node name of the new snapshot (json-string=
)
-- "mode": whether and how QEMU should create the snapshot file
-  (NewImageMode, optional, default "absolute-paths")
-- "format": format of new image (json-string, optional)
-
-Example:
-
--> { "execute": "blockdev-snapshot-sync", "arguments": { "device": "ide-=
hd0",
-                                                         "snapshot-file"=
:
-                                                        "/some/place/my-=
image",
-                                                        "format": "qcow2=
" } }
-<- { "return": {} }
-
-blockdev-snapshot
------------------
-Since 2.5
-
-Create a snapshot, by installing 'node' as the backing image of
-'overlay'. Additionally, if 'node' is associated with a block
-device, the block device changes to using 'overlay' as its new active
-image.
-
-Arguments:
-
-- "node": device that will have a snapshot created (json-string)
-- "overlay": device that will have 'node' as its backing image (json-str=
ing)
-
-Example:
-
--> { "execute": "blockdev-add",
-                "arguments": { "driver": "qcow2",
-                               "node-name": "node1534",
-                               "file": { "driver": "file",
-                                         "filename": "hd1.qcow2" },
-                               "backing": "" } }
-
-<- { "return": {} }
-
--> { "execute": "blockdev-snapshot", "arguments": { "node": "ide-hd0",
-                                                    "overlay": "node1534=
" } }
-<- { "return": {} }
-
-blockdev-snapshot-internal-sync
--------------------------------
-
-Synchronously take an internal snapshot of a block device when the forma=
t of
-image used supports it.  If the name is an empty string, or a snapshot w=
ith
-name already exists, the operation will fail.
-
-Arguments:
-
-- "device": the device name or node-name of a root node to snapshot
-            (json-string)
-- "name": name of the new snapshot (json-string)
-
-Example:
-
--> { "execute": "blockdev-snapshot-internal-sync",
-                "arguments": { "device": "ide-hd0",
-                               "name": "snapshot0" }
-   }
-<- { "return": {} }
-
-blockdev-snapshot-delete-internal-sync
---------------------------------------
-
-Synchronously delete an internal snapshot of a block device when the for=
mat of
-image used supports it.  The snapshot is identified by name or id or bot=
h.  One
-of name or id is required.  If the snapshot is not found, the operation =
will
-fail.
-
-Arguments:
-
-- "device": the device name or node-name of a root node (json-string)
-- "id": ID of the snapshot (json-string, optional)
-- "name": name of the snapshot (json-string, optional)
-
-Example:
-
--> { "execute": "blockdev-snapshot-delete-internal-sync",
-                "arguments": { "device": "ide-hd0",
-                               "name": "snapshot0" }
-   }
-<- { "return": {
-                   "id": "1",
-                   "name": "snapshot0",
-                   "vm-state-size": 0,
-                   "date-sec": 1000012,
-                   "date-nsec": 10,
-                   "vm-clock-sec": 100,
-                   "vm-clock-nsec": 20
-     }
-   }
-
-drive-mirror
-------------
-
-Start mirroring a block device's writes to a new destination. target
-specifies the target of the new image. If the file exists, or if it is
-a device, it will be used as the new destination for writes. If it does =
not
-exist, a new file will be created. format specifies the format of the
-mirror image, default is to probe if mode=3D'existing', else the format
-of the source.
-
-Arguments:
-
-- "job-id": Identifier for the newly-created block job. If omitted,
-            the device name will be used. (json-string, optional)
-- "device": the device name or node-name of a root node whose writes sho=
uld be
-            mirrored. (json-string)
-- "target": name of new image file (json-string)
-- "format": format of new image (json-string, optional)
-- "node-name": the name of the new block driver state in the node graph
-               (json-string, optional)
-- "replaces": the block driver node name to replace when finished
-              (json-string, optional)
-- "mode": how an image file should be created into the target
-  file/device (NewImageMode, optional, default 'absolute-paths')
-- "speed": maximum speed of the streaming job, in bytes per second
-  (json-int)
-- "granularity": granularity of the dirty bitmap, in bytes (json-int, op=
tional)
-- "buf-size": maximum amount of data in flight from source to target, in=
 bytes
-  (json-int, default 10M)
-- "sync": what parts of the disk image should be copied to the destinati=
on;
-  possibilities include "full" for all the disk, "top" for only the sect=
ors
-  allocated in the topmost image, or "none" to only replicate new I/O
-  (MirrorSyncMode).
-- "on-source-error": the action to take on an error on the source
-  (BlockdevOnError, default 'report')
-- "on-target-error": the action to take on an error on the target
-  (BlockdevOnError, default 'report')
-- "unmap": whether the target sectors should be discarded where source h=
as only
-  zeroes. (json-bool, optional, default true)
-
-The default value of the granularity is the image cluster size clamped
-between 4096 and 65536, if the image format defines one.  If the format
-does not define a cluster size, the default value of the granularity
-is 65536.
-
-
-Example:
-
--> { "execute": "drive-mirror", "arguments": { "device": "ide-hd0",
-                                               "target": "/some/place/my=
-image",
-                                               "sync": "full",
-                                               "format": "qcow2" } }
-<- { "return": {} }
-
-blockdev-mirror
-------------
-
-Start mirroring a block device's writes to another block device. target
-specifies the target of mirror operation.
-
-Arguments:
-
-- "job-id": Identifier for the newly-created block job. If omitted,
-            the device name will be used. (json-string, optional)
-- "device": The device name or node-name of a root node whose writes sho=
uld be
-            mirrored (json-string)
-- "target": device name to mirror to (json-string)
-- "replaces": the block driver node name to replace when finished
-              (json-string, optional)
-- "speed": maximum speed of the streaming job, in bytes per second
-  (json-int)
-- "granularity": granularity of the dirty bitmap, in bytes (json-int, op=
tional)
-- "buf_size": maximum amount of data in flight from source to target, in=
 bytes
-  (json-int, default 10M)
-- "sync": what parts of the disk image should be copied to the destinati=
on;
-  possibilities include "full" for all the disk, "top" for only the sect=
ors
-  allocated in the topmost image, or "none" to only replicate new I/O
-  (MirrorSyncMode).
-- "on-source-error": the action to take on an error on the source
-  (BlockdevOnError, default 'report')
-- "on-target-error": the action to take on an error on the target
-  (BlockdevOnError, default 'report')
-
-The default value of the granularity is the image cluster size clamped
-between 4096 and 65536, if the image format defines one.  If the format
-does not define a cluster size, the default value of the granularity
-is 65536.
-
-Example:
-
--> { "execute": "blockdev-mirror", "arguments": { "device": "ide-hd0",
-                                                  "target": "target0",
-                                                  "sync": "full" } }
-<- { "return": {} }
-
-change-backing-file
--------------------
-Since: 2.1
-
-Change the backing file in the image file metadata.  This does not cause
-QEMU to reopen the image file to reparse the backing filename (it may,
-however, perform a reopen to change permissions from r/o -> r/w -> r/o,
-if needed). The new backing file string is written into the image file
-metadata, and the QEMU internal strings are updated.
-
-Arguments:
-
-- "image-node-name":    The name of the block driver state node of the
-                        image to modify.  The "device" is argument is us=
ed to
-                        verify "image-node-name" is in the chain describ=
ed by
-                        "device".
-                        (json-string, optional)
-
-- "device":             The device name or node-name of the root node th=
at owns
-                        image-node-name.
-                        (json-string)
-
-- "backing-file":       The string to write as the backing file.  This s=
tring is
-                        not validated, so care should be taken when spec=
ifying
-                        the string or the image chain may not be able to=
 be
-                        reopened again.
-                        (json-string)
-
-Returns: Nothing on success
-         If "device" does not exist or cannot be determined, DeviceNotFo=
und
-
-balloon
--------
-
-Request VM to change its memory allocation (in bytes).
-
-Arguments:
-
-- "value": New memory allocation (json-int)
-
-Example:
-
--> { "execute": "balloon", "arguments": { "value": 536870912 } }
-<- { "return": {} }
-
-set_link
---------
-
-Change the link status of a network adapter.
-
-Arguments:
-
-- "name": network device name (json-string)
-- "up": status is up (json-bool)
-
-Example:
-
--> { "execute": "set_link", "arguments": { "name": "e1000.0", "up": fals=
e } }
-<- { "return": {} }
-
-getfd
------
-
-Receive a file descriptor via SCM rights and assign it a name.
-
-Arguments:
-
-- "fdname": file descriptor name (json-string)
-
-Example:
-
--> { "execute": "getfd", "arguments": { "fdname": "fd1" } }
-<- { "return": {} }
-
-Notes:
-
-(1) If the name specified by the "fdname" argument already exists,
-    the file descriptor assigned to it will be closed and replaced
-    by the received file descriptor.
-(2) The 'closefd' command can be used to explicitly close the file
-    descriptor when it is no longer needed.
-
-closefd
--------
-
-Close a file descriptor previously passed via SCM rights.
-
-Arguments:
-
-- "fdname": file descriptor name (json-string)
-
-Example:
-
--> { "execute": "closefd", "arguments": { "fdname": "fd1" } }
-<- { "return": {} }
-
-add-fd
--------
-
-Add a file descriptor, that was passed via SCM rights, to an fd set.
-
-Arguments:
-
-- "fdset-id": The ID of the fd set to add the file descriptor to.
-              (json-int, optional)
-- "opaque": A free-form string that can be used to describe the fd.
-            (json-string, optional)
-
-Return a json-object with the following information:
-
-- "fdset-id": The ID of the fd set that the fd was added to. (json-int)
-- "fd": The file descriptor that was received via SCM rights and added t=
o the
-        fd set. (json-int)
-
-Example:
-
--> { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
-<- { "return": { "fdset-id": 1, "fd": 3 } }
-
-Notes:
-
-(1) The list of fd sets is shared by all monitor connections.
-(2) If "fdset-id" is not specified, a new fd set will be created.
-
-remove-fd
----------
-
-Remove a file descriptor from an fd set.
-
-Arguments:
-
-- "fdset-id": The ID of the fd set that the file descriptor belongs to.
-              (json-int)
-- "fd": The file descriptor that is to be removed. (json-int, optional)
-
-Example:
-
--> { "execute": "remove-fd", "arguments": { "fdset-id": 1, "fd": 3 } }
-<- { "return": {} }
-
-Notes:
-
-(1) The list of fd sets is shared by all monitor connections.
-(2) If "fd" is not specified, all file descriptors in "fdset-id" will be
-    removed.
-
-query-fdsets
--------------
-
-Return information describing all fd sets.
-
-Arguments: None
-
-Example:
-
--> { "execute": "query-fdsets" }
-<- { "return": [
-       {
-         "fds": [
-           {
-             "fd": 30,
-             "opaque": "rdonly:/path/to/file"
-           },
-           {
-             "fd": 24,
-             "opaque": "rdwr:/path/to/file"
-           }
-         ],
-         "fdset-id": 1
-       },
-       {
-         "fds": [
-           {
-             "fd": 28
-           },
-           {
-             "fd": 29
-           }
-         ],
-         "fdset-id": 0
-       }
-     ]
-   }
-
-Note: The list of fd sets is shared by all monitor connections.
-
-block_passwd
-------------
-
-Set the password of encrypted block devices.
-
-Arguments:
-
-- "device": device name (json-string)
-- "node-name": name in the block driver state graph (json-string)
-- "password": password (json-string)
-
-Example:
-
--> { "execute": "block_passwd", "arguments": { "device": "ide0-hd0",
-                                               "password": "12345" } }
-<- { "return": {} }
-
-block_set_io_throttle
-------------
-
-Change I/O throttle limits for a block drive.
-
-Arguments:
-
-- "device": block device name (deprecated, use @id instead)
-            (json-string, optional)
-- "id": the name or QOM path of the guest device (json-string, optional)
-- "bps": total throughput limit in bytes per second (json-int)
-- "bps_rd": read throughput limit in bytes per second (json-int)
-- "bps_wr": write throughput limit in bytes per second (json-int)
-- "iops": total I/O operations per second (json-int)
-- "iops_rd": read I/O operations per second (json-int)
-- "iops_wr": write I/O operations per second (json-int)
-- "bps_max": total throughput limit during bursts, in bytes (json-int, o=
ptional)
-- "bps_rd_max": read throughput limit during bursts, in bytes (json-int,=
 optional)
-- "bps_wr_max": write throughput limit during bursts, in bytes (json-int=
, optional)
-- "iops_max": total I/O operations per second during bursts (json-int, o=
ptional)
-- "iops_rd_max": read I/O operations per second during bursts (json-int,=
 optional)
-- "iops_wr_max": write I/O operations per second during bursts (json-int=
, optional)
-- "bps_max_length": maximum length of the @bps_max burst period, in seco=
nds (json-int, optional)
-- "bps_rd_max_length": maximum length of the @bps_rd_max burst period, i=
n seconds (json-int, optional)
-- "bps_wr_max_length": maximum length of the @bps_wr_max burst period, i=
n seconds (json-int, optional)
-- "iops_max_length": maximum length of the @iops_max burst period, in se=
conds (json-int, optional)
-- "iops_rd_max_length": maximum length of the @iops_rd_max burst period,=
 in seconds (json-int, optional)
-- "iops_wr_max_length": maximum length of the @iops_wr_max burst period,=
 in seconds (json-int, optional)
-- "iops_size":  I/O size in bytes when limiting (json-int, optional)
-- "group": throttle group name (json-string, optional)
-
-Example:
-
--> { "execute": "block_set_io_throttle", "arguments": { "id": "ide0-1-0"=
,
-                                               "bps": 1000000,
-                                               "bps_rd": 0,
-                                               "bps_wr": 0,
-                                               "iops": 0,
-                                               "iops_rd": 0,
-                                               "iops_wr": 0,
-                                               "bps_max": 8000000,
-                                               "bps_rd_max": 0,
-                                               "bps_wr_max": 0,
-                                               "iops_max": 0,
-                                               "iops_rd_max": 0,
-                                               "iops_wr_max": 0,
-                                               "bps_max_length": 60,
-                                               "iops_size": 0 } }
-<- { "return": {} }
-
-set_password
-------------
-
-Set the password for vnc/spice protocols.
-
-Arguments:
-
-- "protocol": protocol name (json-string)
-- "password": password (json-string)
-- "connected": [ keep | disconnect | fail ] (json-string, optional)
-
-Example:
-
--> { "execute": "set_password", "arguments": { "protocol": "vnc",
-                                               "password": "secret" } }
-<- { "return": {} }
-
-expire_password
----------------
-
-Set the password expire time for vnc/spice protocols.
-
-Arguments:
-
-- "protocol": protocol name (json-string)
-- "time": [ now | never | +secs | secs ] (json-string)
-
-Example:
-
--> { "execute": "expire_password", "arguments": { "protocol": "vnc",
-                                                  "time": "+60" } }
-<- { "return": {} }
-
-add_client
-----------
-
-Add a graphics client
-
-Arguments:
-
-- "protocol": protocol name (json-string)
-- "fdname": file descriptor name (json-string)
-- "skipauth": whether to skip authentication (json-bool, optional)
-- "tls": whether to perform TLS (json-bool, optional)
-
-Example:
-
--> { "execute": "add_client", "arguments": { "protocol": "vnc",
-                                             "fdname": "myclient" } }
-<- { "return": {} }
-
-qmp_capabilities
-----------------
-
-Enable QMP capabilities.
-
-Arguments: None.
-
-Example:
-
--> { "execute": "qmp_capabilities" }
-<- { "return": {} }
-
-Note: This command must be issued before issuing any other command.
-
-human-monitor-command
----------------------
-
-Execute a Human Monitor command.
-
-Arguments:
-
-- command-line: the command name and its arguments, just like the
-                Human Monitor's shell (json-string)
-- cpu-index: select the CPU number to be used by commands which access C=
PU
-             data, like 'info registers'. The Monitor selects CPU 0 if t=
his
-             argument is not provided (json-int, optional)
-
-Example:
-
--> { "execute": "human-monitor-command", "arguments": { "command-line": =
"info kvm" } }
-<- { "return": "kvm support: enabled\r\n" }
-
-Notes:
-
-(1) The Human Monitor is NOT an stable interface, this means that comman=
d
-    names, arguments and responses can change or be removed at ANY time.
-    Applications that rely on long term stability guarantees should NOT
-    use this command
-
-(2) Limitations:
-
-    o This command is stateless, this means that commands that depend
-      on state information (such as getfd) might not work
-
-    o Commands that prompt the user for data (eg. 'cont' when the block
-      device is encrypted) don't currently work
-
-3. Query Commands
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-
-query-version
--------------
-
-Show QEMU version.
-
-Return a json-object with the following information:
-
-- "qemu": A json-object containing three integer values:
-    - "major": QEMU's major version (json-int)
-    - "minor": QEMU's minor version (json-int)
-    - "micro": QEMU's micro version (json-int)
-- "package": package's version (json-string)
-
-Example:
-
--> { "execute": "query-version" }
-<- {
-      "return":{
-         "qemu":{
-            "major":0,
-            "minor":11,
-            "micro":5
-         },
-         "package":""
-      }
-   }
-
-query-commands
---------------
-
-List QMP available commands.
-
-Each command is represented by a json-object, the returned value is a js=
on-array
-of all commands.
-
-Each json-object contain:
-
-- "name": command's name (json-string)
-
-Example:
-
--> { "execute": "query-commands" }
-<- {
-      "return":[
-         {
-            "name":"query-balloon"
-         },
-         {
-            "name":"system_powerdown"
-         }
-      ]
-   }
-
-Note: This example has been shortened as the real response is too long.
-
-query-events
---------------
-
-List QMP available events.
-
-Each event is represented by a json-object, the returned value is a json=
-array
-of all events.
-
-Each json-object contains:
-
-- "name": event's name (json-string)
-
-Example:
-
--> { "execute": "query-events" }
-<- {
-      "return":[
-         {
-            "name":"SHUTDOWN"
-         },
-         {
-            "name":"RESET"
-         }
-      ]
-   }
-
-Note: This example has been shortened as the real response is too long.
-
-query-qmp-schema
-----------------
-
-Return the QMP wire schema.  The returned value is a json-array of
-named schema entities.  Entities are commands, events and various
-types.  See docs/qapi-code-gen.txt for information on their structure
-and intended use.
-
-query-chardev
--------------
-
-Each device is represented by a json-object. The returned value is a jso=
n-array
-of all devices.
-
-Each json-object contain the following:
-
-- "label": device's label (json-string)
-- "filename": device's file (json-string)
-- "frontend-open": open/closed state of the frontend device attached to =
this
-                   backend (json-bool)
-
-Example:
-
--> { "execute": "query-chardev" }
-<- {
-      "return": [
-         {
-            "label": "charchannel0",
-            "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.agent,=
server",
-            "frontend-open": false
-         },
-         {
-            "label": "charmonitor",
-            "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.monito=
r,server",
-            "frontend-open": true
-         },
-         {
-            "label": "charserial0",
-            "filename": "pty:/dev/pts/2",
-            "frontend-open": true
-         }
-      ]
-   }
-
-query-chardev-backends
--------------
-
-List available character device backends.
-
-Each backend is represented by a json-object, the returned value is a js=
on-array
-of all backends.
-
-Each json-object contains:
-
-- "name": backend name (json-string)
-
-Example:
-
--> { "execute": "query-chardev-backends" }
-<- {
-      "return":[
-         {
-            "name":"udp"
-         },
-         {
-            "name":"tcp"
-         },
-         {
-            "name":"unix"
-         },
-         {
-            "name":"spiceport"
-         }
-      ]
-   }
-
-query-block
------------
-
-Show the block devices.
-
-Each block device information is stored in a json-object and the returne=
d value
-is a json-array of all devices.
-
-Each json-object contain the following:
-
-- "device": device name (json-string)
-- "type": device type (json-string)
-         - deprecated, retained for backward compatibility
-         - Possible values: "unknown"
-- "removable": true if the device is removable, false otherwise (json-bo=
ol)
-- "locked": true if the device is locked, false otherwise (json-bool)
-- "tray_open": only present if removable, true if the device has a tray,
-               and it is open (json-bool)
-- "inserted": only present if the device is inserted, it is a json-objec=
t
-   containing the following:
-         - "file": device file name (json-string)
-         - "ro": true if read-only, false otherwise (json-bool)
-         - "drv": driver format name (json-string)
-             - Possible values: "blkdebug", "bochs", "cloop", "dmg",
-                                "file", "file", "ftp", "ftps", "host_cdr=
om",
-                                "host_device", "http", "https",
-                                "nbd", "parallels", "qcow", "qcow2", "ra=
w",
-                                "vdi", "vmdk", "vpc", "vvfat"
-         - "backing_file": backing file name (json-string, optional)
-         - "backing_file_depth": number of files in the backing file cha=
in (json-int)
-         - "encrypted": true if encrypted, false otherwise (json-bool)
-         - "bps": limit total bytes per second (json-int)
-         - "bps_rd": limit read bytes per second (json-int)
-         - "bps_wr": limit write bytes per second (json-int)
-         - "iops": limit total I/O operations per second (json-int)
-         - "iops_rd": limit read operations per second (json-int)
-         - "iops_wr": limit write operations per second (json-int)
-         - "bps_max":  total max in bytes (json-int)
-         - "bps_rd_max":  read max in bytes (json-int)
-         - "bps_wr_max":  write max in bytes (json-int)
-         - "iops_max":  total I/O operations max (json-int)
-         - "iops_rd_max":  read I/O operations max (json-int)
-         - "iops_wr_max":  write I/O operations max (json-int)
-         - "iops_size": I/O size when limiting by iops (json-int)
-         - "detect_zeroes": detect and optimize zero writing (json-strin=
g)
-             - Possible values: "off", "on", "unmap"
-         - "write_threshold": write offset threshold in bytes, a event w=
ill be
-                              emitted if crossed. Zero if disabled (json=
-int)
-         - "image": the detail of the image, it is a json-object contain=
ing
-            the following:
-             - "filename": image file name (json-string)
-             - "format": image format (json-string)
-             - "virtual-size": image capacity in bytes (json-int)
-             - "dirty-flag": true if image is not cleanly closed, not pr=
esent
-                             means clean (json-bool, optional)
-             - "actual-size": actual size on disk in bytes of the image,=
 not
-                              present when image does not support thin
-                              provision (json-int, optional)
-             - "cluster-size": size of a cluster in bytes, not present i=
f image
-                               format does not support it (json-int, opt=
ional)
-             - "encrypted": true if the image is encrypted, not present =
means
-                            false or the image format does not support
-                            encryption (json-bool, optional)
-             - "backing_file": backing file name, not present means no b=
acking
-                               file is used or the image format does not
-                               support backing file chain
-                               (json-string, optional)
-             - "full-backing-filename": full path of the backing file, n=
ot
-                                        present if it equals backing_fil=
e or no
-                                        backing file is used
-                                        (json-string, optional)
-             - "backing-filename-format": the format of the backing file=
, not
-                                          present means unknown or no ba=
cking
-                                          file (json-string, optional)
-             - "snapshots": the internal snapshot info, it is an optiona=
l list
-                of json-object containing the following:
-                 - "id": unique snapshot id (json-string)
-                 - "name": snapshot name (json-string)
-                 - "vm-state-size": size of the VM state in bytes (json-=
int)
-                 - "date-sec": UTC date of the snapshot in seconds (json=
-int)
-                 - "date-nsec": fractional part in nanoseconds to be use=
d with
-                                date-sec (json-int)
-                 - "vm-clock-sec": VM clock relative to boot in seconds
-                                   (json-int)
-                 - "vm-clock-nsec": fractional part in nanoseconds to be=
 used
-                                    with vm-clock-sec (json-int)
-             - "backing-image": the detail of the backing image, it is a=
n
-                                optional json-object only present when a
-                                backing image present for this image
-
-- "io-status": I/O operation status, only present if the device supports=
 it
-               and the VM is configured to stop on errors. It's always r=
eset
-               to "ok" when the "cont" command is issued (json_string, o=
ptional)
-             - Possible values: "ok", "failed", "nospace"
-
-Example:
-
--> { "execute": "query-block" }
-<- {
-      "return":[
-         {
-            "io-status": "ok",
-            "device":"ide0-hd0",
-            "locked":false,
-            "removable":false,
-            "inserted":{
-               "ro":false,
-               "drv":"qcow2",
-               "encrypted":false,
-               "file":"disks/test.qcow2",
-               "backing_file_depth":1,
-               "bps":1000000,
-               "bps_rd":0,
-               "bps_wr":0,
-               "iops":1000000,
-               "iops_rd":0,
-               "iops_wr":0,
-               "bps_max": 8000000,
-               "bps_rd_max": 0,
-               "bps_wr_max": 0,
-               "iops_max": 0,
-               "iops_rd_max": 0,
-               "iops_wr_max": 0,
-               "iops_size": 0,
-               "detect_zeroes": "on",
-               "write_threshold": 0,
-               "image":{
-                  "filename":"disks/test.qcow2",
-                  "format":"qcow2",
-                  "virtual-size":2048000,
-                  "backing_file":"base.qcow2",
-                  "full-backing-filename":"disks/base.qcow2",
-                  "backing-filename-format":"qcow2",
-                  "snapshots":[
-                     {
-                        "id": "1",
-                        "name": "snapshot1",
-                        "vm-state-size": 0,
-                        "date-sec": 10000200,
-                        "date-nsec": 12,
-                        "vm-clock-sec": 206,
-                        "vm-clock-nsec": 30
-                     }
-                  ],
-                  "backing-image":{
-                      "filename":"disks/base.qcow2",
-                      "format":"qcow2",
-                      "virtual-size":2048000
-                  }
-               }
-            },
-            "type":"unknown"
-         },
-         {
-            "io-status": "ok",
-            "device":"ide1-cd0",
-            "locked":false,
-            "removable":true,
-            "type":"unknown"
-         },
-         {
-            "device":"floppy0",
-            "locked":false,
-            "removable":true,
-            "type":"unknown"
-         },
-         {
-            "device":"sd0",
-            "locked":false,
-            "removable":true,
-            "type":"unknown"
-         }
-      ]
-   }
-
-query-blockstats
-----------------
-
-Show block device statistics.
-
-Each device statistic information is stored in a json-object and the ret=
urned
-value is a json-array of all devices.
-
-Each json-object contain the following:
-
-- "device": device name (json-string)
-- "stats": A json-object with the statistics information, it contains:
-    - "rd_bytes": bytes read (json-int)
-    - "wr_bytes": bytes written (json-int)
-    - "rd_operations": read operations (json-int)
-    - "wr_operations": write operations (json-int)
-    - "flush_operations": cache flush operations (json-int)
-    - "wr_total_time_ns": total time spend on writes in nano-seconds (js=
on-int)
-    - "rd_total_time_ns": total time spend on reads in nano-seconds (jso=
n-int)
-    - "flush_total_time_ns": total time spend on cache flushes in nano-s=
econds (json-int)
-    - "wr_highest_offset": The offset after the greatest byte written to=
 the
-                           BlockDriverState since it has been opened (js=
on-int)
-    - "rd_merged": number of read requests that have been merged into
-                   another request (json-int)
-    - "wr_merged": number of write requests that have been merged into
-                   another request (json-int)
-    - "idle_time_ns": time since the last I/O operation, in
-                      nanoseconds. If the field is absent it means
-                      that there haven't been any operations yet
-                      (json-int, optional)
-    - "failed_rd_operations": number of failed read operations
-                              (json-int)
-    - "failed_wr_operations": number of failed write operations
-                              (json-int)
-    - "failed_flush_operations": number of failed flush operations
-                               (json-int)
-    - "invalid_rd_operations": number of invalid read operations
-                               (json-int)
-    - "invalid_wr_operations": number of invalid write operations
-                               (json-int)
-    - "invalid_flush_operations": number of invalid flush operations
-                                  (json-int)
-    - "account_invalid": whether invalid operations are included in
-                         the last access statistics (json-bool)
-    - "account_failed": whether failed operations are included in the
-                         latency and last access statistics
-                         (json-bool)
-    - "timed_stats": A json-array containing statistics collected in
-                     specific intervals, with the following members:
-        - "interval_length": interval used for calculating the
-                             statistics, in seconds (json-int)
-        - "min_rd_latency_ns": minimum latency of read operations in
-                               the defined interval, in nanoseconds
-                               (json-int)
-        - "min_wr_latency_ns": minimum latency of write operations in
-                               the defined interval, in nanoseconds
-                               (json-int)
-        - "min_flush_latency_ns": minimum latency of flush operations
-                                  in the defined interval, in
-                                  nanoseconds (json-int)
-        - "max_rd_latency_ns": maximum latency of read operations in
-                               the defined interval, in nanoseconds
-                               (json-int)
-        - "max_wr_latency_ns": maximum latency of write operations in
-                               the defined interval, in nanoseconds
-                               (json-int)
-        - "max_flush_latency_ns": maximum latency of flush operations
-                                  in the defined interval, in
-                                  nanoseconds (json-int)
-        - "avg_rd_latency_ns": average latency of read operations in
-                               the defined interval, in nanoseconds
-                               (json-int)
-        - "avg_wr_latency_ns": average latency of write operations in
-                               the defined interval, in nanoseconds
-                               (json-int)
-        - "avg_flush_latency_ns": average latency of flush operations
-                                  in the defined interval, in
-                                  nanoseconds (json-int)
-        - "avg_rd_queue_depth": average number of pending read
-                                operations in the defined interval
-                                (json-number)
-        - "avg_wr_queue_depth": average number of pending write
-                                operations in the defined interval
-                                (json-number).
-- "parent": Contains recursively the statistics of the underlying
-            protocol (e.g. the host file for a qcow2 image). If there is
-            no underlying protocol, this field is omitted
-            (json-object, optional)
-
-Example:
-
--> { "execute": "query-blockstats" }
-<- {
-      "return":[
-         {
-            "device":"ide0-hd0",
-            "parent":{
-               "stats":{
-                  "wr_highest_offset":3686448128,
-                  "wr_bytes":9786368,
-                  "wr_operations":751,
-                  "rd_bytes":122567168,
-                  "rd_operations":36772
-                  "wr_total_times_ns":313253456
-                  "rd_total_times_ns":3465673657
-                  "flush_total_times_ns":49653
-                  "flush_operations":61,
-                  "rd_merged":0,
-                  "wr_merged":0,
-                  "idle_time_ns":2953431879,
-                  "account_invalid":true,
-                  "account_failed":false
-               }
-            },
-            "stats":{
-               "wr_highest_offset":2821110784,
-               "wr_bytes":9786368,
-               "wr_operations":692,
-               "rd_bytes":122739200,
-               "rd_operations":36604
-               "flush_operations":51,
-               "wr_total_times_ns":313253456
-               "rd_total_times_ns":3465673657
-               "flush_total_times_ns":49653,
-               "rd_merged":0,
-               "wr_merged":0,
-               "idle_time_ns":2953431879,
-               "account_invalid":true,
-               "account_failed":false
-            }
-         },
-         {
-            "device":"ide1-cd0",
-            "stats":{
-               "wr_highest_offset":0,
-               "wr_bytes":0,
-               "wr_operations":0,
-               "rd_bytes":0,
-               "rd_operations":0
-               "flush_operations":0,
-               "wr_total_times_ns":0
-               "rd_total_times_ns":0
-               "flush_total_times_ns":0,
-               "rd_merged":0,
-               "wr_merged":0,
-               "account_invalid":false,
-               "account_failed":false
-            }
-         },
-         {
-            "device":"floppy0",
-            "stats":{
-               "wr_highest_offset":0,
-               "wr_bytes":0,
-               "wr_operations":0,
-               "rd_bytes":0,
-               "rd_operations":0
-               "flush_operations":0,
-               "wr_total_times_ns":0
-               "rd_total_times_ns":0
-               "flush_total_times_ns":0,
-               "rd_merged":0,
-               "wr_merged":0,
-               "account_invalid":false,
-               "account_failed":false
-            }
-         },
-         {
-            "device":"sd0",
-            "stats":{
-               "wr_highest_offset":0,
-               "wr_bytes":0,
-               "wr_operations":0,
-               "rd_bytes":0,
-               "rd_operations":0
-               "flush_operations":0,
-               "wr_total_times_ns":0
-               "rd_total_times_ns":0
-               "flush_total_times_ns":0,
-               "rd_merged":0,
-               "wr_merged":0,
-               "account_invalid":false,
-               "account_failed":false
-            }
-         }
-      ]
-   }
-
-query-cpus
-----------
-
-Show CPU information.
-
-Return a json-array. Each CPU is represented by a json-object, which con=
tains:
-
-- "CPU": CPU index (json-int)
-- "current": true if this is the current CPU, false otherwise (json-bool=
)
-- "halted": true if the cpu is halted, false otherwise (json-bool)
-- "qom_path": path to the CPU object in the QOM tree (json-str)
-- "arch": architecture of the cpu, which determines what additional
-          keys will be present (json-str)
-- Current program counter. The key's name depends on the architecture:
-     "pc": i386/x86_64 (json-int)
-     "nip": PPC (json-int)
-     "pc" and "npc": sparc (json-int)
-     "PC": mips (json-int)
-- "thread_id": ID of the underlying host thread (json-int)
-
-Example:
-
--> { "execute": "query-cpus" }
-<- {
-      "return":[
-         {
-            "CPU":0,
-            "current":true,
-            "halted":false,
-            "qom_path":"/machine/unattached/device[0]",
-            "arch":"x86",
-            "pc":3227107138,
-            "thread_id":3134
-         },
-         {
-            "CPU":1,
-            "current":false,
-            "halted":true,
-            "qom_path":"/machine/unattached/device[2]",
-            "arch":"x86",
-            "pc":7108165,
-            "thread_id":3135
-         }
-      ]
-   }
-
-query-iothreads
----------------
-
-Returns a list of information about each iothread.
-
-Note this list excludes the QEMU main loop thread, which is not declared
-using the -object iothread command-line option.  It is always the main t=
hread
-of the process.
-
-Return a json-array. Each iothread is represented by a json-object, whic=
h contains:
-
-- "id": name of iothread (json-str)
-- "thread-id": ID of the underlying host thread (json-int)
-
-Example:
-
--> { "execute": "query-iothreads" }
-<- {
-      "return":[
-         {
-            "id":"iothread0",
-            "thread-id":3134
-         },
-         {
-            "id":"iothread1",
-            "thread-id":3135
-         }
-      ]
-   }
-
-query-pci
----------
-
-PCI buses and devices information.
-
-The returned value is a json-array of all buses. Each bus is represented=
 by
-a json-object, which has a key with a json-array of all PCI devices atta=
ched
-to it. Each device is represented by a json-object.
-
-The bus json-object contains the following:
-
-- "bus": bus number (json-int)
-- "devices": a json-array of json-objects, each json-object represents a
-             PCI device
-
-The PCI device json-object contains the following:
-
-- "bus": identical to the parent's bus number (json-int)
-- "slot": slot number (json-int)
-- "function": function number (json-int)
-- "class_info": a json-object containing:
-     - "desc": device class description (json-string, optional)
-     - "class": device class number (json-int)
-- "id": a json-object containing:
-     - "device": device ID (json-int)
-     - "vendor": vendor ID (json-int)
-- "irq": device's IRQ if assigned (json-int, optional)
-- "qdev_id": qdev id string (json-string)
-- "pci_bridge": It's a json-object, only present if this device is a
-                PCI bridge, contains:
-     - "bus": bus number (json-int)
-     - "secondary": secondary bus number (json-int)
-     - "subordinate": subordinate bus number (json-int)
-     - "io_range": I/O memory range information, a json-object with the
-                   following members:
-                 - "base": base address, in bytes (json-int)
-                 - "limit": limit address, in bytes (json-int)
-     - "memory_range": memory range information, a json-object with the
-                       following members:
-                 - "base": base address, in bytes (json-int)
-                 - "limit": limit address, in bytes (json-int)
-     - "prefetchable_range": Prefetchable memory range information, a
-                             json-object with the following members:
-                 - "base": base address, in bytes (json-int)
-                 - "limit": limit address, in bytes (json-int)
-     - "devices": a json-array of PCI devices if there's any attached, e=
ach
-                  each element is represented by a json-object, which co=
ntains
-                  the same members of the 'PCI device json-object' descr=
ibed
-                  above (optional)
-- "regions": a json-array of json-objects, each json-object represents a
-             memory region of this device
-
-The memory range json-object contains the following:
-
-- "base": base memory address (json-int)
-- "limit": limit value (json-int)
-
-The region json-object can be an I/O region or a memory region, an I/O r=
egion
-json-object contains the following:
-
-- "type": "io" (json-string, fixed)
-- "bar": BAR number (json-int)
-- "address": memory address (json-int)
-- "size": memory size (json-int)
-
-A memory region json-object contains the following:
-
-- "type": "memory" (json-string, fixed)
-- "bar": BAR number (json-int)
-- "address": memory address (json-int)
-- "size": memory size (json-int)
-- "mem_type_64": true or false (json-bool)
-- "prefetch": true or false (json-bool)
-
-Example:
-
--> { "execute": "query-pci" }
-<- {
-      "return":[
-         {
-            "bus":0,
-            "devices":[
-               {
-                  "bus":0,
-                  "qdev_id":"",
-                  "slot":0,
-                  "class_info":{
-                     "class":1536,
-                     "desc":"Host bridge"
-                  },
-                  "id":{
-                     "device":32902,
-                     "vendor":4663
-                  },
-                  "function":0,
-                  "regions":[
-
-                  ]
-               },
-               {
-                  "bus":0,
-                  "qdev_id":"",
-                  "slot":1,
-                  "class_info":{
-                     "class":1537,
-                     "desc":"ISA bridge"
-                  },
-                  "id":{
-                     "device":32902,
-                     "vendor":28672
-                  },
-                  "function":0,
-                  "regions":[
-
-                  ]
-               },
-               {
-                  "bus":0,
-                  "qdev_id":"",
-                  "slot":1,
-                  "class_info":{
-                     "class":257,
-                     "desc":"IDE controller"
-                  },
-                  "id":{
-                     "device":32902,
-                     "vendor":28688
-                  },
-                  "function":1,
-                  "regions":[
-                     {
-                        "bar":4,
-                        "size":16,
-                        "address":49152,
-                        "type":"io"
-                     }
-                  ]
-               },
-               {
-                  "bus":0,
-                  "qdev_id":"",
-                  "slot":2,
-                  "class_info":{
-                     "class":768,
-                     "desc":"VGA controller"
-                  },
-                  "id":{
-                     "device":4115,
-                     "vendor":184
-                  },
-                  "function":0,
-                  "regions":[
-                     {
-                        "prefetch":true,
-                        "mem_type_64":false,
-                        "bar":0,
-                        "size":33554432,
-                        "address":4026531840,
-                        "type":"memory"
-                     },
-                     {
-                        "prefetch":false,
-                        "mem_type_64":false,
-                        "bar":1,
-                        "size":4096,
-                        "address":4060086272,
-                        "type":"memory"
-                     },
-                     {
-                        "prefetch":false,
-                        "mem_type_64":false,
-                        "bar":6,
-                        "size":65536,
-                        "address":-1,
-                        "type":"memory"
-                     }
-                  ]
-               },
-               {
-                  "bus":0,
-                  "qdev_id":"",
-                  "irq":11,
-                  "slot":4,
-                  "class_info":{
-                     "class":1280,
-                     "desc":"RAM controller"
-                  },
-                  "id":{
-                     "device":6900,
-                     "vendor":4098
-                  },
-                  "function":0,
-                  "regions":[
-                     {
-                        "bar":0,
-                        "size":32,
-                        "address":49280,
-                        "type":"io"
-                     }
-                  ]
-               }
-            ]
-         }
-      ]
-   }
-
-Note: This example has been shortened as the real response is too long.
-
-query-kvm
----------
-
-Show KVM information.
-
-Return a json-object with the following information:
-
-- "enabled": true if KVM support is enabled, false otherwise (json-bool)
-- "present": true if QEMU has KVM support, false otherwise (json-bool)
-
-Example:
-
--> { "execute": "query-kvm" }
-<- { "return": { "enabled": true, "present": true } }
-
-query-status
-------------
-
-Return a json-object with the following information:
-
-- "running": true if the VM is running, or false if it is paused (json-b=
ool)
-- "singlestep": true if the VM is in single step mode,
-                false otherwise (json-bool)
-- "status": one of the following values (json-string)
-    "debug" - QEMU is running on a debugger
-    "inmigrate" - guest is paused waiting for an incoming migration
-    "internal-error" - An internal error that prevents further guest
-    execution has occurred
-    "io-error" - the last IOP has failed and the device is configured
-    to pause on I/O errors
-    "paused" - guest has been paused via the 'stop' command
-    "postmigrate" - guest is paused following a successful 'migrate'
-    "prelaunch" - QEMU was started with -S and guest has not started
-    "finish-migrate" - guest is paused to finish the migration process
-    "restore-vm" - guest is paused to restore VM state
-    "running" - guest is actively running
-    "save-vm" - guest is paused to save the VM state
-    "shutdown" - guest is shut down (and -no-shutdown is in use)
-    "watchdog" - the watchdog action is configured to pause and
-     has been triggered
-
-Example:
-
--> { "execute": "query-status" }
-<- { "return": { "running": true, "singlestep": false, "status": "runnin=
g" } }
-
-query-mice
-----------
-
-Show VM mice information.
-
-Each mouse is represented by a json-object, the returned value is a json=
-array
-of all mice.
-
-The mouse json-object contains the following:
-
-- "name": mouse's name (json-string)
-- "index": mouse's index (json-int)
-- "current": true if this mouse is receiving events, false otherwise (js=
on-bool)
-- "absolute": true if the mouse generates absolute input events (json-bo=
ol)
-
-Example:
-
--> { "execute": "query-mice" }
-<- {
-      "return":[
-         {
-            "name":"QEMU Microsoft Mouse",
-            "index":0,
-            "current":false,
-            "absolute":false
-         },
-         {
-            "name":"QEMU PS/2 Mouse",
-            "index":1,
-            "current":true,
-            "absolute":true
-         }
-      ]
-   }
-
-query-vnc
----------
-
-Show VNC server information.
-
-Return a json-object with server information. Connected clients are retu=
rned
-as a json-array of json-objects.
-
-The main json-object contains the following:
-
-- "enabled": true or false (json-bool)
-- "host": server's IP address (json-string)
-- "family": address family (json-string)
-         - Possible values: "ipv4", "ipv6", "unix", "unknown"
-- "service": server's port number (json-string)
-- "auth": authentication method (json-string)
-         - Possible values: "invalid", "none", "ra2", "ra2ne", "sasl", "=
tight",
-                            "tls", "ultra", "unknown", "vencrypt", "venc=
rypt",
-                            "vencrypt+plain", "vencrypt+tls+none",
-                            "vencrypt+tls+plain", "vencrypt+tls+sasl",
-                            "vencrypt+tls+vnc", "vencrypt+x509+none",
-                            "vencrypt+x509+plain", "vencrypt+x509+sasl",
-                            "vencrypt+x509+vnc", "vnc"
-- "clients": a json-array of all connected clients
-
-Clients are described by a json-object, each one contain the following:
-
-- "host": client's IP address (json-string)
-- "family": address family (json-string)
-         - Possible values: "ipv4", "ipv6", "unix", "unknown"
-- "service": client's port number (json-string)
-- "x509_dname": TLS dname (json-string, optional)
-- "sasl_username": SASL username (json-string, optional)
-
-Example:
-
--> { "execute": "query-vnc" }
-<- {
-      "return":{
-         "enabled":true,
-         "host":"0.0.0.0",
-         "service":"50402",
-         "auth":"vnc",
-         "family":"ipv4",
-         "clients":[
-            {
-               "host":"127.0.0.1",
-               "service":"50401",
-               "family":"ipv4"
-            }
-         ]
-      }
-   }
-
-query-spice
------------
-
-Show SPICE server information.
-
-Return a json-object with server information. Connected clients are retu=
rned
-as a json-array of json-objects.
-
-The main json-object contains the following:
-
-- "enabled": true or false (json-bool)
-- "host": server's IP address (json-string)
-- "port": server's port number (json-int, optional)
-- "tls-port": server's port number (json-int, optional)
-- "auth": authentication method (json-string)
-         - Possible values: "none", "spice"
-- "channels": a json-array of all active channels clients
-
-Channels are described by a json-object, each one contain the following:
-
-- "host": client's IP address (json-string)
-- "family": address family (json-string)
-         - Possible values: "ipv4", "ipv6", "unix", "unknown"
-- "port": client's port number (json-string)
-- "connection-id": spice connection id.  All channels with the same id
-                   belong to the same spice session (json-int)
-- "channel-type": channel type.  "1" is the main control channel, filter=
 for
-                  this one if you want track spice sessions only (json-i=
nt)
-- "channel-id": channel id.  Usually "0", might be different needed when
-                multiple channels of the same type exist, such as multip=
le
-                display channels in a multihead setup (json-int)
-- "tls": whether the channel is encrypted (json-bool)
-
-Example:
-
--> { "execute": "query-spice" }
-<- {
-      "return": {
-         "enabled": true,
-         "auth": "spice",
-         "port": 5920,
-         "tls-port": 5921,
-         "host": "0.0.0.0",
-         "channels": [
-            {
-               "port": "54924",
-               "family": "ipv4",
-               "channel-type": 1,
-               "connection-id": 1804289383,
-               "host": "127.0.0.1",
-               "channel-id": 0,
-               "tls": true
-            },
-            {
-               "port": "36710",
-               "family": "ipv4",
-               "channel-type": 4,
-               "connection-id": 1804289383,
-               "host": "127.0.0.1",
-               "channel-id": 0,
-               "tls": false
-            },
-            [ ... more channels follow ... ]
-         ]
-      }
-   }
-
-query-name
-----------
-
-Show VM name.
-
-Return a json-object with the following information:
-
-- "name": VM's name (json-string, optional)
-
-Example:
-
--> { "execute": "query-name" }
-<- { "return": { "name": "qemu-name" } }
-
-query-uuid
-----------
-
-Show VM UUID.
-
-Return a json-object with the following information:
-
-- "UUID": Universally Unique Identifier (json-string)
-
-Example:
-
--> { "execute": "query-uuid" }
-<- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
-
-query-command-line-options
---------------------------
-
-Show command line option schema.
-
-Return a json-array of command line option schema for all options (or fo=
r
-the given option), returning an error if the given option doesn't exist.
-
-Each array entry contains the following:
-
-- "option": option name (json-string)
-- "parameters": a json-array describes all parameters of the option:
-    - "name": parameter name (json-string)
-    - "type": parameter type (one of 'string', 'boolean', 'number',
-              or 'size')
-    - "help": human readable description of the parameter
-              (json-string, optional)
-    - "default": default value string for the parameter
-                 (json-string, optional)
-
-Example:
-
--> { "execute": "query-command-line-options", "arguments": { "option": "=
option-rom" } }
-<- { "return": [
-        {
-            "parameters": [
-                {
-                    "name": "romfile",
-                    "type": "string"
-                },
-                {
-                    "name": "bootindex",
-                    "type": "number"
-                }
-            ],
-            "option": "option-rom"
-        }
-     ]
-   }
-
-query-migrate
--------------
-
-Migration status.
-
-Return a json-object. If migration is active there will be another json-=
object
-with RAM migration status and if block migration is active another one w=
ith
-block migration status.
-
-The main json-object contains the following:
-
-- "status": migration status (json-string)
-     - Possible values: "setup", "active", "completed", "failed", "cance=
lled"
-- "total-time": total amount of ms since migration started.  If
-                migration has ended, it returns the total migration
-                time (json-int)
-- "setup-time" amount of setup time in milliseconds _before_ the
-               iterations begin but _after_ the QMP command is issued.
-               This is designed to provide an accounting of any activiti=
es
-               (such as RDMA pinning) which may be expensive, but do not
-               actually occur during the iterative migration rounds
-               themselves. (json-int)
-- "downtime": only present when migration has finished correctly
-              total amount in ms for downtime that happened (json-int)
-- "expected-downtime": only present while migration is active
-                total amount in ms for downtime that was calculated on
-                the last bitmap round (json-int)
-- "ram": only present if "status" is "active", it is a json-object with =
the
-  following RAM information:
-         - "transferred": amount transferred in bytes (json-int)
-         - "remaining": amount remaining to transfer in bytes (json-int)
-         - "total": total amount of memory in bytes (json-int)
-         - "duplicate": number of pages filled entirely with the same
-            byte (json-int)
-            These are sent over the wire much more efficiently.
-         - "skipped": number of skipped zero pages (json-int)
-         - "normal" : number of whole pages transferred.  I.e. they
-            were not sent as duplicate or xbzrle pages (json-int)
-         - "normal-bytes" : number of bytes transferred in whole
-            pages. This is just normal pages times size of one page,
-            but this way upper levels don't need to care about page
-            size (json-int)
-         - "dirty-sync-count": times that dirty ram was synchronized (js=
on-int)
-- "disk": only present if "status" is "active" and it is a block migrati=
on,
-  it is a json-object with the following disk information:
-         - "transferred": amount transferred in bytes (json-int)
-         - "remaining": amount remaining to transfer in bytes json-int)
-         - "total": total disk size in bytes (json-int)
-- "xbzrle-cache": only present if XBZRLE is active.
-  It is a json-object with the following XBZRLE information:
-         - "cache-size": XBZRLE cache size in bytes
-         - "bytes": number of bytes transferred for XBZRLE compressed pa=
ges
-         - "pages": number of XBZRLE compressed pages
-         - "cache-miss": number of XBRZRLE page cache misses
-         - "cache-miss-rate": rate of XBRZRLE page cache misses
-         - "overflow": number of times XBZRLE overflows.  This means
-           that the XBZRLE encoding was bigger than just sent the
-           whole page, and then we sent the whole page instead (as as
-           normal page).
-
-Examples:
-
-1. Before the first migration
-
--> { "execute": "query-migrate" }
-<- { "return": {} }
-
-2. Migration is done and has succeeded
-
--> { "execute": "query-migrate" }
-<- { "return": {
-        "status": "completed",
-        "ram":{
-          "transferred":123,
-          "remaining":123,
-          "total":246,
-          "total-time":12345,
-          "setup-time":12345,
-          "downtime":12345,
-          "duplicate":123,
-          "normal":123,
-          "normal-bytes":123456,
-          "dirty-sync-count":15
-        }
-     }
-   }
-
-3. Migration is done and has failed
-
--> { "execute": "query-migrate" }
-<- { "return": { "status": "failed" } }
-
-4. Migration is being performed and is not a block migration:
-
--> { "execute": "query-migrate" }
-<- {
-      "return":{
-         "status":"active",
-         "ram":{
-            "transferred":123,
-            "remaining":123,
-            "total":246,
-            "total-time":12345,
-            "setup-time":12345,
-            "expected-downtime":12345,
-            "duplicate":123,
-            "normal":123,
-            "normal-bytes":123456,
-            "dirty-sync-count":15
-         }
-      }
-   }
-
-5. Migration is being performed and is a block migration:
-
--> { "execute": "query-migrate" }
-<- {
-      "return":{
-         "status":"active",
-         "ram":{
-            "total":1057024,
-            "remaining":1053304,
-            "transferred":3720,
-            "total-time":12345,
-            "setup-time":12345,
-            "expected-downtime":12345,
-            "duplicate":123,
-            "normal":123,
-            "normal-bytes":123456,
-            "dirty-sync-count":15
-         },
-         "disk":{
-            "total":20971520,
-            "remaining":20880384,
-            "transferred":91136
-         }
-      }
-   }
-
-6. Migration is being performed and XBZRLE is active:
-
--> { "execute": "query-migrate" }
-<- {
-      "return":{
-         "status":"active",
-         "capabilities" : [ { "capability": "xbzrle", "state" : true } ]=
,
-         "ram":{
-            "total":1057024,
-            "remaining":1053304,
-            "transferred":3720,
-            "total-time":12345,
-            "setup-time":12345,
-            "expected-downtime":12345,
-            "duplicate":10,
-            "normal":3333,
-            "normal-bytes":3412992,
-            "dirty-sync-count":15
-         },
-         "xbzrle-cache":{
-            "cache-size":67108864,
-            "bytes":20971520,
-            "pages":2444343,
-            "cache-miss":2244,
-            "cache-miss-rate":0.123,
-            "overflow":34434
-         }
-      }
-   }
-
-migrate-set-capabilities
-------------------------
-
-Enable/Disable migration capabilities
-
-- "xbzrle": XBZRLE support
-- "rdma-pin-all": pin all pages when using RDMA during migration
-- "auto-converge": throttle down guest to help convergence of migration
-- "zero-blocks": compress zero blocks during block migration
-- "compress": use multiple compression threads to accelerate live migrat=
ion
-- "events": generate events for each migration state change
-- "postcopy-ram": postcopy mode for live migration
-- "x-colo": COarse-Grain LOck Stepping (COLO) for Non-stop Service
-
-Arguments:
-
-Example:
-
--> { "execute": "migrate-set-capabilities" , "arguments":
-     { "capabilities": [ { "capability": "xbzrle", "state": true } ] } }
-
-query-migrate-capabilities
---------------------------
-
-Query current migration capabilities
-
-- "capabilities": migration capabilities state
-         - "xbzrle" : XBZRLE state (json-bool)
-         - "rdma-pin-all" : RDMA Pin Page state (json-bool)
-         - "auto-converge" : Auto Converge state (json-bool)
-         - "zero-blocks" : Zero Blocks state (json-bool)
-         - "compress": Multiple compression threads state (json-bool)
-         - "events": Migration state change event state (json-bool)
-         - "postcopy-ram": postcopy ram state (json-bool)
-         - "x-colo": COarse-Grain LOck Stepping for Non-stop Service (js=
on-bool)
-
-Arguments:
-
-Example:
-
--> { "execute": "query-migrate-capabilities" }
-<- {"return": [
-     {"state": false, "capability": "xbzrle"},
-     {"state": false, "capability": "rdma-pin-all"},
-     {"state": false, "capability": "auto-converge"},
-     {"state": false, "capability": "zero-blocks"},
-     {"state": false, "capability": "compress"},
-     {"state": true, "capability": "events"},
-     {"state": false, "capability": "postcopy-ram"},
-     {"state": false, "capability": "x-colo"}
-   ]}
-
-migrate-set-parameters
-----------------------
-
-Set migration parameters
-
-- "compress-level": set compression level during migration (json-int)
-- "compress-threads": set compression thread count for migration (json-i=
nt)
-- "decompress-threads": set decompression thread count for migration (js=
on-int)
-- "cpu-throttle-initial": set initial percentage of time guest cpus are
-                          throttled for auto-converge (json-int)
-- "cpu-throttle-increment": set throttle increasing percentage for
-                            auto-converge (json-int)
-- "max-bandwidth": set maximum speed for migrations (in bytes/sec) (json=
-int)
-- "downtime-limit": set maximum tolerated downtime (in milliseconds) for
-                    migrations (json-int)
-- "x-checkpoint-delay": set the delay time for periodic checkpoint (json=
-int)
-
-Arguments:
-
-Example:
-
--> { "execute": "migrate-set-parameters" , "arguments":
-      { "compress-level": 1 } }
-
-query-migrate-parameters
-------------------------
-
-Query current migration parameters
-
-- "parameters": migration parameters value
-         - "compress-level" : compression level value (json-int)
-         - "compress-threads" : compression thread count value (json-int=
)
-         - "decompress-threads" : decompression thread count value (json=
-int)
-         - "cpu-throttle-initial" : initial percentage of time guest cpu=
s are
-                                    throttled (json-int)
-         - "cpu-throttle-increment" : throttle increasing percentage for
-                                      auto-converge (json-int)
-         - "max-bandwidth" : maximium migration speed in bytes per secon=
d
-                             (json-int)
-         - "downtime-limit" : maximum tolerated downtime of migration in
-                              milliseconds (json-int)
-Arguments:
-
-Example:
-
--> { "execute": "query-migrate-parameters" }
-<- {
-      "return": {
-         "decompress-threads": 2,
-         "cpu-throttle-increment": 10,
-         "compress-threads": 8,
-         "compress-level": 1,
-         "cpu-throttle-initial": 20,
-         "max-bandwidth": 33554432,
-         "downtime-limit": 300
-      }
-   }
-
-query-balloon
--------------
-
-Show balloon information.
-
-Make an asynchronous request for balloon info. When the request complete=
s a
-json-object will be returned containing the following data:
-
-- "actual": current balloon value in bytes (json-int)
-
-Example:
-
--> { "execute": "query-balloon" }
-<- {
-      "return":{
-         "actual":1073741824,
-      }
-   }
-
-query-tpm
----------
-
-Return information about the TPM device.
-
-Arguments: None
-
-Example:
-
--> { "execute": "query-tpm" }
-<- { "return":
-     [
-       { "model": "tpm-tis",
-         "options":
-           { "type": "passthrough",
-             "data":
-               { "cancel-path": "/sys/class/misc/tpm0/device/cancel",
-                 "path": "/dev/tpm0"
-               }
-           },
-         "id": "tpm0"
-       }
-     ]
-   }
-
-query-tpm-models
-----------------
-
-Return a list of supported TPM models.
-
-Arguments: None
-
-Example:
-
--> { "execute": "query-tpm-models" }
-<- { "return": [ "tpm-tis" ] }
-
-query-tpm-types
----------------
-
-Return a list of supported TPM types.
-
-Arguments: None
-
-Example:
-
--> { "execute": "query-tpm-types" }
-<- { "return": [ "passthrough" ] }
-
-chardev-add
-----------------
-
-Add a chardev.
-
-Arguments:
-
-- "id": the chardev's ID, must be unique (json-string)
-- "backend": chardev backend type + parameters
-
-Examples:
-
--> { "execute" : "chardev-add",
-     "arguments" : { "id" : "foo",
-                     "backend" : { "type" : "null", "data" : {} } } }
-<- { "return": {} }
-
--> { "execute" : "chardev-add",
-     "arguments" : { "id" : "bar",
-                     "backend" : { "type" : "file",
-                                   "data" : { "out" : "/tmp/bar.log" } }=
 } }
-<- { "return": {} }
-
--> { "execute" : "chardev-add",
-     "arguments" : { "id" : "baz",
-                     "backend" : { "type" : "pty", "data" : {} } } }
-<- { "return": { "pty" : "/dev/pty/42" } }
-
-chardev-remove
---------------
-
-Remove a chardev.
-
-Arguments:
-
-- "id": the chardev's ID, must exist and not be in use (json-string)
-
-Example:
-
--> { "execute": "chardev-remove", "arguments": { "id" : "foo" } }
-<- { "return": {} }
-
-query-rx-filter
----------------
-
-Show rx-filter information.
-
-Returns a json-array of rx-filter information for all NICs (or for the
-given NIC), returning an error if the given NIC doesn't exist, or
-given NIC doesn't support rx-filter querying, or given net client
-isn't a NIC.
-
-The query will clear the event notification flag of each NIC, then qemu
-will start to emit event to QMP monitor.
-
-Each array entry contains the following:
-
-- "name": net client name (json-string)
-- "promiscuous": promiscuous mode is enabled (json-bool)
-- "multicast": multicast receive state (one of 'normal', 'none', 'all')
-- "unicast": unicast receive state  (one of 'normal', 'none', 'all')
-- "vlan": vlan receive state (one of 'normal', 'none', 'all') (Since 2.0=
)
-- "broadcast-allowed": allow to receive broadcast (json-bool)
-- "multicast-overflow": multicast table is overflowed (json-bool)
-- "unicast-overflow": unicast table is overflowed (json-bool)
-- "main-mac": main macaddr string (json-string)
-- "vlan-table": a json-array of active vlan id
-- "unicast-table": a json-array of unicast macaddr string
-- "multicast-table": a json-array of multicast macaddr string
-
-Example:
-
--> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
-<- { "return": [
-        {
-            "promiscuous": true,
-            "name": "vnet0",
-            "main-mac": "52:54:00:12:34:56",
-            "unicast": "normal",
-            "vlan": "normal",
-            "vlan-table": [
-                4,
-                0
-            ],
-            "unicast-table": [
-            ],
-            "multicast": "normal",
-            "multicast-overflow": false,
-            "unicast-overflow": false,
-            "multicast-table": [
-                "01:00:5e:00:00:01",
-                "33:33:00:00:00:01",
-                "33:33:ff:12:34:56"
-            ],
-            "broadcast-allowed": false
-        }
-      ]
-   }
-
-blockdev-add
-------------
-
-Add a block device.
-
-This command is still a work in progress.  It doesn't support all
-block drivers among other things.  Stay away from it unless you want
-to help with its development.
-
-For the arguments, see the QAPI schema documentation of BlockdevOptions.
-
-Example (1):
-
--> { "execute": "blockdev-add",
-    "arguments": { "driver": "qcow2",
-                   "file": { "driver": "file",
-                             "filename": "test.qcow2" } } }
-<- { "return": {} }
-
-Example (2):
-
--> { "execute": "blockdev-add",
-     "arguments": {
-         "driver": "qcow2",
-         "node-name": "my_disk",
-         "discard": "unmap",
-         "cache": {
-             "direct": true,
-             "writeback": true
-         },
-         "file": {
-             "driver": "file",
-             "filename": "/tmp/test.qcow2"
-         },
-         "backing": {
-             "driver": "raw",
-             "file": {
-                 "driver": "file",
-                 "filename": "/dev/fdset/4"
-             }
-         }
-       }
-     }
-
-<- { "return": {} }
-
-x-blockdev-del
-------------
-Since 2.5
-
-Deletes a block device that has been added using blockdev-add.
-The command will fail if the node is attached to a device or is
-otherwise being used.
-
-This command is still a work in progress and is considered
-experimental. Stay away from it unless you want to help with its
-development.
-
-Arguments:
-
-- "node-name": Name of the graph node to delete (json-string)
-
-Example:
-
--> { "execute": "blockdev-add",
-     "arguments": {
-         "driver": "qcow2",
-         "node-name": "node0",
-         "file": {
-             "driver": "file",
-             "filename": "test.qcow2"
-         }
-     }
-   }
-
-<- { "return": {} }
-
--> { "execute": "x-blockdev-del",
-     "arguments": { "node-name": "node0" }
-   }
-<- { "return": {} }
-
-blockdev-open-tray
-------------------
-
-Opens a block device's tray. If there is a block driver state tree inser=
ted as a
-medium, it will become inaccessible to the guest (but it will remain ass=
ociated
-to the block device, so closing the tray will make it accessible again).
-
-If the tray was already open before, this will be a no-op.
-
-Once the tray opens, a DEVICE_TRAY_MOVED event is emitted. There are cas=
es in
-which no such event will be generated, these include:
-- if the guest has locked the tray, @force is false and the guest does n=
ot
-  respond to the eject request
-- if the BlockBackend denoted by @device does not have a guest device at=
tached
-  to it
-- if the guest device does not have an actual tray and is empty, for ins=
tance
-  for floppy disk drives
-
-Arguments:
-
-- "device": block device name (deprecated, use @id instead)
-            (json-string, optional)
-- "id": the name or QOM path of the guest device (json-string, optional)
-- "force": if false (the default), an eject request will be sent to the =
guest if
-           it has locked the tray (and the tray will not be opened immed=
iately);
-           if true, the tray will be opened regardless of whether it is =
locked
-           (json-bool, optional)
-
-Example:
-
--> { "execute": "blockdev-open-tray",
-     "arguments": { "id": "ide0-1-0" } }
-
-<- { "timestamp": { "seconds": 1418751016,
-                    "microseconds": 716996 },
-     "event": "DEVICE_TRAY_MOVED",
-     "data": { "device": "ide1-cd0",
-               "id": "ide0-1-0",
-               "tray-open": true } }
-
-<- { "return": {} }
-
-blockdev-close-tray
--------------------
-
-Closes a block device's tray. If there is a block driver state tree asso=
ciated
-with the block device (which is currently ejected), that tree will be lo=
aded as
-the medium.
-
-If the tray was already closed before, this will be a no-op.
-
-Arguments:
-
-- "device": block device name (deprecated, use @id instead)
-            (json-string, optional)
-- "id": the name or QOM path of the guest device (json-string, optional)
-
-Example:
-
--> { "execute": "blockdev-close-tray",
-     "arguments": { "id": "ide0-1-0" } }
-
-<- { "timestamp": { "seconds": 1418751345,
-                    "microseconds": 272147 },
-     "event": "DEVICE_TRAY_MOVED",
-     "data": { "device": "ide1-cd0",
-               "id": "ide0-1-0",
-               "tray-open": false } }
-
-<- { "return": {} }
-
-x-blockdev-remove-medium
-------------------------
-
-Removes a medium (a block driver state tree) from a block device. That b=
lock
-device's tray must currently be open (unless there is no attached guest =
device).
-
-If the tray is open and there is no medium inserted, this will be a no-o=
p.
-
-This command is still a work in progress and is considered experimental.
-Stay away from it unless you want to help with its development.
-
-Arguments:
-
-- "device": block device name (deprecated, use @id instead)
-            (json-string, optional)
-- "id": the name or QOM path of the guest device (json-string, optional)
-
-Example:
-
--> { "execute": "x-blockdev-remove-medium",
-     "arguments": { "id": "ide0-1-0" } }
-
-<- { "error": { "class": "GenericError",
-                "desc": "Tray of device 'ide0-1-0' is not open" } }
-
--> { "execute": "blockdev-open-tray",
-     "arguments": { "id": "ide0-1-0" } }
-
-<- { "timestamp": { "seconds": 1418751627,
-                    "microseconds": 549958 },
-     "event": "DEVICE_TRAY_MOVED",
-     "data": { "device": "ide1-cd0",
-               "id": "ide0-1-0",
-               "tray-open": true } }
-
-<- { "return": {} }
-
--> { "execute": "x-blockdev-remove-medium",
-     "arguments": { "device": "ide0-1-0" } }
-
-<- { "return": {} }
-
-x-blockdev-insert-medium
-------------------------
-
-Inserts a medium (a block driver state tree) into a block device. That b=
lock
-device's tray must currently be open (unless there is no attached guest =
device)
-and there must be no medium inserted already.
-
-This command is still a work in progress and is considered experimental.
-Stay away from it unless you want to help with its development.
-
-Arguments:
-
-- "device": block device name (deprecated, use @id instead)
-            (json-string, optional)
-- "id": the name or QOM path of the guest device (json-string, optional)
-- "node-name": root node of the BDS tree to insert into the block device
-
-Example:
-
--> { "execute": "blockdev-add",
-     "arguments": { { "node-name": "node0",
-                      "driver": "raw",
-                      "file": { "driver": "file",
-                                "filename": "fedora.iso" } } }
-
-<- { "return": {} }
-
--> { "execute": "x-blockdev-insert-medium",
-     "arguments": { "id": "ide0-1-0",
-                    "node-name": "node0" } }
-
-<- { "return": {} }
-
-x-blockdev-change
------------------
-
-Dynamically reconfigure the block driver state graph. It can be used
-to add, remove, insert or replace a graph node. Currently only the
-Quorum driver implements this feature to add or remove its child. This
-is useful to fix a broken quorum child.
-
-If @node is specified, it will be inserted under @parent. @child
-may not be specified in this case. If both @parent and @child are
-specified but @node is not, @child will be detached from @parent.
-
-Arguments:
-- "parent": the id or name of the parent node (json-string)
-- "child": the name of a child under the given parent node (json-string,=
 optional)
-- "node": the name of the node that will be added (json-string, optional=
)
-
-Note: this command is experimental, and not a stable API. It doesn't
-support all kinds of operations, all kinds of children, nor all block
-drivers.
-
-Warning: The data in a new quorum child MUST be consistent with that of
-the rest of the array.
-
-Example:
-
-Add a new node to a quorum
--> { "execute": "blockdev-add",
-     "arguments": { "driver": "raw",
-                    "node-name": "new_node",
-                    "file": { "driver": "file",
-                              "filename": "test.raw" } } }
-<- { "return": {} }
--> { "execute": "x-blockdev-change",
-     "arguments": { "parent": "disk1",
-                    "node": "new_node" } }
-<- { "return": {} }
-
-Delete a quorum's node
--> { "execute": "x-blockdev-change",
-     "arguments": { "parent": "disk1",
-                    "child": "children.1" } }
-<- { "return": {} }
-
-query-named-block-nodes
------------------------
-
-Return a list of BlockDeviceInfo for all the named block driver nodes
-
-Example:
-
--> { "execute": "query-named-block-nodes" }
-<- { "return": [ { "ro":false,
-                   "drv":"qcow2",
-                   "encrypted":false,
-                   "file":"disks/test.qcow2",
-                   "node-name": "my-node",
-                   "backing_file_depth":1,
-                   "bps":1000000,
-                   "bps_rd":0,
-                   "bps_wr":0,
-                   "iops":1000000,
-                   "iops_rd":0,
-                   "iops_wr":0,
-                   "bps_max": 8000000,
-                   "bps_rd_max": 0,
-                   "bps_wr_max": 0,
-                   "iops_max": 0,
-                   "iops_rd_max": 0,
-                   "iops_wr_max": 0,
-                   "iops_size": 0,
-                   "write_threshold": 0,
-                   "image":{
-                      "filename":"disks/test.qcow2",
-                      "format":"qcow2",
-                      "virtual-size":2048000,
-                      "backing_file":"base.qcow2",
-                      "full-backing-filename":"disks/base.qcow2",
-                      "backing-filename-format":"qcow2",
-                      "snapshots":[
-                         {
-                            "id": "1",
-                            "name": "snapshot1",
-                            "vm-state-size": 0,
-                            "date-sec": 10000200,
-                            "date-nsec": 12,
-                            "vm-clock-sec": 206,
-                            "vm-clock-nsec": 30
-                         }
-                      ],
-                      "backing-image":{
-                          "filename":"disks/base.qcow2",
-                          "format":"qcow2",
-                          "virtual-size":2048000
-                      }
-                   } } ] }
-
-blockdev-change-medium
-----------------------
-
-Changes the medium inserted into a block device by ejecting the current =
medium
-and loading a new image file which is inserted as the new medium.
-
-Arguments:
-
-- "device": block device name (deprecated, use @id instead)
-            (json-string, optional)
-- "id": the name or QOM path of the guest device (json-string, optional)
-- "filename": filename of the new image (json-string)
-- "format": format of the new image (json-string, optional)
-- "read-only-mode": new read-only mode (json-string, optional)
-          - Possible values: "retain" (default), "read-only", "read-writ=
e"
-
-Examples:
-
-1. Change a removable medium
-
--> { "execute": "blockdev-change-medium",
-             "arguments": { "id": "ide0-1-0",
-                            "filename": "/srv/images/Fedora-12-x86_64-DV=
D.iso",
-                            "format": "raw" } }
-<- { "return": {} }
-
-2. Load a read-only medium into a writable drive
-
--> { "execute": "blockdev-change-medium",
-             "arguments": { "id": "floppyA",
-                            "filename": "/srv/images/ro.img",
-                            "format": "raw",
-                            "read-only-mode": "retain" } }
-
-<- { "error":
-     { "class": "GenericError",
-       "desc": "Could not open '/srv/images/ro.img': Permission denied" =
} }
-
--> { "execute": "blockdev-change-medium",
-             "arguments": { "id": "floppyA",
-                            "filename": "/srv/images/ro.img",
-                            "format": "raw",
-                            "read-only-mode": "read-only" } }
-
-<- { "return": {} }
-
-query-memdev
-------------
-
-Show memory devices information.
-
-
-Example (1):
-
--> { "execute": "query-memdev" }
-<- { "return": [
-       {
-         "size": 536870912,
-         "merge": false,
-         "dump": true,
-         "prealloc": false,
-         "host-nodes": [0, 1],
-         "policy": "bind"
-       },
-       {
-         "size": 536870912,
-         "merge": false,
-         "dump": true,
-         "prealloc": true,
-         "host-nodes": [2, 3],
-         "policy": "preferred"
-       }
-     ]
-   }
-
-query-memory-devices
---------------------
-
-Return a list of memory devices.
-
-Example:
--> { "execute": "query-memory-devices" }
-<- { "return": [ { "data":
-                      { "addr": 5368709120,
-                        "hotpluggable": true,
-                        "hotplugged": true,
-                        "id": "d1",
-                        "memdev": "/objects/memX",
-                        "node": 0,
-                        "size": 1073741824,
-                        "slot": 0},
-                   "type": "dimm"
-                 } ] }
-
-query-acpi-ospm-status
-----------------------
-
-Return list of ACPIOSTInfo for devices that support status reporting
-via ACPI _OST method.
-
-Example:
--> { "execute": "query-acpi-ospm-status" }
-<- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "so=
urce": 1, "status": 0},
-                 { "slot": "1", "slot-type": "DIMM", "source": 0, "statu=
s": 0},
-                 { "slot": "2", "slot-type": "DIMM", "source": 0, "statu=
s": 0},
-                 { "slot": "3", "slot-type": "DIMM", "source": 0, "statu=
s": 0}
-   ]}
-
-rtc-reset-reinjection
----------------------
-
-Reset the RTC interrupt reinjection backlog.
-
-Arguments: None.
-
-Example:
-
--> { "execute": "rtc-reset-reinjection" }
-<- { "return": {} }
-
-trace-event-get-state
----------------------
-
-Query the state of events.
-
-Arguments:
-
-- "name": Event name pattern (json-string).
-- "vcpu": The vCPU to query, any vCPU by default (json-int, optional).
-
-An event is returned if:
-- its name matches the "name" pattern, and
-- if "vcpu" is given, the event has the "vcpu" property.
-
-Therefore, if "vcpu" is given, the operation will only match per-vCPU ev=
ents,
-returning their state on the specified vCPU. Special case: if "name" is =
an exact
-match, "vcpu" is given and the event does not have the "vcpu" property, =
an error
-is returned.
-
-Example:
-
--> { "execute": "trace-event-get-state", "arguments": { "name": "qemu_me=
malign" } }
-<- { "return": [ { "name": "qemu_memalign", "state": "disabled" } ] }
-
-trace-event-set-state
----------------------
-
-Set the state of events.
-
-Arguments:
-
-- "name": Event name pattern (json-string).
-- "enable": Whether to enable or disable the event (json-bool).
-- "ignore-unavailable": Whether to ignore errors for events that cannot =
be
-  changed (json-bool, optional).
-- "vcpu": The vCPU to act upon, all vCPUs by default (json-int, optional=
).
-
-An event's state is modified if:
-- its name matches the "name" pattern, and
-- if "vcpu" is given, the event has the "vcpu" property.
-
-Therefore, if "vcpu" is given, the operation will only match per-vCPU ev=
ents,
-setting their state on the specified vCPU. Special case: if "name" is an=
 exact
-match, "vcpu" is given and the event does not have the "vcpu" property, =
an error
-is returned.
-
-Example:
-
--> { "execute": "trace-event-set-state", "arguments": { "name": "qemu_me=
malign", "enable": "true" } }
-<- { "return": {} }
-
-input-send-event
-----------------
-
-Send input event to guest.
-
-Arguments:
-
-- "device": display device (json-string, optional)
-- "head": display head (json-int, optional)
-- "events": list of input events
-
-The consoles are visible in the qom tree, under
-/backend/console[$index]. They have a device link and head property, so
-it is possible to map which console belongs to which device and display.
-
-Example (1):
-
-Press left mouse button.
-
--> { "execute": "input-send-event",
-    "arguments": { "device": "video0",
-                   "events": [ { "type": "btn",
-                   "data" : { "down": true, "button": "left" } } ] } }
-<- { "return": {} }
-
--> { "execute": "input-send-event",
-    "arguments": { "device": "video0",
-                   "events": [ { "type": "btn",
-                   "data" : { "down": false, "button": "left" } } ] } }
-<- { "return": {} }
-
-Example (2):
-
-Press ctrl-alt-del.
-
--> { "execute": "input-send-event",
-     "arguments": { "events": [
-        { "type": "key", "data" : { "down": true,
-          "key": {"type": "qcode", "data": "ctrl" } } },
-        { "type": "key", "data" : { "down": true,
-          "key": {"type": "qcode", "data": "alt" } } },
-        { "type": "key", "data" : { "down": true,
-          "key": {"type": "qcode", "data": "delete" } } } ] } }
-<- { "return": {} }
-
-Example (3):
-
-Move mouse pointer to absolute coordinates (20000, 400).
-
--> { "execute": "input-send-event" ,
-  "arguments": { "events": [
-               { "type": "abs", "data" : { "axis": "x", "value" : 20000 =
} },
-               { "type": "abs", "data" : { "axis": "y", "value" : 400 } =
} ] } }
-<- { "return": {} }
-
-block-set-write-threshold
-------------
-
-Change the write threshold for a block drive. The threshold is an offset=
,
-thus must be non-negative. Default is no write threshold.
-Setting the threshold to zero disables it.
-
-Arguments:
-
-- "node-name": the node name in the block driver state graph (json-strin=
g)
-- "write-threshold": the write threshold in bytes (json-int)
-
-Example:
-
--> { "execute": "block-set-write-threshold",
-  "arguments": { "node-name": "mydev",
-                 "write-threshold": 17179869184 } }
-<- { "return": {} }
-
-Show rocker switch
-------------------
-
-Arguments:
-
-- "name": switch name
-
-Example:
-
--> { "execute": "query-rocker", "arguments": { "name": "sw1" } }
-<- { "return": {"name": "sw1", "ports": 2, "id": 1327446905938}}
-
-Show rocker switch ports
-------------------------
-
-Arguments:
-
-- "name": switch name
-
-Example:
-
--> { "execute": "query-rocker-ports", "arguments": { "name": "sw1" } }
-<- { "return": [ {"duplex": "full", "enabled": true, "name": "sw1.1",
-                  "autoneg": "off", "link-up": true, "speed": 10000},
-                 {"duplex": "full", "enabled": true, "name": "sw1.2",
-                  "autoneg": "off", "link-up": true, "speed": 10000}
-   ]}
-
-Show rocker switch OF-DPA flow tables
--------------------------------------
-
-Arguments:
-
-- "name": switch name
-- "tbl-id": (optional) flow table ID
-
-Example:
-
--> { "execute": "query-rocker-of-dpa-flows", "arguments": { "name": "sw1=
" } }
-<- { "return": [ {"key": {"in-pport": 0, "priority": 1, "tbl-id": 0},
-                  "hits": 138,
-                  "cookie": 0,
-                  "action": {"goto-tbl": 10},
-                  "mask": {"in-pport": 4294901760}
-                 },
-                 {...more...},
-   ]}
-
-Show rocker OF-DPA group tables
--------------------------------
-
-Arguments:
-
-- "name": switch name
-- "type": (optional) group type
-
-Example:
-
--> { "execute": "query-rocker-of-dpa-groups", "arguments": { "name": "sw=
1" } }
-<- { "return": [ {"type": 0, "out-pport": 2, "pport": 2, "vlan-id": 3841=
,
-                  "pop-vlan": 1, "id": 251723778},
-                 {"type": 0, "out-pport": 0, "pport": 0, "vlan-id": 3841=
,
-                  "pop-vlan": 1, "id": 251723776},
-                 {"type": 0, "out-pport": 1, "pport": 1, "vlan-id": 3840=
,
-                  "pop-vlan": 1, "id": 251658241},
-                 {"type": 0, "out-pport": 0, "pport": 0, "vlan-id": 3840=
,
-                  "pop-vlan": 1, "id": 251658240}
-   ]}
-
-query-gic-capabilities
----------------
-
-Return a list of GICCapability objects, describing supported GIC
-(Generic Interrupt Controller) versions.
-
-Arguments: None
-
-Example:
-
--> { "execute": "query-gic-capabilities" }
-<- { "return": [{ "version": 2, "emulated": true, "kernel": false },
-                { "version": 3, "emulated": false, "kernel": true } ] }
-
-Show existing/possible CPUs
----------------------------
-
-Arguments: None.
-
-Example for pseries machine type started with
--smp 2,cores=3D2,maxcpus=3D4 -cpu POWER8:
-
--> { "execute": "query-hotpluggable-cpus" }
-<- {"return": [
-     { "props": { "core-id": 8 }, "type": "POWER8-spapr-cpu-core",
-       "vcpus-count": 1 },
-     { "props": { "core-id": 0 }, "type": "POWER8-spapr-cpu-core",
-       "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
-   ]}'
-
-Example for pc machine type started with
--smp 1,maxcpus=3D2:
-    -> { "execute": "query-hotpluggable-cpus" }
-    <- {"return": [
-         {
-            "type": "qemu64-x86_64-cpu", "vcpus-count": 1,
-            "props": {"core-id": 0, "socket-id": 1, "thread-id": 0}
-         },
-         {
-            "qom-path": "/machine/unattached/device[0]",
-            "type": "qemu64-x86_64-cpu", "vcpus-count": 1,
-            "props": {"core-id": 0, "socket-id": 0, "thread-id": 0}
-         }
-       ]}
diff --git a/docs/qmp-events.txt b/docs/qmp-events.txt
deleted file mode 100644
index e0a2365c63..0000000000
--- a/docs/qmp-events.txt
+++ /dev/null
@@ -1,731 +0,0 @@
-                   QEMU Machine Protocol Events
-                   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-ACPI_DEVICE_OST
----------------
-
-Emitted when guest executes ACPI _OST method.
-
- - data: ACPIOSTInfo type as described in qapi-schema.json
-
-{ "event": "ACPI_DEVICE_OST",
-     "data": { "device": "d1", "slot": "0", "slot-type": "DIMM", "source=
": 1, "status": 0 } }
-
-BALLOON_CHANGE
---------------
-
-Emitted when the guest changes the actual BALLOON level. This
-value is equivalent to the 'actual' field return by the
-'query-balloon' command
-
-Data:
-
-- "actual": actual level of the guest memory balloon in bytes (json-numb=
er)
-
-Example:
-
-{ "event": "BALLOON_CHANGE",
-    "data": { "actual": 944766976 },
-    "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
-
-Note: this event is rate-limited.
-
-BLOCK_IMAGE_CORRUPTED
----------------------
-
-Emitted when a disk image is being marked corrupt. The image can be
-identified by its device or node name. The 'device' field is always
-present for compatibility reasons, but it can be empty ("") if the
-image does not have a device name associated.
-
-Data:
-
-- "device":    Device name (json-string)
-- "node-name": Node name (json-string, optional)
-- "msg":       Informative message (e.g., reason for the corruption)
-               (json-string)
-- "offset":    If the corruption resulted from an image access, this
-               is the host's access offset into the image
-               (json-int, optional)
-- "size":      If the corruption resulted from an image access, this
-               is the access size (json-int, optional)
-
-Example:
-
-{ "event": "BLOCK_IMAGE_CORRUPTED",
-    "data": { "device": "ide0-hd0", "node-name": "node0",
-        "msg": "Prevented active L1 table overwrite", "offset": 196608,
-        "size": 65536 },
-    "timestamp": { "seconds": 1378126126, "microseconds": 966463 } }
-
-BLOCK_IO_ERROR
---------------
-
-Emitted when a disk I/O error occurs.
-
-Data:
-
-- "device": device name. This is always present for compatibility
-            reasons, but it can be empty ("") if the image does not
-            have a device name associated. (json-string)
-- "node-name": node name. Note that errors may be reported for the root =
node
-               that is directly attached to a guest device rather than f=
or the
-               node where the error occurred. (json-string)
-- "operation": I/O operation (json-string, "read" or "write")
-- "action": action that has been taken, it's one of the following (json-=
string):
-    "ignore": error has been ignored
-    "report": error has been reported to the device
-    "stop": the VM is going to stop because of the error
-
-Example:
-
-{ "event": "BLOCK_IO_ERROR",
-    "data": { "device": "ide0-hd1",
-              "node-name": "#block212",
-              "operation": "write",
-              "action": "stop" },
-    "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-
-Note: If action is "stop", a STOP event will eventually follow the
-BLOCK_IO_ERROR event.
-
-BLOCK_JOB_CANCELLED
--------------------
-
-Emitted when a block job has been cancelled.
-
-Data:
-
-- "type":     Job type (json-string; "stream" for image streaming
-                                     "commit" for block commit)
-- "device":   Job identifier. Originally the device name but other
-              values are allowed since QEMU 2.7 (json-string)
-- "len":      Maximum progress value (json-int)
-- "offset":   Current progress value (json-int)
-              On success this is equal to len.
-              On failure this is less than len.
-- "speed":    Rate limit, bytes per second (json-int)
-
-Example:
-
-{ "event": "BLOCK_JOB_CANCELLED",
-     "data": { "type": "stream", "device": "virtio-disk0",
-               "len": 10737418240, "offset": 134217728,
-               "speed": 0 },
-     "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
-
-BLOCK_JOB_COMPLETED
--------------------
-
-Emitted when a block job has completed.
-
-Data:
-
-- "type":     Job type (json-string; "stream" for image streaming
-                                     "commit" for block commit)
-- "device":   Job identifier. Originally the device name but other
-              values are allowed since QEMU 2.7 (json-string)
-- "len":      Maximum progress value (json-int)
-- "offset":   Current progress value (json-int)
-              On success this is equal to len.
-              On failure this is less than len.
-- "speed":    Rate limit, bytes per second (json-int)
-- "error":    Error message (json-string, optional)
-              Only present on failure.  This field contains a human-read=
able
-              error message.  There are no semantics other than that str=
eaming
-              has failed and clients should not try to interpret the err=
or
-              string.
-
-Example:
-
-{ "event": "BLOCK_JOB_COMPLETED",
-     "data": { "type": "stream", "device": "virtio-disk0",
-               "len": 10737418240, "offset": 10737418240,
-               "speed": 0 },
-     "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
-
-BLOCK_JOB_ERROR
----------------
-
-Emitted when a block job encounters an error.
-
-Data:
-
-- "device": Job identifier. Originally the device name but other
-            values are allowed since QEMU 2.7 (json-string)
-- "operation": I/O operation (json-string, "read" or "write")
-- "action": action that has been taken, it's one of the following (json-=
string):
-    "ignore": error has been ignored, the job may fail later
-    "report": error will be reported and the job canceled
-    "stop": error caused job to be paused
-
-Example:
-
-{ "event": "BLOCK_JOB_ERROR",
-    "data": { "device": "ide0-hd1",
-              "operation": "write",
-              "action": "stop" },
-    "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-
-BLOCK_JOB_READY
----------------
-
-Emitted when a block job is ready to complete.
-
-Data:
-
-- "type":     Job type (json-string; "stream" for image streaming
-                                     "commit" for block commit)
-- "device":   Job identifier. Originally the device name but other
-              values are allowed since QEMU 2.7 (json-string)
-- "len":      Maximum progress value (json-int)
-- "offset":   Current progress value (json-int)
-              On success this is equal to len.
-              On failure this is less than len.
-- "speed":    Rate limit, bytes per second (json-int)
-
-Example:
-
-{ "event": "BLOCK_JOB_READY",
-    "data": { "device": "drive0", "type": "mirror", "speed": 0,
-              "len": 2097152, "offset": 2097152 }
-    "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-
-Note: The "ready to complete" status is always reset by a BLOCK_JOB_ERRO=
R
-event.
-
-DEVICE_DELETED
---------------
-
-Emitted whenever the device removal completion is acknowledged
-by the guest.
-At this point, it's safe to reuse the specified device ID.
-Device removal can be initiated by the guest or by HMP/QMP commands.
-
-Data:
-
-- "device": device name (json-string, optional)
-- "path": device path (json-string)
-
-{ "event": "DEVICE_DELETED",
-  "data": { "device": "virtio-net-pci-0",
-            "path": "/machine/peripheral/virtio-net-pci-0" },
-  "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-
-DEVICE_TRAY_MOVED
------------------
-
-It's emitted whenever the tray of a removable device is moved by the gue=
st
-or by HMP/QMP commands.
-
-Data:
-
-- "device": Block device name. This is always present for compatibility
-            reasons, but it can be empty ("") if the image does not have=
 a
-            device name associated. (json-string)
-- "id": The name or QOM path of the guest device (json-string)
-- "tray-open": true if the tray has been opened or false if it has been =
closed
-               (json-bool)
-
-{ "event": "DEVICE_TRAY_MOVED",
-  "data": { "device": "ide1-cd0",
-            "id": "/machine/unattached/device[22]",
-            "tray-open": true
-  },
-  "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-
-DUMP_COMPLETED
---------------
-
-Emitted when the guest has finished one memory dump.
-
-Data:
-
-- "result": DumpQueryResult type described in qapi-schema.json
-- "error": Error message when dump failed. This is only a
-  human-readable string provided when dump failed. It should not be
-  parsed in any way (json-string, optional)
-
-Example:
-
-{ "event": "DUMP_COMPLETED",
-  "data": {"result": {"total": 1090650112, "status": "completed",
-                      "completed": 1090650112} } }
-
-GUEST_PANICKED
---------------
-
-Emitted when guest OS panic is detected.
-
-Data:
-
-- "action": Action that has been taken (json-string, currently always "p=
ause").
-
-Example:
-
-{ "event": "GUEST_PANICKED",
-     "data": { "action": "pause" } }
-
-MEM_UNPLUG_ERROR
---------------------
-Emitted when memory hot unplug error occurs.
-
-Data:
-
-- "device": device name (json-string)
-- "msg": Informative message (e.g., reason for the error) (json-string)
-
-Example:
-
-{ "event": "MEM_UNPLUG_ERROR"
-  "data": { "device": "dimm1",
-            "msg": "acpi: device unplug for unsupported device"
-  },
-  "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-
-NIC_RX_FILTER_CHANGED
----------------------
-
-The event is emitted once until the query command is executed,
-the first event will always be emitted.
-
-Data:
-
-- "name": net client name (json-string)
-- "path": device path (json-string)
-
-{ "event": "NIC_RX_FILTER_CHANGED",
-  "data": { "name": "vnet0",
-            "path": "/machine/peripheral/vnet0/virtio-backend" },
-  "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
-}
-
-POWERDOWN
----------
-
-Emitted when the Virtual Machine is powered down through the power
-control system, such as via ACPI.
-
-Data: None.
-
-Example:
-
-{ "event": "POWERDOWN",
-    "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
-
-QUORUM_FAILURE
---------------
-
-Emitted by the Quorum block driver if it fails to establish a quorum.
-
-Data:
-
-- "reference":     device name if defined else node name.
-- "sector-num":    Number of the first sector of the failed read operati=
on.
-- "sectors-count": Failed read operation sector count.
-
-Example:
-
-{ "event": "QUORUM_FAILURE",
-     "data": { "reference": "usr1", "sector-num": 345435, "sectors-count=
": 5 },
-     "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
-
-Note: this event is rate-limited.
-
-QUORUM_REPORT_BAD
------------------
-
-Emitted to report a corruption of a Quorum file.
-
-Data:
-
-- "type":          Quorum operation type
-- "error":         Error message (json-string, optional)
-                   Only present on failure.  This field contains a human=
-readable
-                   error message.  There are no semantics other than tha=
t the
-                   block layer reported an error and clients should not =
try to
-                   interpret the error string.
-- "node-name":     The graph node name of the block driver state.
-- "sector-num":    Number of the first sector of the failed read operati=
on.
-- "sectors-count": Failed read operation sector count.
-
-Example:
-
-Read operation:
-{ "event": "QUORUM_REPORT_BAD",
-     "data": { "node-name": "node0", "sector-num": 345435, "sectors-coun=
t": 5,
-               "type": "read" },
-     "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
-
-Flush operation:
-{ "event": "QUORUM_REPORT_BAD",
-     "data": { "node-name": "node0", "sector-num": 0, "sectors-count": 2=
097120,
-               "type": "flush", "error": "Broken pipe" },
-     "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
-
-Note: this event is rate-limited.
-
-RESET
------
-
-Emitted when the Virtual Machine is reset.
-
-Data: None.
-
-Example:
-
-{ "event": "RESET",
-    "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
-
-RESUME
-------
-
-Emitted when the Virtual Machine resumes execution.
-
-Data: None.
-
-Example:
-
-{ "event": "RESUME",
-    "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
-
-RTC_CHANGE
-----------
-
-Emitted when the guest changes the RTC time.
-
-Data:
-
-- "offset": Offset between base RTC clock (as specified by -rtc base), a=
nd
-new RTC clock value (json-number)
-
-Example:
-
-{ "event": "RTC_CHANGE",
-    "data": { "offset": 78 },
-    "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
-
-Note: this event is rate-limited.
-
-SHUTDOWN
---------
-
-Emitted when the Virtual Machine has shut down, indicating that qemu
-is about to exit.
-
-Data: None.
-
-Example:
-
-{ "event": "SHUTDOWN",
-    "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
-
-Note: If the command-line option "-no-shutdown" has been specified, a ST=
OP
-event will eventually follow the SHUTDOWN event.
-
-SPICE_CONNECTED
----------------
-
-Emitted when a SPICE client connects.
-
-Data:
-
-- "server": Server information (json-object)
-  - "host": IP address (json-string)
-  - "port": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-- "client": Client information (json-object)
-  - "host": IP address (json-string)
-  - "port": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-
-Example:
-
-{ "timestamp": {"seconds": 1290688046, "microseconds": 388707},
-  "event": "SPICE_CONNECTED",
-  "data": {
-    "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
-    "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
-}}
-
-SPICE_DISCONNECTED
-------------------
-
-Emitted when a SPICE client disconnects.
-
-Data:
-
-- "server": Server information (json-object)
-  - "host": IP address (json-string)
-  - "port": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-- "client": Client information (json-object)
-  - "host": IP address (json-string)
-  - "port": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-
-Example:
-
-{ "timestamp": {"seconds": 1290688046, "microseconds": 388707},
-  "event": "SPICE_DISCONNECTED",
-  "data": {
-    "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
-    "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
-}}
-
-SPICE_INITIALIZED
------------------
-
-Emitted after initial handshake and authentication takes place (if any)
-and the SPICE channel is up and running
-
-Data:
-
-- "server": Server information (json-object)
-  - "host": IP address (json-string)
-  - "port": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-  - "auth": authentication method (json-string, optional)
-- "client": Client information (json-object)
-  - "host": IP address (json-string)
-  - "port": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-  - "connection-id": spice connection id.  All channels with the same id
-                     belong to the same spice session (json-int)
-  - "channel-type": channel type.  "1" is the main control channel, filt=
er for
-                    this one if you want track spice sessions only (json=
-int)
-  - "channel-id": channel id.  Usually "0", might be different needed wh=
en
-                  multiple channels of the same type exist, such as mult=
iple
-                  display channels in a multihead setup (json-int)
-  - "tls": whevener the channel is encrypted (json-bool)
-
-Example:
-
-{ "timestamp": {"seconds": 1290688046, "microseconds": 417172},
-  "event": "SPICE_INITIALIZED",
-  "data": {"server": {"auth": "spice", "port": "5921",
-                      "family": "ipv4", "host": "127.0.0.1"},
-           "client": {"port": "49004", "family": "ipv4", "channel-type":=
 3,
-                      "connection-id": 1804289383, "host": "127.0.0.1",
-                      "channel-id": 0, "tls": true}
-}}
-
-SPICE_MIGRATE_COMPLETED
------------------------
-
-Emitted when SPICE migration has completed
-
-Data: None.
-
-Example:
-
-{ "timestamp": {"seconds": 1290688046, "microseconds": 417172},
-  "event": "SPICE_MIGRATE_COMPLETED" }
-
-MIGRATION
----------
-
-Emitted when a migration event happens
-
-Data: None.
-
- - "status": migration status
-     See MigrationStatus in ~/qapi-schema.json for possible values
-
-Example:
-
-{"timestamp": {"seconds": 1432121972, "microseconds": 744001},
- "event": "MIGRATION", "data": {"status": "completed"}}
-
-MIGRATION_PASS
---------------
-
-Emitted from the source side of a migration at the start of each pass
-(when it syncs the dirty bitmap)
-
-Data: None.
-
-  - "pass": An incrementing count (starting at 1 on the first pass)
-
-Example:
-{"timestamp": {"seconds": 1449669631, "microseconds": 239225},
- "event": "MIGRATION_PASS", "data": {"pass": 2}}
-
-STOP
-----
-
-Emitted when the Virtual Machine is stopped.
-
-Data: None.
-
-Example:
-
-{ "event": "STOP",
-    "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
-
-SUSPEND
--------
-
-Emitted when guest enters S3 state.
-
-Data: None.
-
-Example:
-
-{ "event": "SUSPEND",
-     "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
-
-SUSPEND_DISK
-------------
-
-Emitted when the guest makes a request to enter S4 state.
-
-Data: None.
-
-Example:
-
-{ "event": "SUSPEND_DISK",
-     "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
-
-Note: QEMU shuts down when entering S4 state.
-
-VNC_CONNECTED
--------------
-
-Emitted when a VNC client establishes a connection.
-
-Data:
-
-- "server": Server information (json-object)
-  - "host": IP address (json-string)
-  - "service": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-  - "auth": authentication method (json-string, optional)
-- "client": Client information (json-object)
-  - "host": IP address (json-string)
-  - "service": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-
-Example:
-
-{ "event": "VNC_CONNECTED",
-    "data": {
-        "server": { "auth": "sasl", "family": "ipv4",
-                    "service": "5901", "host": "0.0.0.0" },
-        "client": { "family": "ipv4", "service": "58425",
-                    "host": "127.0.0.1" } },
-    "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
-
-
-Note: This event is emitted before any authentication takes place, thus
-the authentication ID is not provided.
-
-VNC_DISCONNECTED
-----------------
-
-Emitted when the connection is closed.
-
-Data:
-
-- "server": Server information (json-object)
-  - "host": IP address (json-string)
-  - "service": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-  - "auth": authentication method (json-string, optional)
-- "client": Client information (json-object)
-  - "host": IP address (json-string)
-  - "service": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-  - "x509_dname": TLS dname (json-string, optional)
-  - "sasl_username": SASL username (json-string, optional)
-
-Example:
-
-{ "event": "VNC_DISCONNECTED",
-    "data": {
-        "server": { "auth": "sasl", "family": "ipv4",
-                    "service": "5901", "host": "0.0.0.0" },
-        "client": { "family": "ipv4", "service": "58425",
-                    "host": "127.0.0.1", "sasl_username": "luiz" } },
-    "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
-
-VNC_INITIALIZED
----------------
-
-Emitted after authentication takes place (if any) and the VNC session is
-made active.
-
-Data:
-
-- "server": Server information (json-object)
-  - "host": IP address (json-string)
-  - "service": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-  - "auth": authentication method (json-string, optional)
-- "client": Client information (json-object)
-  - "host": IP address (json-string)
-  - "service": port number (json-string)
-  - "family": address family (json-string, "ipv4" or "ipv6")
-  - "x509_dname": TLS dname (json-string, optional)
-  - "sasl_username": SASL username (json-string, optional)
-
-Example:
-
-{ "event": "VNC_INITIALIZED",
-    "data": {
-        "server": { "auth": "sasl", "family": "ipv4",
-                    "service": "5901", "host": "0.0.0.0"},
-        "client": { "family": "ipv4", "service": "46089",
-                    "host": "127.0.0.1", "sasl_username": "luiz" } },
-        "timestamp": { "seconds": 1263475302, "microseconds": 150772 } }
-
-VSERPORT_CHANGE
----------------
-
-Emitted when the guest opens or closes a virtio-serial port.
-
-Data:
-
-- "id": device identifier of the virtio-serial port (json-string)
-- "open": true if the guest has opened the virtio-serial port (json-bool=
)
-
-Example:
-
-{ "event": "VSERPORT_CHANGE",
-    "data": { "id": "channel0", "open": true },
-    "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
-
-Note: this event is rate-limited separately for each "id".
-
-WAKEUP
-------
-
-Emitted when the guest has woken up from S3 and is running.
-
-Data: None.
-
-Example:
-
-{ "event": "WAKEUP",
-     "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
-
-WATCHDOG
---------
-
-Emitted when the watchdog device's timer is expired.
-
-Data:
-
-- "action": Action that has been taken, it's one of the following (json-=
string):
-            "reset", "shutdown", "poweroff", "pause", "debug", or "none"
-
-Example:
-
-{ "event": "WATCHDOG",
-     "data": { "action": "reset" },
-     "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
-
-Note: If action is "reset", "shutdown", or "pause" the WATCHDOG event is
-followed respectively by the RESET, SHUTDOWN, or STOP events.
-
-Note: this event is rate-limited.
--=20
2.11.0
