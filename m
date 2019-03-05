Received: from eggs.gnu.org ([209.51.188.92]:39128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1FfP-0005U7-QB
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1FfI-0005bZ-Qy
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:23:50 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:38605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1FfE-0005O4-D5
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:23:45 -0500
Received: by mail-oi1-x231.google.com with SMTP id q81so7765388oic.5
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 11:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20190305165051.26860-1-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 19:23:30 +0000
Message-ID: <CAFEAcA8YnpDLRUnBYiNy8-1txP-Ywf844hJ2os5bSYeiSL+4dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/22] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 5 Mar 2019 at 16:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> target-arm queue for softfreeze:
> This has all the big stuff I want to get in for softfreeze;
> there may be one or two smaller patches I pick up later in
> the week.
>
> thanks
> -- PMM
>
> The following changes since commit 0984a157c1c053394adbf64ed7de97f1aebe6a2d:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2019-03-05 09:33:20 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190305
>
> for you to fetch changes up to 566528f823d1a2e9eb2d7b2ed839547cb31bfc34:
>
>   hw/arm/stellaris: Implement watchdog timer (2019-03-05 15:55:09 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fix PC test for LDM (exception return)
>  * Implement ARMv8.0-SB
>  * Implement ARMv8.0-PredInv
>  * Implement ARMv8.4-CondM
>  * Implement ARMv8.5-CondM
>  * Implement ARMv8.5-FRINT
>  * hw/arm/stellaris: Implement watchdog timer
>  * virt: support more than 255GB of RAM
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
