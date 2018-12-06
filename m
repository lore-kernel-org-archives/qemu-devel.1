Received: from eggs.gnu.org ([2001:4830:134:3::10]:53764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUrbX-0006LJ-Ep
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUrbR-0005k6-9D
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:14:03 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:37327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUrbR-0005it-1b
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:13:57 -0500
Received: by mail-ot1-x32e.google.com with SMTP id 40so59106oth.4
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 03:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20181206084816.30485-1-ppandit@redhat.com>
	<BN6PR18MB1220A0A33454573CA39058659FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
	<CAFEAcA_B3FNQXLP4YnL70EPoFUbM89Dh1eFdZSVzpkJrgt+j_g@mail.gmail.com>
	<BN6PR18MB12207477BC1FC04674F98A2E9FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
	<CAFEAcA_jT-KzFUmRRPNt-kUDMFAaBzT7Li_ESyuzMUTWdTVZeQ@mail.gmail.com>
	<CAKXe6S+N_TDs6b=TqWM2POQyOHuWw=CaJOtteaVfYONkYbjc3w@mail.gmail.com>
	<CAFEAcA-vT-bOOMZLkvJtXX1v0Tgv3tTLFh=mnbq+C=y=W-L11Q@mail.gmail.com>
	<CAKXe6S+70iAr6CinZWNiBKgQo+hL5VQaY2p_iH0EQuRFXRWS0Q@mail.gmail.com>
In-Reply-To: <CAKXe6S+70iAr6CinZWNiBKgQo+hL5VQaY2p_iH0EQuRFXRWS0Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 11:13:44 +0000
Message-ID: <CAFEAcA8QNuJEDZe3-6PbZyrC8iGDTHBYRyZXcZL0SeyYSKk+OA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: li qiang <liq3ea@outlook.com>, P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, public@hansmi.ch, Prasad J Pandit <pjp@fedoraproject.org>, "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>

On Thu, 6 Dec 2018 at 11:12, Li Qiang <liq3ea@gmail.com> wrote:
> OK, next time I will report it directly like what I did before.

Thank you -- I appreciate that.

-- PMM
