Received: from eggs.gnu.org ([2001:4830:134:3::10]:60800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQv0d-0006aA-RM
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQv0d-0002Kw-1N
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:26:51 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQv0c-0002KC-QU
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:26:50 -0400
Received: by mail-wr0-x231.google.com with SMTP id c11so203625530wrc.3
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 05:26:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Jun 2017 13:26:29 +0100
Message-ID: <CAFEAcA_ewhfGStzqE8BCVon16VFT_GsGRV=bdHvr79FyjwPPNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] ppc-for-2.10 queue 20170730
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, sursingh@redhat.com, sbobroff@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 30 June 2017 at 11:46, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit c5eb5846d2d207bbde7f4b665d9ff90b92c8adff:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170629' into staging (2017-06-29 17:37:11 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170630
>
> for you to fetch changes up to 0dfabd39d523fc3f6f0f8c441f41c013cc429b52:
>
>   spapr: Clean up DRC set_isolation_state() path (2017-06-30 14:03:32 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-06-30
>
>   * More DRC cleanups, these now actually fix a few bugs
>   * Properly implements the openpic timers (they now count and
>     generate interrupts)
>   * Fixes for XICS migration
>   * Fixes for migration of POWER9 RPT guests
>   * The last of the compatibility mode rework
>

Applied, thanks.

-- PMM
