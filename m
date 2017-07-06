Received: from eggs.gnu.org ([2001:4830:134:3::10]:46506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dT2l5-00047v-TB
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dT2l2-0000bg-OT
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:07:35 -0400
Received: from outpost5.zedat.fu-berlin.de ([130.133.4.89]:40287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dT2l2-0000af-Go
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:07:32 -0400
Date: Thu, 6 Jul 2017 11:07:24 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <20170706090724.GB23904@physik.fu-berlin.de>
References: <20170706002401.10507-1-rth@twiddle.net>
	<20170706002401.10507-6-rth@twiddle.net>
	<e969146b-3061-e0ee-3e5c-e709c73abc11@vivier.eu>
	<20170706081045.GA7838@physik.fu-berlin.de>
	<25f0470b-4a22-32e4-a298-c93975537ee8@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f0470b-4a22-32e4-a298-c93975537ee8@vivier.eu>
Sender: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [Qemu-devel] [PATCH 05/11] linux-user/sh4: Notice gUSA regions
 during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, bruno@clisp.org, aurelien@aurel32.net

On Thu, Jul 06, 2017 at 10:35:15AM +0200, Laurent Vivier wrote:
> This is a patch series proposed by Richard, it is not included in qemu
> at the moment:
> 
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg01196.html

Aye, awesome!

> I think it would be interesting if you generate a qemu binary with it
> and use it in your buildds to test it.
> 
> I guess the series can be pulled directly from Richard's branch:
> 
> git://github.com/rth7680/qemu.git tgt-sh4

You bet, I will!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
