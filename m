Received: from eggs.gnu.org ([2001:4830:134:3::10]:37287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fpdAH-0002OZ-5e
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fpdA2-0002Xo-3V
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:31:29 -0400
MIME-Version: 1.0
References: <20180813184624.12071-1-stefanha@redhat.com>
	<20180813184624.12071-7-stefanha@redhat.com>
	<012316fe-edc8-689a-b328-d84e2268a7e4@amsat.org>
In-Reply-To: <012316fe-edc8-689a-b328-d84e2268a7e4@amsat.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 Aug 2018 17:22:09 +0100
Message-ID: <CAJSP0QWKC71JiXu8TKG1PSHhZA4QT6deLD5A=Mfryjo=A+TY9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 6/6] Add QTest testcase for
 the Intel Hexadecimal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <qemu.ml@steffen-goertz.de>, =?UTF-8?B?6IuP6Iiq?= <suhang16@mails.ucas.ac.cn>, Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>

On Tue, Aug 14, 2018 at 5:18 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> On 08/13/2018 03:46 PM, Stefan Hajnoczi wrote:
> > From: Su Hang <suhang16@mails.ucas.ac.cn>
> >
> > 'test.hex' file is a memory test pattern stored in Hexadecimal Object
> > Format.  It loads at 0x10000 in RAM and contains values from 0 through
> > 255.
>
> Please add this comment in the source file.

Will fix.

Stefan
