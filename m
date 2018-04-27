Received: from eggs.gnu.org ([2001:4830:134:3::10]:52971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC0mr-0007WI-Ro
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC0mq-0003Sg-Qe
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:39:33 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:43516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC0mq-0003S8-Jp
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:39:32 -0400
Received: by mail-oi0-x236.google.com with SMTP id p62-v6so1155787oie.10
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 03:39:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 11:39:11 +0100
Message-ID: <CAFEAcA-wfEoR36y36bvOGSowCmsZyEEXUKb=U+fbs1h31k1Qdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/49] ppc-for-2.13 queue 20180427
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 27 April 2018 at 10:20, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit ca92651697bdb2f15b36d347a498fbc31f4a4893:
>
>   Merge remote-tracking branch 'remotes/iwj/tags/for-upstream.depriv-2' into staging (2018-04-26 19:22:09 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.13-20180427
>
> for you to fetch changes up to 6233b679cae8741890f981c9dd6570d47715141e:
>
>   Clear mem_path if we fall back to anonymous RAM allocation (2018-04-27 18:05:23 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-04-27
>
> Here's the first batch of ppc patches for 2.13.  This has a lot of
> stuff that's accumulated during the 2.12 freeze.  Highlights are:
>
>     * Many improvements for the Uninorth PCI host bridge for Mac
>       machine types
>     * Preliminary helpers improve handling of multiple backing
>       pagesizes (not strictly ppc related, but have acks and aimed to
>       allow future ppc changes)
>     * Cleanups to pseries cpu initialization
>     * Cleanups to hash64 MMU handling
>     * Assorted bugfixes and improvements
>

Applied, thanks.

-- PMM
