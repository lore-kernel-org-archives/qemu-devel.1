Received: from eggs.gnu.org ([2001:4830:134:3::10]:42658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrb-00040X-KQ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNra-0006wW-Ti
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:19 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNra-0006wQ-PT
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:18 -0400
Received: by mail-qt0-x242.google.com with SMTP id w12so9571358qta.2
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 18:03:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 28 Jun 2017 22:02:54 -0300
Message-Id: <20170629010300.2848-3-f4bug@amsat.org>
In-Reply-To: <20170629010300.2848-1-f4bug@amsat.org>
References: <20170629010300.2848-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/8] MAINTAINERS: update KVM entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Yang Zhong <yang.zhong@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

moved in 92229a57 to accel/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06006fc7df..86a08c5aac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -273,8 +273,8 @@ Overall
 M: Paolo Bonzini <pbonzini@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
-F: kvm-*
 F: */kvm.*
+F: accel/kvm/
 F: include/sysemu/kvm*.h
 
 ARM
-- 
2.13.1
