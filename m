Received: from eggs.gnu.org ([2001:4830:134:3::10]:34817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK1QW-0002Iz-V8
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK1Ad-0001k0-7p
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:13:31 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK1Aa-0001Lf-Uq
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:13:27 -0500
Received: by mail-ot1-x341.google.com with SMTP id 40so11106902oth.4
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 05:13:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181106113826.25810-1-peter.maydell@linaro.org>
References: <20181106113826.25810-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 13:12:55 +0000
Message-ID: <CAFEAcA_rOsBGCWQLEGWAVTb7U_Bie3fOojDKfar7fsAd1oy_FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 6 November 2018 at 11:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> Handful of bugfix patches for arm for rc0; also
> one milkymist patch, thrown in since I was putting
> the pullreq together anyway.
>
> thanks
> -- PMM
>
> The following changes since commit 03c1ca1c51783603d42eb0f91d35961f0f4b4947:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20181105' into staging (2018-11-06 09:10:46 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181106
>
> for you to fetch changes up to 23463e0e4aeb2f0a9c60549a2c163f4adc0b8512:
>
>   target/arm: Fix ATS1Hx instructions (2018-11-06 11:32:14 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Remove can't-happen if() from handle_vec_simd_shli()
>  * hw/arm/exynos4210: Zero memory allocated for Exynos4210State
>  * Set S and PTW in 64-bit PAR format
>  * Fix ATS1Hx instructions
>  * milkymist: Check for failure trying to load BIOS image
>

Applied, thanks.

-- PMM
