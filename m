Received: from eggs.gnu.org ([2001:4830:134:3::10]:43150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stenavin@gmail.com>) id 1cb6iN-00036f-2j
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stenavin@gmail.com>) id 1cb6iM-0005iM-BA
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:25:51 -0500
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:34980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stenavin@gmail.com>) id 1cb6iM-0005eh-6X
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:25:50 -0500
Received: by mail-qk0-x234.google.com with SMTP id u25so89061750qki.2
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 06:25:48 -0800 (PST)
MIME-Version: 1.0
From: Nikolay Ivanets <stenavin@gmail.com>
Date: Tue, 7 Feb 2017 16:25:27 +0200
Message-ID: <CAHwdxNf8CZ2x-UdFWUJ2BhgZQC6yKPnbM6T7FNGwow-=ez+rvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] How to find backing file for qemu-nbd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Is there any way to find source file supplied for qemu-nbd similar to loop
device:

cat /sys/block/loop0/loop/backing_file

?

--
    Nikolay Ivanets
    Mobile: +380979184774
    Skype: n_ivanets
