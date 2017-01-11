Received: from eggs.gnu.org ([2001:4830:134:3::10]:43248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chenbo@pdx.edu>) id 1cR8gx-0001hj-Tu
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chenbo@pdx.edu>) id 1cR8gn-0003w7-HY
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:31:11 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:34931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <chenbo@pdx.edu>) id 1cR8gn-0003uu-5h
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:31:01 -0500
Received: by mail-ua0-x22c.google.com with SMTP id y9so170924466uae.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:31:00 -0800 (PST)
MIME-Version: 1.0
From: Bo Chen <chenbo@pdx.edu>
Date: Tue, 10 Jan 2017 18:30:59 -0800
Message-ID: <CAO8TxNhEzgTm_gOxu8U2GcJidZvq7nFwS7csGV0xoK1zGsUC7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] What the current status on using loadvm with read-only
 qcow2 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

Is there a way to use "-loadvm" loading an internal snapshot with a
read-only "qcow2" image for the latest version of qemu?

This seems to be a popular question, here are two "recent" ones:
[1] https://bugs.launchpad.net/qemu/+bug/1184089
[2] https://lists.nongnu.org/archive/html/qemu-discuss/2011-10/msg00009.html

I am curious what is the status on this feature.

Thanks,
Bo
