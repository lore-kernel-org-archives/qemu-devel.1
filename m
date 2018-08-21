Received: from eggs.gnu.org ([2001:4830:134:3::10]:37357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs86X-00031B-9G
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs86V-0007vB-KC
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:57:57 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:43650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fs86V-0007uL-Do
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:57:55 -0400
Received: by mail-oi0-x236.google.com with SMTP id b15-v6so32468638oib.10
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:57:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 15:57:34 +0100
Message-ID: <CAFEAcA89ZqubJ0+OEtY7yctri-7ncc7Wypjs3a=9s5-1Rk9LGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] ppc-for-3.1 queue 20180821
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>

On 21 August 2018 at 05:33, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit d0092d90eb546a8bbe9e9120426c189474123797:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180820' into staging (2018-08-20 17:41:18 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-3.1-20180821
>
> for you to fetch changes up to 0e3bf4890906fa7066a5deafd6ab033934b8d100:
>
>   ppc: add DBCR based debugging (2018-08-21 14:28:45 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-08-21
>
> Here's my first ppc & spapr pull request for qemu-3.1.  This contains
> a bunch of things that have accumulated while 3.0 was in freeze.
> Highlights are:
>     * SLOF firmware update
>     * A number of floating point cleanups from Richard Henderson and
>       Yasmin Beatriz
>     * A new model for assigning irq numbers on spapr, this is an
>       important preliminary step towards implementing the POWER9
>       "XIVE" interrupt controller
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
