Received: from eggs.gnu.org ([2001:4830:134:3::10]:55089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtD-0005u7-Il
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtC-0001Jf-AS
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:08:51 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Sat, 11 Aug 2018 11:08:33 +0200
Message-Id: <20180811090836.4024-5-contrib@steffen-goertz.de>
In-Reply-To: <20180811090836.4024-1-contrib@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/7] arm: Add additional datasheets and
 copyright lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

This patch adds a link to the product specification
which contain additional information about the
Nordic Semiconductor nRF51 SOC series.

Furthermore it adds a copyright line to all
files that get changed significantly.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/arm/microbit.c          | 1 +
 hw/arm/nrf51_soc.c         | 4 +++-
 include/hw/arm/nrf51_soc.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index d6776dea0a..bb6ddb6a79 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -3,6 +3,7 @@
  * http://tech.microbit.org/hardware/
  *
  * Copyright 2018 Joel Stanley <joel@jms.id.au>
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
  *
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 85bce2c1e0..2265d30352 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -1,8 +1,10 @@
 /*
  * Nordic Semiconductor nRF51 SoC
- * http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.1.pdf
+ * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
pdf
+ * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.p=
df
  *
  * Copyright 2018 Joel Stanley <joel@jms.id.au>
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
  *
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 24212f9174..45d9671dc3 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -2,6 +2,7 @@
  * Nordic Semiconductor nRF51  SoC
  *
  * Copyright 2018 Joel Stanley <joel@jms.id.au>
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
  *
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
--=20
2.18.0
