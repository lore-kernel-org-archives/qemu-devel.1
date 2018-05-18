Received: from eggs.gnu.org ([2001:4830:134:3::10]:41644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJe28-0005Jm-II
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJe27-0000q8-St
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:58:52 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:44702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJe27-0000oo-O2
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:58:51 -0400
Received: by mail-oi0-x235.google.com with SMTP id e80-v6so6853087oig.11
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 04:58:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518074052.31724-1-kraxel@redhat.com>
References: <20180518074052.31724-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 12:58:29 +0100
Message-ID: <CAFEAcA-13cZ2OYrkkWaAeVFHr-MADU8ZkZmmQJgbfYF2G2732Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Ui 20180518 patches
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

On 18 May 2018 at 08:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit a4207e3b00e89f934adb231057dcf9a75ac2ae45:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-17 11:59:50 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180518-pull-request
>
> for you to fetch changes up to e8dcb8ae5121965ac8c89e6b277ac127e9d08452:
>
>   sdl: Move use of surface pointer below check for whether it is NULL (2018-05-18 09:14:24 +0200)
>
> ----------------------------------------------------------------
> ui: bugfixes, move x11 dependency to modules.
>
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
