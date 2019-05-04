Received: from eggs.gnu.org ([209.51.188.92]:58743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hMtyj-0008GL-IS
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hMtyg-0005O5-Sy
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:41:21 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:38162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hMtye-0005Ks-Ud
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:41:18 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat,  4 May 2019 14:41:13 +0200
Message-Id: <20190504124113.13137-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190504124113.13137-1-samuel.thibault@ens-lyon.org>
References: <20190504124113.13137-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] Update slirp submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

To fix Windows on ARM.
---
 slirp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp b/slirp
index 59a1b1f165..0e79ba4856 160000
--- a/slirp
+++ b/slirp
@@ -1 +1 @@
-Subproject commit 59a1b1f165458c2acb7ff0525b543945f7416225
+Subproject commit 0e79ba48567ccfb3cc2cf2e98cce8811eee7e455
--=20
2.20.1
