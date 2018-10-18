Received: from eggs.gnu.org ([2001:4830:134:3::10]:49655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDB8G-0000An-OQ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 12:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDB8G-0008Lv-1Y
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 12:26:44 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDB8F-0008LI-KT
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 12:26:43 -0400
Received: by mail-oi1-x241.google.com with SMTP id l197-v6so24482219oib.8
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 09:26:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8736t3bsn9.fsf@dusky.pond.sub.org>
References: <20181009060835.4608-1-armbru@redhat.com>
	<8736t3bsn9.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 17:26:22 +0100
Message-ID: <CAFEAcA9Arp9Br55hZ9dVMOc71YrcAfe-3nAvmhUV=hqF75WQXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] ssi-sd: Make devices picking up
 backends unavailable with -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 18 October 2018 at 08:50, Markus Armbruster <armbru@redhat.com> wrote:
> Peter, would you be willing to take this through your ARM tree?

Sure; applied to target-arm.next.

thanks
-- PMM
