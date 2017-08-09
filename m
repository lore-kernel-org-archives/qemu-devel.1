Received: from eggs.gnu.org ([2001:4830:134:3::10]:60055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfG95-00037Z-TR
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfG93-00064e-9j
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:50:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfG93-000643-4B
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:50:49 -0400
Date: Wed, 9 Aug 2017 04:50:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1502241852-6302-2-git-send-email-mst@redhat.com>
References: <1502241852-6302-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502241852-6302-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] acpi-test: update expected DSDT files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-test-data/q35/DSDT        | Bin 7782 -> 7782 bytes
 tests/acpi-test-data/q35/DSDT.bridge | Bin 7799 -> 7799 bytes
 tests/acpi-test-data/q35/DSDT.cphp   | Bin 8245 -> 8245 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt | Bin 7857 -> 7857 bytes
 tests/acpi-test-data/q35/DSDT.memhp  | Bin 9147 -> 9147 bytes
 5 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/acpi-test-data/q35/DSDT b/tests/acpi-test-data/q35/DSDT
index a6138c829142265255ac6f7bedd44757e944eb2f..a080e2ace20ce9b88d5a61078d8caa0262617eed 100644
GIT binary patch
delta 24
fcmaE6^UQ|JCD<h-O^$(qF?1r=6-N1u_uFLwW`_tH

delta 24
fcmaE6^UQ|JCD<h-O^$(qF?=G|6-L>O_uFLwW|0UR

diff --git a/tests/acpi-test-data/q35/DSDT.bridge b/tests/acpi-test-data/q35/DSDT.bridge
index 6b90f606f8b76f71ea9c569f4e606aeecd9e239d..31a76732e563dde32e6d976670baa732a6b91807 100644
GIT binary patch
delta 24
gcmexv^WBEaCD<jTT#kW(@#{pcD~$3R@6V700C4sQ{{R30

delta 24
gcmexv^WBEaCD<jTT#kW(@%u!sD~z%m@6V700C4~a{{R30

diff --git a/tests/acpi-test-data/q35/DSDT.cphp b/tests/acpi-test-data/q35/DSDT.cphp
index 976755ef2dc8ab68a82b64ab9fff793c4a113db9..3e23cb638f296644154100379584b30b644926bd 100644
GIT binary patch
delta 24
gcmdn$u+@RfCD<jzRDpqk@!UkND~$3R?}y0)0AK(I+yDRo

delta 24
gcmdn$u+@RfCD<jzRDpqk@xnx|D~z%m?}y0)0ALCS+yDRo

diff --git a/tests/acpi-test-data/q35/DSDT.ipmibt b/tests/acpi-test-data/q35/DSDT.ipmibt
index b3fa4359ff2cad5569bb625dff7be8f8b4590ba9..9c5e03fd2ffd3a99f3e5214ba187456a86410b22 100644
GIT binary patch
delta 24
gcmdmJyU~`*CD<ioqZ|VRW7R~iD~$3R?_ZJy0Ard6ZU6uP

delta 24
gcmdmJyU~`*CD<ioqZ|VRW6eaaD~z%m?_ZJy0Ar*GZU6uP

diff --git a/tests/acpi-test-data/q35/DSDT.memhp b/tests/acpi-test-data/q35/DSDT.memhp
index 7341c405bfb7dd21b4ec5df92411963cdf894c4d..1b7c484a5e31ec456685bc246197252cb48a3adf 100644
GIT binary patch
delta 24
gcmdn(zT2J4CD<iow=x3*W8_4xD~$3R@83}Z0A|SulK=n!

delta 24
gcmdn(zT2J4CD<iow=x3*WAsF>D~z%m@83}Z0A|w&lK=n!

-- 
MST
