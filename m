Received: from eggs.gnu.org ([2001:4830:134:3::10]:38521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ceO0q-0008Ok-Fn
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ceO0p-0007YZ-CW
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:30:28 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ceO0p-0007XO-76
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:30:27 -0500
Received: by mail-wr0-x22a.google.com with SMTP id 89so9560590wrr.3
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:30:26 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 16 Feb 2017 15:30:25 +0000
Message-ID: <CAJSP0QWX0_stkyrkyL42QFFnnBTaqYD+XYmpMBO0gY2pWFD53g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Missing rewrite rule for qemu.org/images/ links
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jcody@redhat.com
Cc: qemu-devel@nongnu.org, thuth@redhat.com

Hi Jeff,
The old qemu.org/images/ links are not being rewritten to
wiki.qemu-project.org/images/.

For example, http://www.qemu-project.org/images/4/4e/Q35.pdf no longer works:
https://bugs.launchpad.net/qemu/+bug/1665344

I do notice that qemu.org/Features/Q35 is working.  Is it possible to
set up a rewrite rule or HTTP redirect so existing /images/ links keep
working?

Thanks,
Stefan
