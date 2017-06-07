Received: from eggs.gnu.org ([2001:4830:134:3::10]:48659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dIWxC-0002cP-FC
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dIWx7-0003mJ-8I
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:08:36 -0400
Received: from outpost5.zedat.fu-berlin.de ([130.133.4.89]:49929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dIWx7-0003lb-0K
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:08:33 -0400
Date: Wed, 7 Jun 2017 11:08:24 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <20170607090824.GA6481@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [Qemu-devel] [PATCH] target/m68k: implement rtd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> Add "Return and Deallocate" (rtd) instruction.
>
>   RTD #d
>
>     (SP) -> PC
>     SP + 4 + d -> SP

Tested-By: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
