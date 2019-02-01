Received: from eggs.gnu.org ([209.51.188.92]:40229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbqU-0001QJ-Bn
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbqT-0001oX-9C
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:39:14 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:38806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbqR-0001kL-Bf
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:39:13 -0500
Received: by mail-oi1-x234.google.com with SMTP id a77so6288807oii.5
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20190201123100.27419-1-kraxel@redhat.com>
In-Reply-To: <20190201123100.27419-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Feb 2019 16:38:58 +0000
Message-ID: <CAFEAcA8C45zyqatqRTXr8tgCv0xGvArDRBrjjZ4bhbm9wXWkOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Ui 20190201 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Michael Walle <michael@walle.cc>

On Fri, 1 Feb 2019 at 12:35, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e8977901b79fb678f288dd372261b640bbeccd0d:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-01-31 15:40:39 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190201-pull-request
>
> for you to fetch changes up to 0015ca5cbabe0b31d31610ddfaafd90a9e5911a4:
>
>   ui: remove support for SDL1.2 in favour of SDL2 (2019-02-01 11:59:12 +0100)
>
> ----------------------------------------------------------------
> ui: fix build with SDL disabled, drop SDL1 support.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
