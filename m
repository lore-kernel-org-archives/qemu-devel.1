Received: from eggs.gnu.org ([2001:4830:134:3::10]:38864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnoT2-0006yb-Cl
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnoT1-0008FT-J4
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:11:20 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:51135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fnoT1-0008EN-Bx
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:11:19 -0400
Received: by mail-wm0-x242.google.com with SMTP id s12-v6so951717wmc.0
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 10:11:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180808210750.3915-4-jusual@mail.ru>
References: <20180808210750.3915-1-jusual@mail.ru>
	<20180808210750.3915-4-jusual@mail.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 9 Aug 2018 18:11:17 +0100
Message-ID: <CAJSP0QUXfGCCPd_XO7o_fs7LfPLyFB+enH4zr2qi3_6JbQ6cDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] tests/boot-serial-test: Add
 microbit board testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On Wed, Aug 8, 2018 at 10:07 PM, Julia Suvorova <jusual@mail.ru> wrote:
> New mini-kernel test for nRF51 SoC UART.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  tests/boot-serial-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
