Received: from eggs.gnu.org ([2001:4830:134:3::10]:33577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gozulmeunou@gmail.com>) id 1cdwyD-00053o-LT
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gozulmeunou@gmail.com>) id 1cdwyC-0006QG-Ny
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:37:57 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:32835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gozulmeunou@gmail.com>)
	id 1cdwyC-0006Q3-Is
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:37:56 -0500
Received: by mail-ot0-x234.google.com with SMTP id 73so113200940otj.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 02:37:54 -0800 (PST)
MIME-Version: 1.0
From: gozulmeunou vasile <gozulmeunou@gmail.com>
Date: Wed, 15 Feb 2017 12:37:53 +0200
Message-ID: <CAO-EVGgMW-w+rD3fwKadKE8=bsq0FvFt9MEs1PLu+UvLKToQBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Emulating a Sun Blade 1500,
 with a Ultrasparc IIIi 1.5 GHz, 2GB ECC RAM. SunOS 5.10
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

I have an old Sun Blade 1500, with a Ultrasparc IIIi 1.5 GHz, 2GB ECC RAM.
SunOS 5.10, ufs filesystem. The hardware (MB, HDD and video card) is
failing on me and I'm searching for a way to emulate it on x86 hardware, I
prefer to run the emulator on Linux as OS. I have a DD raw copy of the
system HDD (80GB). I read about emulating it with qemu but I don't have yet
much experience with Sun/Solaris and Linux environments.
Do you think that you can help me with this?

Thank you!
