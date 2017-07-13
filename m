Received: from eggs.gnu.org ([2001:4830:134:3::10]:50826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2s-00005k-L6
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2q-0001pu-Ea
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:46 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf2q-0001pd-7Q
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:44 -0400
Received: by mail-wm0-x241.google.com with SMTP id p204so5452821wmg.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:24:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:23:56 +0200
Message-Id: <1499955874-10954-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/41] MAINTAINERS: update KVM entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

moved in 92229a57 to accel/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170629150308.22766-3-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74b3956..55061e9 100644
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
1.8.3.1
