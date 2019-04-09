Received: from eggs.gnu.org ([209.51.188.92]:40806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDsfg-0008Ng-Jt
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDsfd-0001L7-VN
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:28:24 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDsfc-0001AS-Q2
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:28:21 -0400
Received: by mail-oi1-x243.google.com with SMTP id y84so13859576oia.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190409134536.15548-1-philmd@redhat.com>
	<CAFEAcA9pc3Dw_X5b74+av0qq5hM7wB4uixSuh_TLwHAm8eGsqA@mail.gmail.com>
	<e89332f2-1673-5192-6ad1-b4ade1b458eb@redhat.com>
In-Reply-To: <e89332f2-1673-5192-6ad1-b4ade1b458eb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 16:27:59 +0100
Message-ID: <CAFEAcA8xexPWoBdQDYy8SsOD+OfoMSh=yHC-11DOcN5jp6888g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2
 EFIROM variable clash, pass CFLAGS to EDK2 build tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Olaf Hering <olaf@aepfle.de>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Tue, 9 Apr 2019 at 16:25, Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 04/09/19 16:00, Peter Maydell wrote:
> > Thanks. This is one of a handful of remaining bugs we
> > should fix for 4.0, so I would ideally like to get this
> > in rc3 today (or tomorrow if we have to slip rc3 a day).
> > If people wanting to review this series could do so
> > promptly I'd definitely appreciate it.
>
> I hope I was quick enough.

Yep, thanks. (I knew you'd had comments on v1 so I was
assuming you'd want to review v2.)

thanks
-- PMM
