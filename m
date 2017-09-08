Received: from eggs.gnu.org ([2001:4830:134:3::10]:37623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqKpc-0001oB-JU
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqKpb-0006BK-MI
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:04:32 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:37898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqKpb-0006A2-Gq
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:04:31 -0400
Received: by mail-wr0-x234.google.com with SMTP id 108so5177957wra.5
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 08:04:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2017 16:04:09 +0100
Message-ID: <CAFEAcA_zf93_gZJ=r4dD5BsvimCtx3CDvnAk0LCRnWfPBaSfGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/40] ppc-for-2.11 queue 20170908
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Igor Mammedov <imammedo@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 8 September 2017 at 11:35, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc76:
>
>   tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20170908
>
> for you to fetch changes up to 7cca3e466eb0baa36d1cc29d5aeb5da74a260711:
>
>   ppc: spapr: Move VCPU ID calculation into sPAPR (2017-09-08 09:30:55 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-09-08
>
> This is the first batch of ppc related patches for qemu-2.11, and it's
> accumulated quite a few things.  Includes:
>
>   * A cleanup to handling of ppc cpu models from Igor
>   * First parts of fixes to handling of guest vs. host SMT modes from
>     Sam Bobroff
>   * Preliminary patches towards supporting the Sam460 board from
>     Balaton Zoltan
>   * Several fixes for hotplug logic
>   * Assorted other fixes and cleanups
>

Applied, thanks.

-- PMM
