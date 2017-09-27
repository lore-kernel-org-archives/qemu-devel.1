Received: from eggs.gnu.org ([2001:4830:134:3::10]:46833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxK7h-0001fr-5k
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxK7g-0006dL-97
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:44:05 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:49496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dxK7g-0006ca-12
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:44:04 -0400
Received: by mail-wm0-x22c.google.com with SMTP id r74so22780935wme.4
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 14:44:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Sep 2017 14:43:42 -0700
Message-ID: <CAFEAcA-dmfDZja+WQuQmgcZMKMzgme8_J4cpE5-j6z8_4q6-LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] ppc-for-2.11 queue 20170927
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 27 September 2017 at 00:42, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 31bc1d8481af414cfa2857f905e40f7d8e6d5b2e:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-09-26 19:49:08 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20170927
>
> for you to fetch changes up to e451b85f1bf3c8140be51e2b03eb71ab96c246a5:
>
>   macio: use object link between MACIO_IDE and MAC_DBDMA object (2017-09-27 13:05:41 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-09-27
>
> Contains
>  * a number of Mac machine type fixes
>  * a number of embedded machine type fixes (preliminary to adding the
>    Sam460ex board)
>  * a important fix for handling of migration with KVM PR
>  * assorted other minor fixes and cleanups
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
