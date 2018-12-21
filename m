Received: from eggs.gnu.org ([2001:4830:134:3::10]:56595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gaQzI-0006sV-De
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gaQzF-00049V-Tb
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:01:36 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gaQzF-00048E-4U
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:01:33 -0500
Received: by mail-oi1-x243.google.com with SMTP id i6so5718549oia.6
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 12:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
In-Reply-To: <20181221054606.22007-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Dec 2018 19:30:46 +0000
Message-ID: <CAFEAcA9PRoG6i_v10XXa4Jb-Y0Dyf280q0PNqNSuoGbaT9Uh+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/40] ppc-for-4.0 queue 20181221
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, gkurz@redhat.com, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On Fri, 21 Dec 2018 at 05:46, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 95de6f4b92efea391a3cbb8651d774a4d3529861:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-12-20' into staging (2018-12-20 18:54:47 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20181221
>
> for you to fetch changes up to b62c6e1237fb5ca2563f7e72b66ac0c40ff7a714:
>
>   MAINTAINERS: PPC: add a XIVE section (2018-12-21 09:40:43 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-12-21
>
> This pull request supersedes the one from 2018-12-13.
>
> This is a revised first ppc pull request for qemu-4.0.  Highlights
> are:
>
>  * Most of the code for the POWER9 "XIVE" interrupt controller
>    (not complete yet, but we're getting there)
>  * A number of g_new vs. g_malloc cleanups
>  * Some IRQ wiring cleanups
>  * A fix for how we advertise NUMA nodes to the guest for pseries
>
> ----------------------------------------------------------------
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
