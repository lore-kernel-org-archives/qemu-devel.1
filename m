Received: from eggs.gnu.org ([2001:4830:134:3::10]:42826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dVa7e-0007Yi-Q3
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dVa7b-0002X5-Jc
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:09:22 -0400
Received: from outpost5.zedat.fu-berlin.de ([130.133.4.89]:37421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dVa7b-0002Vl-CS
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:09:19 -0400
Date: Thu, 13 Jul 2017 11:09:08 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <20170713090908.GA25275@physik.fu-berlin.de>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
	<9645bafa-2c7e-96e8-5f3c-9cf7a9415285@physik.fu-berlin.de>
	<51a3a21f-6145-d721-170f-b8cf20cbc2d9@twiddle.net>
	<313d3f03-f487-4881-5f0a-6dd150f1ebdc@physik.fu-berlin.de>
	<3349c01e-1f1a-2111-28c2-70fb5cc077cd@physik.fu-berlin.de>
	<b7f8b2dd-a154-fc14-7be1-1cdbe248d350@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f8b2dd-a154-fc14-7be1-1cdbe248d350@twiddle.net>
Sender: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [Qemu-devel] [PATCH v2 08/27] linux-user/sh4: Notice gUSA
 regions during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

Just as a heads-up: The current set of patches as they are present in
the tgt-sh4 branch on git://github.com/rth7680/qemu.git are a HUGE
improvement for qemu-sh4 user mode. Several packages which previously
crashed during build or use can now be used properly!

So, I hope to see this series merged upstream soon! Thanks a lot!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
