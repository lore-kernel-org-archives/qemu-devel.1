Received: from eggs.gnu.org ([2001:4830:134:3::10]:37383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1cvNcM-0007SH-8K
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1cvNcL-0008DO-G8
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:31:26 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:34043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1cvNcL-0008D8-Cr
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:31:25 -0400
Received: by mail-qt0-x230.google.com with SMTP id n21so136902841qta.1
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 05:31:25 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Tue, 4 Apr 2017 17:01:24 +0430
Message-ID: <CAGKXQydiJJO7Kg3tDZfx4q8zrK=BEZLQZkdaOOM0hEEN_tUMKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] bytes_xfer and xfer_limit
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
What are the variables 'bytes_xfer' and 'xfer_limit' in qemu-file.c ?
what does the function 'qemu_file_rate_limit' do?
thanks
