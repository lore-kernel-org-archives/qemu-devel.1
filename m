Received: from eggs.gnu.org ([209.51.188.92]:57582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghqR5-00027x-4z
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghqR3-0006zQ-1t
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:36:55 -0500
MIME-Version: 1.0
References: <20190110094020.18354-1-stefanha@redhat.com>
	<20190110094020.18354-3-stefanha@redhat.com>
	<cd32de08-afd0-4b8b-a10a-99e1d88d1755@redhat.com>
	<5cc00012-1929-22a0-cbf8-14573b083ae7@mail.ru>
In-Reply-To: <5cc00012-1929-22a0-cbf8-14573b083ae7@mail.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 11 Jan 2019 06:36:30 +0000
Message-ID: <CAJSP0QUzKzJ9FNC5O+i64J3Tw3oR61TODnYGnsHeW27JhKoftQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests/microbit-test: add TWI stub
 device test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 10, 2019 at 10:12 AM Julia Suvorova via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> On 10.01.2019 12:48, Thomas Huth wrote:
> > On 2019-01-10 10:40, Stefan Hajnoczi wrote:
> > Any chance that you could use qemu_writel() right from the start here?
> > That will make it easier to finally get rid of global_qtest one day...
>
> I'll send a patch soon to fix it.
> But this test can be merged without corrections.

Thank you, Julia!

Stefan
