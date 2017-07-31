Received: from eggs.gnu.org ([2001:4830:134:3::10]:60657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc8Nx-0004tF-4x
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc8Ns-0004hV-QL
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:57:17 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:44 +0300
Message-Id: <25e11d8774630600ef4c5e9906419a77163a28a1.1501496350.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/25] docs: fix broken paths to
 docs/specs/ivshmem-spec.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

When this file was rewritten/renamed in fdee2025dd,
a reference path was not updated.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/specs/pci-ids.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
index 95adee07d6..bb99a0257e 100644
--- a/docs/specs/pci-ids.txt
+++ b/docs/specs/pci-ids.txt
@@ -40,7 +40,7 @@ maintained as part of the virtio specification.
 1af4:1100  Used as PCI Subsystem ID for existing hardware devices emulat=
ed
            by qemu.
=20
-1af4:1110  ivshmem device (shared memory, docs/specs/ivshmem_device_spec=
.txt)
+1af4:1110  ivshmem device (shared memory, docs/specs/ivshmem-spec.txt)
=20
 All other device IDs are reserved.
=20
--=20
2.11.0
