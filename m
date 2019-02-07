Received: from eggs.gnu.org ([209.51.188.92]:34858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1groFr-0001tO-4z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1groFg-0007pj-3k
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:18:25 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:40684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1groFb-0007hB-8u
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:18:16 -0500
Received: by mail-ot1-x32f.google.com with SMTP id s5so1409176oth.7
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20190206213042.12537-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190206213042.12537-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 18:18:01 +0000
Message-ID: <CAFEAcA-xRfcUNQk_8vJyxbEA6GQj=31UpGWhj_bjdZVoFrreiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] qemu-sparc queue 20190206
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 6 Feb 2019 at 21:30, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit 47994e16b1d66411953623e7c0bf0cdcd50bd507:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190205' into staging (2019-02-05 18:25:07 +0000)
>
> are available in the git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-sparc-20190206
>
> for you to fetch changes up to 6031ff8b0ad0feee58cd46ebb0c8d2a6a48d616e:
>
>   sun4m: pass initrd size to OpenBIOS via fw_cfg interface (2019-02-06 21:07:53 +0000)
>
> ----------------------------------------------------------------
> qemu-sparc queue
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
