Received: from eggs.gnu.org ([2001:4830:134:3::10]:46439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsOm2-0007yI-T5
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsOlz-00061M-0J
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:41:22 -0400
References: <20170911200002.4511-1-n54@gmx.com>
	<20170911201610.15204-1-n54@gmx.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <e2230002-e063-ee4a-6e66-b4bd8c08de06@msgid.tls.msk.ru>
Date: Thu, 14 Sep 2017 10:41:17 +0300
MIME-Version: 1.0
In-Reply-To: <20170911201610.15204-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2] Replace round_page()
 with TARGET_PAGE_ALIGN()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>

11.09.2017 23:16, Kamil Rytarowski =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> This change fixes conflict with the DragonFly BSD headers.

Applied to -trivial, thanks!

/mjt
