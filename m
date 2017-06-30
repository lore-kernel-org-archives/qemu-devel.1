Received: from eggs.gnu.org ([2001:4830:134:3::10]:41864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dQvZd-0005Hd-Ms
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dQvZd-00016m-1x
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:03:01 -0400
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:35539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1dQvZc-00016U-U2
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:03:00 -0400
Received: by mail-qk0-x236.google.com with SMTP id 16so100161433qkg.2
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 06:03:00 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Fri, 30 Jun 2017 17:32:39 +0430
Message-ID: <CAGKXQyct2Y0DTbSRxCjyDJpR0eSZg3L245mce6QvmtPNJexcrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] BIT_WORD(start >> TARGET_PAGE_BITS)
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
what does the following code do?
'unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS)' ?
thanks a lot
