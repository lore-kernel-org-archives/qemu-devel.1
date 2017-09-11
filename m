Received: from eggs.gnu.org ([2001:4830:134:3::10]:44674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWL2-000176-Of
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWL1-0006wJ-3F
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:52 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWL0-0006w1-Ua
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:51 -0400
Received: by mail-qk0-x241.google.com with SMTP id o77so6183586qke.2
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 14:33:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 11 Sep 2017 18:33:27 -0300
Message-Id: <20170911213328.9701-5-f4bug@amsat.org>
In-Reply-To: <20170911213328.9701-1-f4bug@amsat.org>
References: <20170911213328.9701-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/5] tcg: move atomic_template.h to
 accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 atomic_template.h => accel/tcg/atomic_template.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename atomic_template.h => accel/tcg/atomic_template.h (100%)

diff --git a/atomic_template.h b/accel/tcg/atomic_template.h
similarity index 100%
rename from atomic_template.h
rename to accel/tcg/atomic_template.h
-- 
2.14.1
