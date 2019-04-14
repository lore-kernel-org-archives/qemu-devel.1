Received: from eggs.gnu.org ([209.51.188.92]:58999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFkd5-0006U4-2V
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFkd3-0007m2-TN
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:17:27 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:44477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hFkd3-0007lD-FX
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:17:25 -0400
Received: by mail-oi1-x234.google.com with SMTP id i21so11996931oib.11
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 12:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190412160458.23920-1-kwolf@redhat.com>
In-Reply-To: <20190412160458.23920-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Apr 2019 20:17:13 +0100
Message-ID: <CAFEAcA-xcQW1mkyFL=e922oOEoukHRqCWkRukVmfpbR00avemw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block layer patches for 4.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 12 Apr 2019 at 17:05, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 13c24edaa742181af8d9c6b027ee366b04de1ea1:
>
>   qemu-img: fix .hx and .texi disparity (2019-04-12 14:17:10 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 9749636b005d118259810afb92482df2fe0ae2ad:
>
>   iotest: Fix 241 to run in generic directory (2019-04-12 18:03:01 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - iotests fixes

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
