Received: from eggs.gnu.org ([2001:4830:134:3::10]:55591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKkQQ-0001od-8A
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKkQP-0007xW-Hm
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:55:58 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:32995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKkQP-0007wy-AI
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:55:57 -0400
Received: by mail-wr0-x229.google.com with SMTP id v104so133753703wrb.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 04:55:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 12:55:33 +0100
Message-ID: <CAFEAcA9n5kmfwQn7REVmQHWoDEypAy3e+OzMBG4k5C9AmJ2nig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/20] ppc-for-2.10 queue 20170609
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, sursingh@redhat.com

On 9 June 2017 at 06:26, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 64175afc695c0672876fbbfc31b299c86d562cb4:
>
>   arm_gicv3: Fix ICC_BPR1 reset value when EL3 not implemented (2017-06-07 17:21:44 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170609
>
> for you to fetch changes up to 593080936a06a04eacc589350e3a7ebc02f2ed8e:
>
>   Revert "spapr: fix memory hot-unplugging" (2017-06-09 12:35:46 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-06-09
>
> This batch contains more patches to rework the pseries machine hotplug
> infrastructure, plus an assorted batch of bugfixes.
>
> It contains a start on fixes to restore migration from older machine
> types on older versions which was broken by some xics changes.  There
> are still a few missing pieces here, though.
>

Applied, thanks.

-- PMM
