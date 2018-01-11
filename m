Received: from eggs.gnu.org ([2001:4830:134:3::10]:58741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZdwN-0002YG-Ro
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZdwM-0004Tp-UH
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:34:47 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:35152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZdwM-0004TA-Pu
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:34:46 -0500
Received: by mail-ot0-x22f.google.com with SMTP id 53so2252880otj.2
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 06:34:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180111045937.2119-1-david@gibson.dropbear.id.au>
References: <20180111045937.2119-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 14:34:25 +0000
Message-ID: <CAFEAcA-+WnbQXn1y+BV8_B6Jq_SjTQ7ogBdYObfgMqKA_3m3FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] ppc-for-2.12 queue 20180111
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, surajjs@au1.ibm.com

On 11 January 2018 at 04:59, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 3cee4db661ab9c0fce7937b3bbfa188a1845f31f:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-08' into staging (2018-01-09 15:22:47 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180111
>
> for you to fetch changes up to 51f84465dd985fc21589b2eac1f18658fc9783e9:
>
>   spapr: Correct compatibility mode setting for hotplugged CPUs (2018-01-10 12:53:00 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-01-11
>
> This pull request supersedes ppc-for-2.12-20180108 and several before
> it.  The earlier pull request included a patch which exposed a bug in
> the ARM TCG backend.  I've pulled that out and will repost once the
> ARM bug is fixed (a patch has been posted by Richard Henderson).
>
> Higlights from this series:
>   * SLOF update
>   * Several new devices for embedded platforms
>   * Fix to correctly set compatiblity mode for hotplugged CPUs
>   * dtc compile fix for older MacOS versions

Applied, thanks.

-- PMM
