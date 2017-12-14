Received: from eggs.gnu.org ([2001:4830:134:3::10]:41198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePYrw-0000os-I2
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePYrv-0007iw-Sd
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:08:32 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:37698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePYrv-0007iU-O9
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:08:31 -0500
Received: by mail-ot0-x236.google.com with SMTP id s4so5835716ote.4
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 11:08:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cfaa75b2-0da8-847d-0328-ec291ae81001@redhat.com>
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
	<d4d649fc-4bb2-9b61-7e48-46a6a51e7b01@redhat.com>
	<CAMr-obuvJ4z54e0evM+J98jsdRayL-UeA_WDQVp0rx=sRoTVgw@mail.gmail.com>
	<874lotwb0w.fsf@dusky.pond.sub.org>
	<cfaa75b2-0da8-847d-0328-ec291ae81001@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2017 19:08:10 +0000
Message-ID: <CAFEAcA-13FJr=pscaLCtOZ0joG2Hm9m5iOuuK0xmLjSwG95U3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/6] QTests: use Python to run
 complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Nir Soffer <nirsof@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On 14 December 2017 at 17:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
> And also in software collections.  For 2.12 (as part of the above "drop
> Python 2.x support" plan)

I'm reluctant to require a non-system python on OSX to build.

thanks
-- PMM
