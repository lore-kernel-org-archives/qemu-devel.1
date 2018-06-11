Received: from eggs.gnu.org ([2001:4830:134:3::10]:54842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSM4h-0000OZ-Aa
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSM4g-0004N4-FE
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:37:31 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:44956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSM4g-0004Ma-1E
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:37:30 -0400
Received: by mail-ot0-x22b.google.com with SMTP id w13-v6so23535385ote.11
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 05:37:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611104935.20499-1-laurent@vivier.eu>
References: <20180611104935.20499-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 13:37:08 +0100
Message-ID: <CAFEAcA8ACN6cRO+OzFYSGfj99Aitgr+O5-CayOPcDbTnywQB+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] M68k for 3.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

On 11 June 2018 at 11:49, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 0d2fa03dae4fbe185a082f361342b1e30aed4582:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180608' into staging (2018-06-08 16:26:51 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-3.0-pull-request
>
> for you to fetch changes up to a56f36c1d2bccbc50a53fa8093b93d205607f1b8:
>
>   target/m68k: Merge disas_m68k_insn into m68k_tr_translate_insn (2018-06-11 12:43:42 +0200)
>
> ----------------------------------------------------------------
> Convert to TranslatorOps
>
> I've updated the series to fix conflicts with:
>
> 21528149eb target/m68k: Add trailing '\n' to qemu_log() call
> 07ea28b418 tcg: Pass tb and index to tcg_gen_exit_tb separately
>
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
