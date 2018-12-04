Received: from eggs.gnu.org ([2001:4830:134:3::10]:37641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gU77q-0000j7-L6
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 04:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gU77p-00009m-Ui
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 04:36:18 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:41676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gU77p-000093-Hi
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 04:36:17 -0500
Received: by mail-oi1-x22a.google.com with SMTP id j21so13669214oii.8
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 01:36:17 -0800 (PST)
MIME-Version: 1.0
References: <20181203195039.29597-1-kraxel@redhat.com>
In-Reply-To: <20181203195039.29597-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 09:36:04 +0000
Message-ID: <CAFEAcA9C8FeWv0W=QMZo9+2Wofi8ut+_KupYYhuVY9Unb2cEjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Fixes 31 20181203 patches
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

On Mon, 3 Dec 2018 at 19:51, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 039d4e3df0049bdd8f93a2de735a816483b13954:
>
>   scsi: Address spurious clang warning (2018-11-27 23:56:12 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-31-20181203-pull-request
>
> for you to fetch changes up to c52d46e041b42bb1ee6f692e00a0abe37a9659f6:
>
>   usb-mtp: outlaw slashes in filenames (2018-12-03 19:40:17 +0100)
>
> ----------------------------------------------------------------
> usb: mtp fixes.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (2):
>   usb-mtp: fix utf16_to_str
>   usb-mtp: outlaw slashes in filenames
>
>  hw/usb/dev-mtp.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
Applied, thanks.

-- PMM
