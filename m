Received: from eggs.gnu.org ([2001:4830:134:3::10]:38694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVFH5-0003nn-Qj
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVFH5-0007HK-42
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:58:15 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVFH4-0007H6-Ug
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:58:15 -0400
Received: by mail-oi0-x242.google.com with SMTP id 188-v6so17835269oid.12
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 04:58:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Jun 2018 12:57:53 +0100
Message-ID: <CAFEAcA8NtSZhiWyyCiEf-9n3LoqFd0U0ERTiMDRDyr0D=G_q7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/28] ppc-for-3.0 queue 20180618
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 18 June 2018 at 04:52, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180618
>
> for you to fetch changes up to 844afc54ae229515a37f63519855661ad2d01d19:
>
>   spapr: fix xics_system_init() error path (2018-06-18 09:43:19 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-06-18
>
> Next batch of ppc and spapr related patches for the 3.0 release.
>     * Improved handling of Spectre/Meltdown mitigations for POWER8
>     * Numerous Mac machine type cleanups and improvements
>     * Cleanup to cpu realize/unrealize path for spapr
>     * Create a place for machine-specific per-cpu information, and
>       start moving some things to it
>     * Assorted bugfixes
>

Applied, thanks.

-- PMM
