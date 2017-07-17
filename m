Received: from eggs.gnu.org ([2001:4830:134:3::10]:35431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX8ar-0005ds-Ee
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX8aq-0006qI-Jm
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:09:57 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX8aq-0006on-CJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:09:56 -0400
Received: by mail-wr0-x233.google.com with SMTP id 12so9471485wrb.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:09:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717093839.15341-1-kraxel@redhat.com>
References: <20170717093839.15341-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 17:09:34 +0100
Message-ID: <CAFEAcA-90Cgo5W8XCPyedRxubxZbbCd5eR89kQqe4YPTESVb1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Ui 20170717 patches
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

On 17 July 2017 at 10:38, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 6e2c46334385c7e295ac883c801c81b4925fb54f:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170711' into staging (2017-07-13 10:47:10 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20170717-pull-request
>
> for you to fetch changes up to feb47cf2fac5a0b8fe8509b18edf077e065dc97f:
>
>   keymaps: fr-ca: add missing keys (2017-07-17 11:36:41 +0200)
>
> ----------------------------------------------------------------
> ui: vnc and keymap updates for 2.10
>
> ----------------------------------------------------------------
>
> Alexander Graf (1):
>   vnc: Set default kbd delay to 10ms
>
> Dr. David Alan Gilbert (1):
>   hmp: Update info vnc
>
> Gerd Hoffmann (1):
>   keymaps: fr-ca: add missing keys

Applied, thanks.

-- PMM
