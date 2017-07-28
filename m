Received: from eggs.gnu.org ([2001:4830:134:3::10]:32877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbE1i-0005By-Qs
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbE1i-0002MW-1L
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:46:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 19:46:07 -0300
Message-Id: <20170728224608.3598-8-f4bug@amsat.org>
In-Reply-To: <20170728224608.3598-1-f4bug@amsat.org>
References: <20170728224608.3598-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for 2.10 7/8] docs: fix broken paths to
 docs/specs/ivshmem-spec.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

When this file was rewritten/renamed in fdee2025dd, a reference path was not
updated.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/specs/pci-ids.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
index 95adee07d6..bb99a0257e 100644
--- a/docs/specs/pci-ids.txt
+++ b/docs/specs/pci-ids.txt
@@ -40,7 +40,7 @@ maintained as part of the virtio specification.
 1af4:1100  Used as PCI Subsystem ID for existing hardware devices emulated
            by qemu.
 
-1af4:1110  ivshmem device (shared memory, docs/specs/ivshmem_device_spec.txt)
+1af4:1110  ivshmem device (shared memory, docs/specs/ivshmem-spec.txt)
 
 All other device IDs are reserved.
 
-- 
2.13.3
