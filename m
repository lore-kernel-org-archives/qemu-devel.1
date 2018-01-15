Received: from eggs.gnu.org ([2001:4830:134:3::10]:37646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb1Bn-00031O-R3
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb1Bm-0007Uc-R0
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:36:23 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:33162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb1Bm-0007T0-MG
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:36:22 -0500
Received: by mail-oi0-x235.google.com with SMTP id y141so7877446oia.0
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 01:36:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180112145258.10578-1-kraxel@redhat.com>
References: <20180112145258.10578-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 09:36:01 +0000
Message-ID: <CAFEAcA_nNmT+fXvaTa7sD5kXoybNQuWyJ10EG94ffd7W=-WfOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Ui 20180112 patches
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

On 12 January 2018 at 14:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b9ff:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180111' into staging (2018-01-11 14:34:41 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180112-pull-request
>
> for you to fetch changes up to 849bbe60356caf3d320202d45f1ddffeefae06c7:
>
>   sdl2: Ignore UI hotkeys after a focus change when GUI modifier is held (2018-01-12 15:51:18 +0100)
>
> ----------------------------------------------------------------
> sdl2: bugfixes.
> spice: cleanups.
> input: mem leak fix.
> gtk: deprecate 2.x support.
>

Applied, thanks.

Please can you add some text to the "Build Dependencies" section
of the changelog for the GTK2 deprecation?
 https://wiki.qemu.org/index.php?title=ChangeLog/2.12

-- PMM
