Received: from eggs.gnu.org ([2001:4830:134:3::10]:53586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwQb-0004cl-UD
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwQX-00080y-4Z
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:03:14 -0500
References: <e4eb55c2-bac0-01f4-267f-19e70aa9b0de@tuxfamily.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <47d03193-5461-63e9-669e-4e7886c3c070@msgid.tls.msk.ru>
Date: Wed, 15 Feb 2017 13:02:58 +0300
MIME-Version: 1.0
In-Reply-To: <e4eb55c2-bac0-01f4-267f-19e70aa9b0de@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] m68k: Remove dummy machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>

26.01.2017 11:30, Thomas Huth wrote:
> Since it is now possible to instantiate a CPU and RAM with the "none"
> machine, too, and a kernel can be loaded there with the generic loader
> device, there is no more need for the m68k "dummy" machine. Thus let's
> remove this unmaintained file now.

Applied to -trivial, thank you!

/mjt
