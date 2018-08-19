Received: from eggs.gnu.org ([2001:4830:134:3::10]:45134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxvoloshin71@gmail.com>) id 1frRNB-0000B9-50
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 13:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxvoloshin71@gmail.com>) id 1frRNA-0008MY-Ak
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 13:20:17 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:41462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <maxvoloshin71@gmail.com>)
	id 1frRNA-0008MN-6B
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 13:20:16 -0400
Received: by mail-ua1-x942.google.com with SMTP id h1-v6so8429909uao.8
	for <qemu-devel@nongnu.org>; Sun, 19 Aug 2018 10:20:16 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0JzQsNC60YEg0JLQvtC70L7RiNC40L0=?= <maxvoloshin71@gmail.com>
Date: Sun, 19 Aug 2018 20:20:14 +0300
Message-ID: <CAFxynTy4F5WwGE6vRgnHmAk5hXL44bG8mZhGQWXQfmLmHdOaBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Mainstone II
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello, could you tell me how to run Linux on QEMU Mainstone II machine? I
took kernel from there:
http://ftp.arm.linux.org.uk/pub/armlinux/people/xscale/mainstone/, but I do
not know what to do with rootfs (it is jffs2). How to add it into memory
bank to be visible to Linux inside QEMU? As for now I get stuck on SCSI
driver (2.4) or AC97 Codecs (2.6). P.S. Do you know what linux distros can
be run on Mainstone?
