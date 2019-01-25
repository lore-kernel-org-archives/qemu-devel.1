Received: from eggs.gnu.org ([209.51.188.92]:58737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn01k-0001kl-HM
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn01j-0005QN-P5
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:52:04 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:45832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gn01j-0005Q3-Ib
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:52:03 -0500
Received: by mail-ot1-x332.google.com with SMTP id 32so8213943ota.12
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 03:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20190124132020.13571-1-kraxel@redhat.com>
In-Reply-To: <20190124132020.13571-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 11:51:50 +0000
Message-ID: <CAFEAcA9FajRHAdaXQjEi-d2uhuMqzBHNBCsY_jXMUoYkNswsug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Audio 20190124 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>

On Thu, 24 Jan 2019 at 13:27, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit f6b06fcceef465de0cf2514c9f76fe0192896781:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190121-pull-request' into staging (2019-01-23 17:57:47 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20190124-pull-request
>
> for you to fetch changes up to 6a48541873f14b597630283f8f5397674ad82ea9:
>
>   audio: probe audio drivers by default (2019-01-24 13:11:08 +0100)
>
> ----------------------------------------------------------------
> audio: pc speaker init fix, rework driver probing
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
