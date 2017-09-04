Received: from eggs.gnu.org ([2001:4830:134:3::10]:56284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dopHD-00082E-2E
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 07:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dopH8-0005uy-LE
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 07:10:47 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dopH8-0005tX-9x
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 07:10:42 -0400
Received: by mail-wm0-x233.google.com with SMTP id 187so1317067wmn.1
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 04:10:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJhHMCDgm8RRO42PXDOEYE8oZf5OLSBZo+akM1Kx8bOJLTSYCA@mail.gmail.com>
References: <20170829173226.7625-1-bobby.prani@gmail.com>
	<CAJhHMCDgm8RRO42PXDOEYE8oZf5OLSBZo+akM1Kx8bOJLTSYCA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 12:10:20 +0100
Message-ID: <CAFEAcA822caMzc16XErE4-LO_sqLuiPBV+bR67sM+1_f9jx7fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] arm_gicv3_kvm: Fix compile warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: "open list:ARM cores" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 31 August 2017 at 17:56, Pranith Kumar <bobby.prani@gmail.com> wrote:
> CC'ing stable for 2.10.

Thanks; applied to target-arm.next (with a tweaked commit message).

-- PMM
