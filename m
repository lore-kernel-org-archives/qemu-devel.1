Received: from eggs.gnu.org ([2001:4830:134:3::10]:52259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dCOsx-00020N-Um
	for qemu-devel@nongnu.org; Sun, 21 May 2017 07:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dCOsx-0001jb-6j
	for qemu-devel@nongnu.org; Sun, 21 May 2017 07:18:55 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:35369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1dCOsx-0001jV-2E
	for qemu-devel@nongnu.org; Sun, 21 May 2017 07:18:55 -0400
Received: by mail-qt0-x233.google.com with SMTP id v27so84590673qtg.2
	for <qemu-devel@nongnu.org>; Sun, 21 May 2017 04:18:54 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Sun, 21 May 2017 15:48:53 +0430
Message-ID: <CAGKXQyfaEZP0Dzm0ML_uHwUGOUGS4zsn39oeZjcASJ+oyGz+YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] get_queued_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello
Is "get_queued_page" function (which is called in line 1383 of ram.c) only
used in postcopy mode and has no usage in precopy mode?
thanks a lot
