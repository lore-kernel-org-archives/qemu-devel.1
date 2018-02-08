Received: from eggs.gnu.org ([2001:4830:134:3::10]:45504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejk0C-0001Y0-VP
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejk0C-0001hd-3p
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:04:28 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:44979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejk0B-0001h7-VW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:04:28 -0500
Received: by mail-ot0-x22c.google.com with SMTP id l5so3927142otj.11
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 03:04:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180207170124.26704-1-jsnow@redhat.com>
References: <20180207170124.26704-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 11:04:07 +0000
Message-ID: <CAFEAcA_0b1Lb-CCAYnX8i2jg5ySh752dhXr3zqpKPqc6PDEwWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 February 2018 at 17:01, John Snow <jsnow@redhat.com> wrote:
> The following changes since commit 0833df03f4206a6cf416fbb3d380fa95c8e61fba:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180206a' into staging (2018-02-07 12:07:23 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to 3260cdfffbf00f33923f5f9f6bef45932d7ac28b:
>
>   hbitmap: fix missing restore count when finish deserialization (2018-02-07 11:35:49 -0500)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Liang Li (1):
>   hbitmap: fix missing restore count when finish deserialization
>
>  util/hbitmap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> --

Applied, thanks.

-- PMM
