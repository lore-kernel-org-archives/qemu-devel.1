Received: from eggs.gnu.org ([2001:4830:134:3::10]:47499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3QGk-00082V-SS
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 14:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3QGk-0003ee-2L
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 14:02:54 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:43036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3QGj-0003df-Su
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 14:02:53 -0400
Received: by mail-ot0-x22e.google.com with SMTP id m22-v6so20369082otf.10
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 11:02:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180402141614.2008263-1-eblake@redhat.com>
References: <20180402141614.2008263-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Apr 2018 19:02:32 +0100
Message-ID: <CAFEAcA-dhaTjO61AjrZQreatvoGaK1Q9dzOJY_PZpdfcA-2QXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] NBD patches for 2.12-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 April 2018 at 15:16, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit f184de7553272223d6af731d7d623a7cebf710b5:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critical-fixes' into staging (2018-03-31 09:42:33 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-04-02
>
> for you to fetch changes up to 2b53af2523f6a3387f71372f59d3717f1f7d5fd9:
>
>   nbd: trace meta context negotiation (2018-04-02 09:10:49 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2018-04-02
>
> - Eric Blake: nbd: Fix 32-bit compilation on BLOCK_STATUS
> - Eric Blake: nbd/client: Correctly handle bad server REP_META_CONTEXT
> - Eric Blake: nbd: trace meta context negotiation
>
> ----------------------------------------------------------------
> Eric Blake (3):
>       nbd: Fix 32-bit compilation on BLOCK_STATUS
>       nbd/client: Correctly handle bad server REP_META_CONTEXT
>       nbd: trace meta context negotiation

Applied, thanks.

-- PMM
