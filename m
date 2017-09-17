Received: from eggs.gnu.org ([2001:4830:134:3::10]:52463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8u-0007zK-9O
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8p-0008A4-I9
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:56 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:43421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb8p-00089m-De
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:51 -0400
Received: by mail-oi0-x233.google.com with SMTP id r20so3682069oie.0
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:05:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:23 -0700
Message-Id: <20170917150535.8284-6-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/17] accel/tcg: move atomic_template.h to
 accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20170911213328.9701-5-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 atomic_template.h => accel/tcg/atomic_template.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename atomic_template.h => accel/tcg/atomic_template.h (100%)

diff --git a/atomic_template.h b/accel/tcg/atomic_template.h
similarity index 100%
rename from atomic_template.h
rename to accel/tcg/atomic_template.h
-- 
2.13.5
