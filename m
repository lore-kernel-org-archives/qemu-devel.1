Received: from eggs.gnu.org ([2001:4830:134:3::10]:40857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJcpG-00041x-8N
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJcpF-0002eX-8E
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:13:46 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJcpE-0002Lq-Jp
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:13:45 -0500
Received: by mail-ot1-x341.google.com with SMTP id c32so7549979otb.8
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 03:13:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181104100826.15143-1-richard.henderson@linaro.org>
References: <20181104100826.15143-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 11:13:23 +0000
Message-ID: <CAFEAcA83SonheRXTchCQn2mUiJA=VPmL8YCrozjurB6RPF9CEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] softfloat: Don't execute divdeu without
 power7
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

On 4 November 2018 at 10:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The following changes since commit 7d56239f159afc2e7bd42623947e56ba48f37836:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181102' into staging (2018-11-02 17:17:12 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-softfloat-20181104
>
> for you to fetch changes up to 7370981bd1ef58b3c20ba8b83cc342d1c61bc773:
>
>   softfloat: Don't execute divdeu without power7 (2018-11-04 10:04:40 +0000)
>
> ----------------------------------------------------------------
> Only use divdeu insn with Power7 and later.
>
> ----------------------------------------------------------------
> Richard Henderson (1):
>       softfloat: Don't execute divdeu without power7



Applied, thanks.

-- PMM
