Received: from eggs.gnu.org ([209.51.188.92]:50440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmIHe-0008Lu-7D
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmIHd-0004K2-E1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:09:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmIHd-0004JJ-1F
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:09:33 -0500
References: <20190123120759.7162-1-jusual@mail.ru>
	<20190123120759.7162-4-jusual@mail.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b5ba93ed-2dcd-eab2-024e-20c6f505f3b2@redhat.com>
Date: Wed, 23 Jan 2019 14:09:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190123120759.7162-4-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/3] tests/microbit-test: Check nRF51
 UART functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>

On 2019-01-23 13:07, Julia Suvorova wrote:
> Some functional tests for:
>     Basic reception/transmittion
>     Suspending
>     INTEN* registers
> 
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  tests/microbit-test.c | 89 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)

Acked-by: Thomas Huth <thuth@redhat.com>
