Received: from eggs.gnu.org ([2001:4830:134:3::10]:50653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWNbC-0004q8-9c
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWNbB-0004eX-DR
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:03:42 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:47041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWNbA-0004eC-UT
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:03:41 -0400
Received: by mail-ot0-x241.google.com with SMTP id v24-v6so7800375otk.13
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 08:03:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622103528.28598-1-david@gibson.dropbear.id.au>
References: <20180622103528.28598-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 16:03:19 +0100
Message-ID: <CAFEAcA8-jSMy-9R69d7zQoEL593iiR5xitaPh17JwNzo-2U=1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] ppc-for-3.0 queue 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 22 June 2018 at 11:35, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a93b:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into staging (2018-06-20 09:51:30 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180622
>
> for you to fetch changes up to e5ca28ecab5c69b7578e22391a66c97c3979ffd8:
>
>   spapr: Don't rewrite mmu capabilities in KVM mode (2018-06-22 14:19:07 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-06-22
>
> Another assorted patch of patches for ppc and spapr.
>     * Rework of guest pagesize handling for ppc, which avoids guest
>       visibly different behaviour between accelerators
>     * A number of Pnv cleanups, working towards more complete POWER9
>       support
>     * Migration of VPA data, a significant bugfix

Applied, thanks.

-- PMM
