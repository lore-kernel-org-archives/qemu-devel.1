Received: from eggs.gnu.org ([2001:4830:134:3::10]:36929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lichstor@gmail.com>) id 1eMvuh-0002ap-Mu
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 08:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lichstor@gmail.com>) id 1eMvud-0003bd-Ub
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 08:08:31 -0500
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:34552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lichstor@gmail.com>) id 1eMvud-0003an-Pe
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 08:08:27 -0500
Received: by mail-yb0-x241.google.com with SMTP id k4so2926908ybc.1
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 05:08:27 -0800 (PST)
MIME-Version: 1.0
From: Charles Kelimod <lichstor@gmail.com>
Date: Thu, 7 Dec 2017 21:08:26 +0800
Message-ID: <CAO1xR-zb6Eni1LD0PB80hGRKU8PCqxjbfHtVM4aUt9i+3Utq3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] iSER transport name is not good
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


I'm on the road of modifying libvirt to add iSER support, and I found qemu
is actually support that. But, the transport name is iSER, which should be
RDMA and there libvirt already defined it.

Best Regards,
Charles.
