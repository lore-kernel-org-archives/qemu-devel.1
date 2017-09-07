Received: from eggs.gnu.org ([2001:4830:134:3::10]:56821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpwrS-0001QL-Sp
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpwrO-0007v6-D5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:50 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpwrO-0007ug-5e
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:46 -0400
Received: by mail-wr0-x236.google.com with SMTP id v109so4052297wrc.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 06:28:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170906144940.30880-1-richard.henderson@linaro.org>
References: <20170906144940.30880-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 14:28:24 +0100
Message-ID: <CAFEAcA_izAwvo+dvjTxwkaOTaELDC+Z+8BOgatPqkHcNxT_qDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] TCG misc queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 September 2017 at 15:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This includes the tcg/ia64 removal, the tcg/s390 patch set that
> was recently acked, a couple of Pranith's memory ordering patches,
> and some fixes and additions to disas/i386.
>
>
> r~
>
>
> The following changes since commit b07d1c2f5607489d4d4a6a65ce36a3e896ac065e:
>
>   Revert "kvm: use DIV_ROUND_UP" (2017-09-05 18:55:40 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170906
>
> for you to fetch changes up to 4609190b5f7f68a5e2a8738029594f45a062d4c9:
>
>   tcg/s390: Use slbgr for setcond le and leu (2017-09-06 07:24:46 -0700)
>
> ----------------------------------------------------------------
> Queued tcg patches

Applied, thanks.

-- PMM
