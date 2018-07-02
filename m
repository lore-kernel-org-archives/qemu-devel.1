Received: from eggs.gnu.org ([2001:4830:134:3::10]:58342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa28b-0006Ik-Cp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa28a-000325-K8
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:57:17 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:46473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fa28a-00031V-DY
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:57:16 -0400
Received: by mail-oi0-x22c.google.com with SMTP id y207-v6so17627415oie.13
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:57:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702154222.3130-1-kraxel@redhat.com>
References: <20180702154222.3130-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 17:56:55 +0100
Message-ID: <CAFEAcA8fi90Zd5oC2V8jewSVjfk=eGAfs+iLA=41J1XA9Ea4ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Seabios 1.11.2 20180702 patches
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

On 2 July 2018 at 16:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 2d58e33ec1b76990f09bc1e3412e0b36e1ac4634:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-3.0-pull-request' into staging (2018-07-02 13:43:10 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/seabios-1.11.2-20180702-pull-request
>
> for you to fetch changes up to 9f5d9c19c7d9c6eca21802a2777da0119bc22749:
>
>   ramfb: enable vgabios (2018-07-02 17:21:52 +0200)
>
> ----------------------------------------------------------------
> seabios: update to release 1.11.2, add/update configuration.
> vgabios: remove (old unused lgpl'ed vgabios).
> ramfb,bochs-display: use new vgabios roms.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
