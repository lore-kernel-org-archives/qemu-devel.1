Received: from eggs.gnu.org ([2001:4830:134:3::10]:57955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dX8Pp-0004Go-7o
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dX8Pm-0008T0-6t
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:58:33 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:34755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dX8Pm-0008Sg-1J
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:58:30 -0400
Received: by mail-io0-x22c.google.com with SMTP id r36so45661062ioi.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 08:58:29 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <993F37A8-2DB0-42B3-8F70-C5B9F384AE4C@gmail.com>
Date: Mon, 17 Jul 2017 11:58:27 -0400
Subject: [Qemu-devel] Cocoa.m: changing keys to ungrab mouse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

I realize having the ungrab keys be Control-Option for the cocoa =
interface is not a good idea. This makes keyboard combinations like =
Control-Alt-Delete (popular in Windows) unusable. This is why I suggest =
the ungrab keys be changed to Control-Alt-G. This is what the GTK =
interface already uses.  What do you think of this idea?=
