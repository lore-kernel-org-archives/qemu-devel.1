Received: from eggs.gnu.org ([2001:4830:134:3::10]:54337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez4na-0007wJ-Ly
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez4nZ-0001Fb-UZ
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:18:50 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ez4nZ-0001El-NI
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:18:49 -0400
Received: by mail-lf0-x244.google.com with SMTP id m16-v6so10848336lfc.4
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 11:18:49 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 22 Mar 2018 11:18:28 -0700
Message-Id: <20180322181828.9061-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] linux-user/xtensa: remove stray syscall.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/xtensa/syscall.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 linux-user/xtensa/syscall.h

diff --git a/linux-user/xtensa/syscall.h b/linux-user/xtensa/syscall.h
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.11.0
