Received: from eggs.gnu.org ([2001:4830:134:3::10]:40602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e57VS-00006Z-Mf
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e57VR-00078v-SJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:52:50 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:51363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e57VR-00076w-LZ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:52:49 -0400
Received: by mail-wr0-x229.google.com with SMTP id j14so7676863wre.8
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:52:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 10:52:27 +0100
Message-ID: <CAFEAcA_1GiuW3NHquG0OUYfpxOoy6S0M_jPj_CQ36wJLwr=Y0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/34] ppc-for-2.11 queue 20171017
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Greg Kurz <groug@kaod.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 17 October 2017 at 05:21, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit c5bbcaa4b7c0f8a322bebe9ec563560178a68b55:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-10-16 17:29:16 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171017
>
> for you to fetch changes up to e7cca3e94f7595b7b5a493a87146e782831611d7:
>
>   spapr_cpu_core: rewrite machine type sanity check (2017-10-17 10:34:01 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-10-17
>
> Here's the currently accumulated set of ppc patches for qemu.
>
>   * The biggest set here is the ppc parts of Igor Mammedov's cleanups
>     to cpu model handling
>   * The above also includes a generic patches which are required as
>     prerequisites for the ppc parts.  They don't seem to have been
>     merged by Eduardo yet, so I hope they're ok to include here.
>   * Apart from that it's basically just assorted bug fixes and cleanups
>

Applied, thanks.

-- PMM
