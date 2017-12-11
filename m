Received: from eggs.gnu.org ([2001:4830:134:3::10]:60837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eOTxz-0005lK-IY
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eOTxw-00072c-Fu
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:42:19 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eOTxw-0006yc-8f
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:42:16 -0500
Date: Mon, 11 Dec 2017 14:42:13 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171211194213.GA4200@flamenco>
References: <1513006964-3371-1-git-send-email-peter.maydell@linaro.org>
	<db0d2fd0-ae95-b9f8-47a7-d273306a2432@twiddle.net>
	<CAFEAcA_ezdp_ygjT2r9P7niSnOqRxAMUJ+vhaMk4HJTSrEjrJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_ezdp_ygjT2r9P7niSnOqRxAMUJ+vhaMk4HJTSrEjrJQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11?] target/arm: Generate UNDEF for
 32-bit Thumb2 insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Dec 11, 2017 at 17:32:48 +0000, Peter Maydell wrote:
> Thanks. I think I have come down on the side of putting this into
> 2.11, so rolling an rc5 today, and delaying the final release
> a day to Wednesday.

Glad to see it's in -rc5 -- thanks for fixing this so quickly!

Again, apologies for not having caught this earlier ;-(

		Emilio
