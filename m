Received: from eggs.gnu.org ([209.51.188.92]:36265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzPaz-0006TZ-62
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzPay-0003nW-8b
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:45 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:43619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzPaw-0003mK-ES
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:44 -0500
Received: by mail-oi1-x235.google.com with SMTP id i8so17146570oib.10
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 09:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20190228100858.28397-1-kraxel@redhat.com>
In-Reply-To: <20190228100858.28397-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 17:35:29 +0000
Message-ID: <CAFEAcA9L1oa0-WP-sSKB80Y0esWY99y6+BK+NqeyQ0i8_0EUwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Audio 20190228 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Feb 2019 at 10:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 86c7e2f4a93322a76afea5ee6806a83420d1dfea:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/authz-core-pull-request' into staging (2019-02-26 17:59:41 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20190228-pull-request
>
> for you to fetch changes up to 9399ef168377d9e7f2e33b1c2eb61751aa1b72fa:
>
>   audio/sdlaudio: Simplify the sdl_callback function (2019-02-28 10:30:08 +0100)
>
> ----------------------------------------------------------------
> audio: fixes and cleanups.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
