Received: from eggs.gnu.org ([2001:4830:134:3::10]:33621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1d8nhQ-0005wd-2m
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1d8nhP-0003SQ-Dn
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:00:08 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:35446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1d8nhP-0003Qj-Aj
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:00:07 -0400
Received: by mail-qt0-x235.google.com with SMTP id v27so3672595qtg.2
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 06:00:06 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Thu, 11 May 2017 17:30:05 +0430
Message-ID: <CAGKXQyc1VN19p8whSXAj6Hz_A7RNsOVA0Www-zJQwMBVNA7P1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] order of dirtying pages in vm live migration iterations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi
Is it possible to have the order of dirtying pages in every iteration of vm
live migration?
thanks a lot
