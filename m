Received: from eggs.gnu.org ([208.118.235.92]:49762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehec5-00063E-A2
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eheYB-0004sm-La
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:54:57 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:33420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eheYB-0004s5-BK
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:50:55 -0500
Received: by mail-ot0-x232.google.com with SMTP id q9so9912387oti.0
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 08:50:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202075009.11653-1-kraxel@redhat.com>
References: <20180202075009.11653-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2018 16:26:27 +0000
Message-ID: <CAFEAcA8Ym__V=mLbQob1FW5=ZQaKkFrTwd8H21q1aFFRfrbwsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Audio 20180202 patches
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

On 2 February 2018 at 07:50, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit b05631954d6dfe93340d516660397e2c1a2a5dd6:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180131' into staging (2018-01-31 15:50:29 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20180202-pull-request
>
> for you to fetch changes up to 8ec660b80ed511fa333679e38bf0cf714799d6fa:
>
>   hw/audio/sb16.c: change dolog() to qemu_log_mask() (2018-02-02 08:19:47 +0100)
>
> ----------------------------------------------------------------
> audio: two small fixes.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
