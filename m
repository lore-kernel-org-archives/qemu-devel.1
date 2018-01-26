Received: from eggs.gnu.org ([2001:4830:134:3::10]:43788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef5j3-0004G0-O6
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef5j2-00078v-SR
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:15:33 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:39452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef5j2-00078P-Na
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:15:32 -0500
Received: by mail-oi0-x22a.google.com with SMTP id t8so507259oie.6
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 07:15:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180126091338.13708-1-kraxel@redhat.com>
References: <20180126091338.13708-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 14:24:13 +0000
Message-ID: <CAFEAcA_=Kfixm+687rHPjLpZaTts0kvVfKwwYkPrKxoz7rTe6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Input 20180126 patches
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

On 26 January 2018 at 09:13, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 2077fef91d5eb8e3745a84fabd87a5ee7d2b535d:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180125' into staging (2018-01-25 17:04:47 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/input-20180126-pull-request
>
> for you to fetch changes up to d0b610a55b81bdc485c877ef0466895fd40e8d6f:
>
>   hw: convert virtio-input-hid device to keycodemapdb (2018-01-26 07:15:07 +0100)
>
> ----------------------------------------------------------------
> input: switch devices to keycodemapdb, bugfixes.
>
> ----------------------------------------------------------------

This has a bunch of merge conflicts in the keycode map stuff.
I could probably fix them up, but I'm just going to ask you
to rebase instead, please.

thanks
-- PMM
