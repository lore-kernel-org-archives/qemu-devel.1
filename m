Received: from eggs.gnu.org ([2001:4830:134:3::10]:57578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dreamashish21@gmail.com>) id 1cmkka-000652-TP
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dreamashish21@gmail.com>) id 1cmkka-0003Jt-62
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:24:16 -0500
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f]:37545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dreamashish21@gmail.com>)
	id 1cmkka-0003Hb-1c
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:24:16 -0500
Received: by mail-it0-x22f.google.com with SMTP id g138so12409465itb.0
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 09:24:14 -0800 (PST)
MIME-Version: 1.0
From: Ashish Gahlot <dreamashish21@gmail.com>
Date: Sat, 11 Mar 2017 22:53:33 +0530
Message-ID: <CAPww8bgFdJpx=_JKu+zgCiSGwzC2jcVweP13QsRUZtUp_eu0Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Qemu socket address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sorry if I'm asking a silly question but why doesn't Qemu support *socket
address reuse *when we use remote debugging with gdb with options "-S -s"?

Is there a support in the upstream version? I am using Qemu version 2.7.0.

Thanks
Ashish

-- 
Ashish Kumar Gahlot
III year, UG
Govt. Engg. College, Ajmer, India
