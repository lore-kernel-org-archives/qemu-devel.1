Received: from eggs.gnu.org ([2001:4830:134:3::10]:35276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwPlj-0003oK-U0
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwPlg-0006kY-HN
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:33:39 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dwPlg-0006id-Aq
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:33:36 -0400
Received: by mail-wr0-x242.google.com with SMTP id u48so1597358wrf.4
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 02:33:34 -0700 (PDT)
Date: Mon, 25 Sep 2017 10:33:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170925093332.GD14140@stefanha-x1.localdomain>
References: <20170923163334.9997-1-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170923163334.9997-1-mjt@msgid.tls.msk.ru>
Subject: Re: [Qemu-devel] [PATCH] remove trailing whitespace from
 qemu-options.hx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.orh

On Sat, Sep 23, 2017 at 07:33:34PM +0300, Michael Tokarev wrote:
> Remove trailing whitespace in qemu-options documentation, as it causes
> reproducibility issues depending on the echo implementation used by
> the Makefile.
> 
> Reported-By: Vagrant Cascadian <vagrant@debian.org>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-options.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
