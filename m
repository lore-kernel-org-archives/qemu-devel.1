Received: from eggs.gnu.org ([209.51.188.92]:55871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go6rj-0006xf-Um
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go6rj-0003Or-3Z
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:22:19 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go6ri-0003Mi-Tj
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:22:19 -0500
Received: by mail-oi1-x244.google.com with SMTP id y23so12977085oia.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 05:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20190124141147.8416-1-stefanha@redhat.com>
In-Reply-To: <20190124141147.8416-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 13:22:03 +0000
Message-ID: <CAFEAcA_-BJFvz+gynbPsWpTvT4hiOsPPN6Ten3tn4v5CMDcuMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/microbit-test: Add tests for nRF51
 NVMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Thu, 24 Jan 2019 at 14:11, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> This resolves the conflict with Julia's UART test series due to
> global_qtest removal.
>
>  tests/microbit-test.c | 108 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)



Applied to target-arm.next, thanks.

-- PMM
