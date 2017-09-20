Received: from eggs.gnu.org ([2001:4830:134:3::10]:34738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.tribble@gmail.com>) id 1duk5J-00054F-DU
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.tribble@gmail.com>) id 1duk5H-0006d7-Te
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:50:57 -0400
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:44799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.tribble@gmail.com>)
	id 1duk5H-0006Uw-Lv
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:50:55 -0400
Received: by mail-it0-x22d.google.com with SMTP id r131so3016341itc.1
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 11:50:54 -0700 (PDT)
MIME-Version: 1.0
From: Peter Tribble <peter.tribble@gmail.com>
Date: Wed, 20 Sep 2017 19:50:52 +0100
Message-ID: <CAEgYsbFZGT3GARy7LEkU7uvb4__Xg6AdA2oU9wHtctmKhewkmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] SunOS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

To introduce myself: I'm a member of the illumos community (the successor
to OpenSolaris, to those unfamiliar with us), and I maintain my own illumos
distribution.

Having seen the scary 'SUPPORT FOR THIS HOST OS WILL GO AWAY'
message, I'm reaching out to see what needs to be done so that support for
SunOS (not just illumos, I include Oracle's Solaris in the same family)
needs
to be kept and, where possible, enhanced.

I'm willing to act as a contact in this effort, and can work with others in
the illumos
community to see if there are other resources we can bring to bear.

One of my interests here is the sparc support; it would be helpful for us
to have
a working sparc emulator, as only a few of us have actual sparc hardware,
and
the qemu sparc emulation has dramatically improved in the last couple of
releases - it would be unfortunate if we were then unable to make use of it.

Thanks,

-- 
-Peter Tribble
http://www.petertribble.co.uk/ - http://ptribble.blogspot.com/
