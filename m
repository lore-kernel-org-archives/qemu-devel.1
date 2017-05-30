Received: from eggs.gnu.org ([2001:4830:134:3::10]:46248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dFfkE-00086z-0c
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dFfkD-0006Lx-B6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:55:26 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:34798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1dFfkD-0006Lb-6X
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:55:25 -0400
Received: by mail-qt0-x232.google.com with SMTP id c13so67780815qtc.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 04:55:24 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Tue, 30 May 2017 16:25:23 +0430
Message-ID: <CAGKXQyf5M10U9-7dppScT3wZKy9nShxgYZczWLSGs1kLG-c-bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] page dirtying
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
I want to have the order of dirty pages in an array and do prediction about
the next page that will be dirtied . so it is important for me to achieve
this order in qemu code. in other word  i need understand as soon as a page
dirties.  what is your recommendations to have this order? I have no
background for kernel coding.
thanks a lot
