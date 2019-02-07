Received: from eggs.gnu.org ([209.51.188.92]:44903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gronr-0004Sd-DN
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1groni-0003j4-9l
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:53:32 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grone-0003gb-J1
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:53:28 -0500
Received: by mail-ot1-x343.google.com with SMTP id s5so1605779oth.7
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20190207131316.2957-1-laurent@vivier.eu>
In-Reply-To: <20190207131316.2957-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 18:53:12 +0000
Message-ID: <CAFEAcA_osyUTMyjAio+W4UGa6dTZp4t=ppEsJRQBkGy_BMn1nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/3] Linux user for 4.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On Thu, 7 Feb 2019 at 13:20, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 47994e16b1d66411953623e7c0bf0cdcd50bd507:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190205' into staging (2019-02-05 18:25:07 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.0-pull-request
>
> for you to fetch changes up to 0f5faca78267beb16d8a096e9729f39d552e5c14:
>
>   linux-user: add new netlink types (2019-02-07 14:11:19 +0100)
>
> ----------------------------------------------------------------
> - add new netlink type from linux v4.18 and v4.19
> - fix coverity warning (CID 1390634)
> - fix ioctl(SIOCGIFCONF) crash
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
