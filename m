Received: from eggs.gnu.org ([2001:4830:134:3::10]:54759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1ce0DH-00045A-Ip
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1ce0DB-000264-Id
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:05:43 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1ce0DB-00024Z-DD
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:05:37 -0500
Received: by mail-wr0-f193.google.com with SMTP id i10so31409887wrb.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 06:05:35 -0800 (PST)
References: <CAO-EVGgMW-w+rD3fwKadKE8=bsq0FvFt9MEs1PLu+UvLKToQBg@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <95e51ef7-bb46-5527-87fc-cbda8a9b7278@tuxfamily.org>
Date: Wed, 15 Feb 2017 15:05:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAO-EVGgMW-w+rD3fwKadKE8=bsq0FvFt9MEs1PLu+UvLKToQBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Emulating a Sun Blade 1500,
 with a Ultrasparc IIIi 1.5 GHz, 2GB ECC RAM. SunOS 5.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gozulmeunou vasile <gozulmeunou@gmail.com>, qemu-devel@nongnu.org

On 15.02.2017 11:37, gozulmeunou vasile wrote:
> Hello,
> 
> I have an old Sun Blade 1500, with a Ultrasparc IIIi 1.5 GHz, 2GB ECC RAM.
> SunOS 5.10, ufs filesystem. The hardware (MB, HDD and video card) is
> failing on me and I'm searching for a way to emulate it on x86 hardware, I
> prefer to run the emulator on Linux as OS. I have a DD raw copy of the
> system HDD (80GB). I read about emulating it with qemu but I don't have yet
> much experience with Sun/Solaris and Linux environments.
> Do you think that you can help me with this?

I personally don't have much experience with SPARC, but have you seen
the SPARC page in the Wiki already:
 http://wiki.qemu-project.org/index.php/Documentation/Platforms/SPARC ?
... it contains some useful information and links, I think.

 Thomas
