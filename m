Received: from eggs.gnu.org ([2001:4830:134:3::10]:41329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dovB6-0004ng-Eg
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dovB1-0005T4-Th
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:28:52 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:34987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dovB1-0005Sn-LJ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:28:47 -0400
Received: by mail-wr0-x236.google.com with SMTP id y15so3311295wrc.2
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 10:28:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504542075-28447-1-git-send-email-peter.maydell@linaro.org>
References: <1504542075-28447-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 18:28:25 +0100
Message-ID: <CAFEAcA8iDousTBOZ+T54DP_cnO0D8wPonLw2X9LpAaOTNqN8bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/33] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 4 September 2017 at 17:21, Peter Maydell <peter.maydell@linaro.org> wrote:
> Third time's the charm...
>
> -- PMM
>
> The following changes since commit 98bfaac788be0ca63d7d010c8d4ba100ff1d8278:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-09-01-v3' into staging (2017-09-04 13:28:09 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170904-2
>
> for you to fetch changes up to 7229ec5825df6b933f150b54a8a2bedd2de1864c:
>
>   arm_gicv3_kvm: Fix compile warning (2017-09-04 17:13:53 +0100)
>
> ----------------------------------------------------------------
> target-arm:
>  * collection of M profile cleanups and minor bugfixes
>  * loader: handle ELF files with overlapping zero-init data
>  * virt: allow PMU instantiation with userspace irqchip
>  * wdt_aspeed: Add support for the reset width register
>  * cpu: Define new cpu_transaction_failed() hook
>  * Mark some SoC devices as not user-creatable
>  * arm: Fix aa64 ldp register writeback
>  * arm_gicv3_kvm: Fix compile warning
>

Applied, thanks.

-- PMM
