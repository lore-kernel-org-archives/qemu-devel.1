Received: from eggs.gnu.org ([2001:4830:134:3::10]:40123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwE8C-0003Ev-FZ
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwE8B-00064f-NK
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:08:04 -0400
References: <20170911205001.11789-1-n54@gmx.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <5f6af3cc-14cb-3e51-2ddf-86453e3ca190@msgid.tls.msk.ru>
Date: Mon, 25 Sep 2017 00:08:02 +0300
MIME-Version: 1.0
In-Reply-To: <20170911205001.11789-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Drop gld linker usage on SunOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org
Cc: jperkin@joyent.com, qemu-devel@nongnu.org

11.09.2017 23:50, Kamil Rytarowski wrote:
> This is required to be removed on SmartOS (Illumos).

I take this as granted - I haven't verified this.

> As of now there are no alternative supported SunOS distributions.

Applied to -trivial, thanks!

/mjt
