Received: from eggs.gnu.org ([2001:4830:134:3::10]:39469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csWR3-0004iI-Dj
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csWR2-0006MW-Nk
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:19:57 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csWR2-0006M5-I8
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:19:56 -0400
Received: by mail-wr0-x22b.google.com with SMTP id u1so61708248wra.2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 08:19:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <871sti694y.fsf@linaro.org>
References: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
	<CAFEAcA8UYsjy6sBTGqk1Crd-0tWpF0WWukA03_GyNRaG95L07Q@mail.gmail.com>
	<87d1d8xn41.fsf@linaro.org>
	<CAFEAcA-VQHv-wD+2NBwYAe75139+37qkaypCbKOoHHk5ZRr-QA@mail.gmail.com>
	<87bmssxm9s.fsf@linaro.org> <1490621384.31035.30.camel@redhat.com>
	<871sti694y.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Mar 2017 16:19:34 +0100
Message-ID: <CAFEAcA_-L8FkHATm1+WaXTxOLTtd4k75ao04+Vta7QdfSi8pFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1675108] [NEW] Cocoa UI always crashes on
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bug 1675108 <1675108@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>

On 27 March 2017 at 16:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> I've got two patches in my tree at the moment. I was holding off posting
> the series to see if I could make more progress with the record/replay
> bug.

rc candidates are cut on Tuesdays, so it's better in general not
to sit on a fix for rc bugs if it causes them to miss going into
the next rc tag.

thanks
-- PMM
