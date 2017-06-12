Received: from eggs.gnu.org ([2001:4830:134:3::10]:58862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKTly-0006Xh-PS
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKTly-0000Ya-1A
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:09:06 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKTlx-0000YC-QD
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:09:05 -0400
Received: by mail-wr0-x22d.google.com with SMTP id q97so107788511wrb.2
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 11:09:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+194DyFJ=grKX6o9LAUeXHAJgX92gc419+Aa64_PHig@mail.gmail.com>
References: <20170608070716.2954-1-kraxel@redhat.com>
	<CAFEAcA9+194DyFJ=grKX6o9LAUeXHAJgX92gc419+Aa64_PHig@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jun 2017 19:08:44 +0100
Message-ID: <CAFEAcA9YuwACfrciwQnHV-S60AMYZoaNzTKecEE7KzuCt2Wtyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] ui patch queue
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

On 12 June 2017 at 19:00, Peter Maydell <peter.maydell@linaro.org> wrote:
> This causes configure to barf warnings in my build logs on half
> my build machines:
>
> WARNING: Support for gtk2 will be dropped in future releases.
> WARNING: Please consider using gtk3 instead.
>
> I don't think it is yet possible to drop gtk2.

Oh, one of them was the warning about SDL1.2.

thanks
-- PMM
