Received: from eggs.gnu.org ([2001:4830:134:3::10]:45144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2Wr-0001UI-1o
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2Wq-00062S-8W
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:31:09 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC2Wq-000624-4Y
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:31:08 -0400
Received: by mail-oi0-x244.google.com with SMTP id b130-v6so1404120oif.12
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 05:31:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427102033.20232-1-kraxel@redhat.com>
References: <20180427102033.20232-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 13:30:46 +0100
Message-ID: <CAFEAcA_GSBWM5wV3jVTFb-5JKHwoN=ysdoidN0LB5ffogkRVGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20180427 patches
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

On 27 April 2018 at 11:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit b8846a4d6352b2a1d2012f8b3b9115640524aeda:
>
>   vl.c: new function serial_max_hds() (2018-04-26 13:58:29 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180427-pull-request
>
> for you to fetch changes up to 0f5c642d49c3a843bd8b8790d7014fd84bcf6405:
>
>   ccid-card: include libcacard.h only (2018-04-27 10:57:09 +0200)
>
> ----------------------------------------------------------------
> usb: ccid bugfix, misc small improvements.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
