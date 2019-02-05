Received: from eggs.gnu.org ([209.51.188.92]:57908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr3xK-0000yt-8X
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr3xI-00036z-2u
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:52:17 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:46018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr3xG-00034Q-0y
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:52:16 -0500
Received: by mail-ot1-x332.google.com with SMTP id 32so6755020ota.12
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 08:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20190205105758.4230-1-kraxel@redhat.com>
In-Reply-To: <20190205105758.4230-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 16:51:59 +0000
Message-ID: <CAFEAcA8K-j4kMspa0THf1e2qzc8nXJxNuHF33rsDUjCeN4My6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Ui 20190205 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 5 Feb 2019 at 10:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 773c4a6228fd910556cee2d477ee56c591a30000:
>
>   test-filter-mirror: pass UNIX domain socket through fd (2019-02-04 16:03:20 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190205-pull-request
>
> for you to fetch changes up to 19c1b9fd3dd5955893c0d3c187a4180313e9a0f1:
>
>   keymap: fix keyup mappings (2019-02-05 10:45:44 +0100)
>
> ----------------------------------------------------------------
> ui: add kbd stats tracker.
> ui: gtk scroll fixes.
> ui: egl cursor scale fix.
> ui: more sdl1 cleanup.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
