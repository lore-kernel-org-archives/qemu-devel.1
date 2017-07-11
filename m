Received: from eggs.gnu.org ([2001:4830:134:3::10]:47690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUxnU-0003Lc-SO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUxnT-0007rS-Pp
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:14:00 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUxnT-0007rA-Ho
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:13:59 -0400
Received: by mail-wr0-x234.google.com with SMTP id r103so5650691wrb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 09:13:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 17:13:37 +0100
Message-ID: <CAFEAcA9nU-mYo1_3Vv=mY7+ZpcWfN3-8tw3q1Ztzc8uB9KmQTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] ppc-for-2.10 queue 20170711
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 11 July 2017 at 05:39, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 6b06e3e49eb8c91cc286c16d6bf3181ac296f33d:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-10-v2' into staging (2017-07-10 16:12:47 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170711
>
> for you to fetch changes up to b87680427e8a3ff682f66514e99a8344e7437247:
>
>   spapr: populate device tree depending on XIVE_EXPLOIT option (2017-07-11 11:04:02 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-07-11
>
>   * Several minor cleanups from Greg Kurz
>   * Fix for migration of pseries-2.7 and earlier machine types
>   * More reworking of the DRC hotplug code, fixing several problems
>     though there are still more to go
>   * Fixes for CPU family / alias handling on POWER9
>   * Preliminary patches for POWER9 XIVE (new interrupt controller)
>     support
>   * Assorted other fixes
>

Applied, thanks.

-- PMM
