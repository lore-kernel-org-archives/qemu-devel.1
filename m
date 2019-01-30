Received: from eggs.gnu.org ([209.51.188.92]:56936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gosyz-00038J-Qd
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gosyz-00051M-6r
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:45:01 -0500
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<871s4uobf0.fsf@dusky.pond.sub.org>
	<CAFEAcA_t2707yp5cz+rbMVE3nhLk288iFgK=vUgzFyCw79uX5g@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <75629302-84bb-ba19-cb2c-5edc34cffadb@redhat.com>
Date: Wed, 30 Jan 2019 17:44:52 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_t2707yp5cz+rbMVE3nhLk288iFgK=vUgzFyCw79uX5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 01/30/19 16:24, Peter Maydell wrote:

> Well, nobody who does anything with x86 has cared enough to
> make the pflash implementation actually correct.

I feel sort of included under this umbrella, so:

I haven't been aware of any particular pflash implementation errors. I
"didn't care" because it "worked fine" as much as I could tell.

Thanks
Laszlo
