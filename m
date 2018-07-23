Received: from eggs.gnu.org ([2001:4830:134:3::10]:52576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhgIP-0000sL-PA
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhgIO-0003AJ-Qf
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:15:01 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhgIO-0003A1-Bw
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:15:00 -0400
Received: by mail-oi0-x241.google.com with SMTP id w126-v6so3141039oie.7
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 12:15:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180723172311.11316-1-richard.henderson@linaro.org>
References: <20180723172311.11316-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 20:14:39 +0100
Message-ID: <CAFEAcA-mxs6a3GuUEZ5kc1oRNLCf=wtmQhraaDJ7Q+t4AOgbKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-3.0 0/1] tcg-next patches
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

On 23 July 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> One more tcg/i386 patch for 3.0, fixing a testcase
> reported over the weekend.
>
>
> r~
>
>
> The following changes since commit e596be90393389405c96a5c9534c4c4e2e0b5675:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180723' into staging (2018-07-23 16:15:24 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20180723
>
> for you to fetch changes up to 672189cd586ea38a2c1d8ab91eb1f9dcff5ceb05:
>
>   tcg/i386: Mark xmm registers call-clobbered (2018-07-23 09:21:14 -0700)
>
> ----------------------------------------------------------------
> Mark xmm registers call-clobbered.
>
> ----------------------------------------------------------------
> Richard Henderson (1):
>       tcg/i386: Mark xmm registers call-clobbered
>
>  tcg/i386/tcg-target.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Applied, thanks.

-- PMM
