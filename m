Received: from eggs.gnu.org ([2001:4830:134:3::10]:35585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOhaF-0004v7-RZ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOhaE-0006b0-I4
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:19:15 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:43544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gOhaE-0006aJ-3P
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:19:14 -0500
Received: by mail-ot1-x334.google.com with SMTP id a11so23620775otr.10
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 03:19:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1542479908-20067-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1542479908-20067-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 11:18:52 +0000
Message-ID: <CAFEAcA-uUL9Z89uNfOUk77-izPFxCrE3iyo_3gTyDCNZo10J7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/11] MIPS queue for November 2018 (for
 QEMU 3.1-rc2) - v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Laurent Vivier <laurent@vivier.eu>

On 17 November 2018 at 18:38, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 83c496599cc04926ecbc3e47a37debaa3e38b686:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-31-20181116-pull-request' into staging (2018-11-16 13:53:01 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-november-2018-v2
>
> for you to fetch changes up to 90b27c4c3b2ccf3103ad86fdcda65cd105f95857:
>
>   MAINTAINERS: Add Stefan Markovic as a MIPS reviewer (2018-11-17 19:29:34 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for QEMU 3.1-rc2 - v2
>
>
>   - fix MIPS-specific prctl() handling in linux-user
>   - fix some issues of R5900 support
>   - update MAINTAINERS wrt. MIPS reviewer
>
> v2:
>
>   - fixed "Signed-off-by:" lines
>

Applied, thanks.

-- PMM
