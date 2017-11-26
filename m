Received: from eggs.gnu.org ([2001:4830:134:3::10]:39698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eJ3eG-0003bx-AG
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 15:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eJ3eC-00011w-Bx
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 15:35:32 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:50757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1eJ3eC-000116-4J
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 15:35:28 -0500
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <ab2eda3b-571f-025e-66e9-6c1577793a08@physik.fu-berlin.de>
Message-ID: <b3becdc0-6540-30a6-b70b-8312ac5dddd9@physik.fu-berlin.de>
Date: Sun, 26 Nov 2017 21:35:24 +0100
MIME-Version: 1.0
In-Reply-To: <ab2eda3b-571f-025e-66e9-6c1577793a08@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] glibc "linux: spawni.c: simplify error reporting
 to parent" breaks qemu-user/Windows Service For Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.com>, James Clarke <jrtc27@jrtc27.com>, Michael Karcher <debian@mkarcher.dialup.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>

On 11/26/2017 09:28 PM, John Paul Adrian Glaubitz wrote:
> I'm not sure yet what the actual problem is but I thought it should be necessary
> to point you at the problem.

Ok, there is already a QEMU bug report for this [1].

Adrian

> [1] https://bugs.launchpad.net/qemu/+bug/1673976

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
