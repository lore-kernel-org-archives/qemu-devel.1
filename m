Received: from eggs.gnu.org ([2001:4830:134:3::10]:55425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esr5T-0004Yi-KN
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esr5S-0001T6-Cj
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:27:35 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:33507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esr5S-0001Sy-5C
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:27:34 -0500
Received: by mail-ot0-x236.google.com with SMTP id y11so15070407otg.0
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 06:27:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180304173232.22814-1-laurent@vivier.eu>
References: <20180304173232.22814-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 14:27:13 +0000
Message-ID: <CAFEAcA8d7L15dRrOiZUyQH7N=wp0oRKoD1K4togS==yfJaegjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 4 March 2018 at 17:32, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 136c67e07869227b21b3f627316e03679ce7b738:
>
>   Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-2018-03-02' into staging (2018-03-02 16:56:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request
>
> for you to fetch changes up to 0d379c1709aa6b2d09dd3b493bfdf3a5fe6debcd:
>
>   target/m68k: add fscale, fgetman and fgetexp (2018-03-04 17:27:59 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Laurent Vivier (5):
>   target/m68k: TCGv returned by gen_load() must be freed
>   softfloat: export some functions
>   target/m68k: add fmod/frem
>   softfloat: use floatx80_infinity in softfloat
>   target/m68k: add fscale, fgetman and fgetexp
>

Applied, thanks.

-- PMM
