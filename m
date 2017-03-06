Received: from eggs.gnu.org ([2001:4830:134:3::10]:33129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckuK9-0007ie-Lq
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckuK8-0007UQ-Lf
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:13:21 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckuK8-0007UD-FR
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:13:20 -0500
Received: by mail-wm0-x22c.google.com with SMTP id n11so66555357wma.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 07:13:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170306040823.28482-1-david@gibson.dropbear.id.au>
References: <20170306040823.28482-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 15:12:58 +0000
Message-ID: <CAFEAcA8EvwQ0AoudyHFQw+hNDUa7E8_ia6A8xouDP5V5amzkFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] ppc-for-2.9 queue 20170306
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 6 March 2017 at 04:08, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 17783ac828adc694d986698d2d7014aedfeb48c6:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170303' into staging (2017-03-04 16:31:14 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170306
>
> for you to fetch changes up to 182fe2cf19e829e34f63443ee1ccd9f799715c2c:
>
>   target/ppc: use helper for excp handling (2017-03-06 13:17:28 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue for 2017-03-06
>
> Looks like my previous batch wasn't quite the last before hard freeze.
> This has a handful of bugfixes to go in.  They're all genuine
> bugfixes, though not regressions in some cases.
>

Applied, thanks.

-- PMM
