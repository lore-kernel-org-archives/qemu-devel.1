Received: from eggs.gnu.org ([2001:4830:134:3::10]:47732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dKhvT-0006B5-5l
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dKhvS-0000NY-Ej
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:15:51 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:34882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1dKhvS-0000NL-74
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:15:50 -0400
Received: by mail-qt0-x22d.google.com with SMTP id w1so161930022qtg.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 02:15:48 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Tue, 13 Jun 2017 13:45:47 +0430
Message-ID: <CAGKXQyf2xdubP9EV4AK2AuxYmzrm4rjYpEPckDb5aiNDTW5YUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] global bitmap
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
can i have a bitmap of all pages in the ram? in qemu code, it seems that we
only can have bitmap of pages in a block and we have no global bitmap of
pages.
thanks a lot
