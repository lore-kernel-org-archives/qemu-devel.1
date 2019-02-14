Received: from eggs.gnu.org ([209.51.188.92]:46594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLog-00033g-1b
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLof-00066J-3q
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:32:58 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guLob-00063O-Bl
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:32:55 -0500
Received: by mail-ot1-x344.google.com with SMTP id z19so12241219otm.2
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 10:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20190214104717.3543-1-laurent@vivier.eu>
In-Reply-To: <20190214104717.3543-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 18:32:40 +0000
Message-ID: <CAFEAcA-G99JfUUtW+pkHT3-TOTo4ENYZYbxyitRR9Rwbau1s1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Trivial branch patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Libvirt <libvir-list@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>

On Thu, 14 Feb 2019 at 10:58, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc06:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-02-12 10:53:37 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to 96566d09aa105ee04cbc1c9539cf8a9a40e8e422:
>
>   configure: improve usbfs check (2019-02-14 11:46:30 +0100)
>
> ----------------------------------------------------------------
> - some configure updates (HAX/NetBSD, remove "wav", -Waddress-of-packed-member)
> - remove deprecated options
> - some trace and error cleanup
> - typo fixes
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
