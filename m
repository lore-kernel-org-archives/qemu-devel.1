Received: from eggs.gnu.org ([2001:4830:134:3::10]:51497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr6Yl-0002dW-0V
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr6Yj-0007qg-RR
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:30:03 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr6Yj-0007qJ-L1
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:30:01 -0400
Received: by mail-wm0-x232.google.com with SMTP id n11so67251744wma.1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 10:30:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170323101048.24848-1-david@gibson.dropbear.id.au>
References: <20170323101048.24848-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 17:29:39 +0000
Message-ID: <CAFEAcA8d4-r4M=-NyxDvagLDnto8zdUG-PDOihCXAAiEQKMrtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] ppc-for-2.9 queue 20170323
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 23 March 2017 at 10:10, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:
>
>   Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170323
>
> for you to fetch changes up to 55641213fc81cdfc3bcd56c9e9991faa119201b2:
>
>   numa,spapr: align default numa node memory size to 256MB (2017-03-22 11:32:42 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue for 2017-03-23
>
> Just a single bugfix in this batch.  It's not strictly in ppc code,
> though it's for the pseries machine's benefit.  Eduardo suggested it
> go through my tree however.
>
> ----------------------------------------------------------------
> Laurent Vivier (1):
>       numa,spapr: align default numa node memory size to 256MB
>

Applied, thanks.

-- PMM
