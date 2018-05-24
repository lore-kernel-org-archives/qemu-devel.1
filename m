Received: from eggs.gnu.org ([2001:4830:134:3::10]:53430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLu7J-0006Ty-Rn
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLu7J-0005Qu-46
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:33:33 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:41236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLu7I-0005Qk-UX
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:33:33 -0400
Received: by mail-oi0-x22a.google.com with SMTP id 11-v6so2190833ois.8
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 10:33:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180524154556.17876-1-kraxel@redhat.com>
References: <20180524154556.17876-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 18:33:11 +0100
Message-ID: <CAFEAcA-ZUvCRkp82J4oH4MVdPPeY1sTihr+e9AM3ngvPJTQ3+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Vga 20180524 patches
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

On 24 May 2018 at 16:45, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79cd466d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-05-22 09:43:58 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20180524-pull-request
>
> for you to fetch changes up to dbb2e4726c76dbffb39efe6623bf75d2ec1db8bc:
>
>   MAINTAINERS: add vga entries (2018-05-24 10:42:13 +0200)
>
> ----------------------------------------------------------------
> vga: catch depth 0
> hw/display: add new bochs-display device
> some cleanups.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
