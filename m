Received: from eggs.gnu.org ([209.51.188.92]:57705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD7bT-0001aB-Nm
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD7bR-0007nS-Qk
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:12:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hD7bP-0007lD-KZ
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:12:51 -0400
Received: by mail-ot1-x344.google.com with SMTP id u15so9591807otq.10
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 06:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <2D646E18-7F28-4F06-9F3D-D5F8A1408FAC@me.com>
	<CAFEAcA_cwH+LH7kzfysQ6Ka98JRX5xf3NgeJo6+0vtuyxP=2ew@mail.gmail.com>
	<7CD2D067-C9F5-435C-97A0-2ED23CA2A20B@me.com>
	<CAFEAcA-VgDpR+jdRFXxw00vtqdd5OZ5N_-xQBC5eFe7LX9M=dQ@mail.gmail.com>
	<C847199D-0619-494F-9376-E8D9C382A4F0@me.com>
	<CE17AB4A-6AF8-4130-937B-301BB974C06A@me.com>
In-Reply-To: <CE17AB4A-6AF8-4130-937B-301BB974C06A@me.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 7 Apr 2019 14:12:38 +0100
Message-ID: <CAFEAcA8M-UdLrD6D=2SAvY2YQAJ8JF8+yxh5uD-Lo0aJCb_BKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa: Fix absolute input device
 grabbing issues on Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Zhang <tgfbeta@me.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Sat, 6 Apr 2019 at 04:04, Chen Zhang <tgfbeta@me.com> wrote:
>
> ping
>
> http://patchwork.ozlabs.org/patch/1058186/

This needs changes to be able to compile with OSX 10.10.

thanks
-- PMM
