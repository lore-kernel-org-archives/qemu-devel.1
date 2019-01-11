Received: from eggs.gnu.org ([209.51.188.92]:59414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gi2B2-00015X-Ui
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gi2B2-0003fS-37
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:09:08 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:38385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gi2B1-0003f1-Qq
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:09:07 -0500
Received: by mail-ot1-x336.google.com with SMTP id e12so14070214otl.5
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 11:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20190111114701.6195-1-kraxel@redhat.com>
In-Reply-To: <20190111114701.6195-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jan 2019 19:08:56 +0000
Message-ID: <CAFEAcA_KdWcXVjywfW8u+R7kLPdZPfRpL64HQwgopvm+FXnpyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Misc 20190111 patches
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

On Fri, 11 Jan 2019 at 11:48, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 291741033f611a4f0bbce3f7c9dead84ce315f96:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20190110-pull-request' into staging (2019-01-10 18:45:23 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/misc-20190111-pull-request
>
> for you to fetch changes up to 78ac44af547e09bdddc75e41a525cdc8eec60be4:
>
>   roms: seabios: Rename CROSS_COMPILE to CROSS_PREFIX (2019-01-11 12:46:07 +0100)
>
> ----------------------------------------------------------------
> misc: fix seabios cross build.
>
> ----------------------------------------------------------------
>
> Roman Bolshakov (1):
>   roms: seabios: Rename CROSS_COMPILE to CROSS_PREFIX
>
>  roms/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
