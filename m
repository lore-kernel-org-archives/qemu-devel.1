Received: from eggs.gnu.org ([2001:4830:134:3::10]:33697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pDU-0008CF-B8
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pDQ-0006R3-6l
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:45:20 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:48139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pDP-0006Qo-Sd
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:45:16 -0400
Received: by mail-qt0-x235.google.com with SMTP id f8so28725879qta.5
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 19:45:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <923e3eda-b557-b7fa-c27b-99b7681df221@amsat.org>
Date: Mon, 23 Oct 2017 23:45:12 -0300
MIME-Version: 1.0
In-Reply-To: <20171020232023.15010-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 05/52] tcg: Introduce arg_temp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On 10/20/2017 08:19 PM, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tcg/tcg.h      |  5 +++++
>  tcg/optimize.c |  4 ++--
>  tcg/tcg.c      | 51 +++++++++++++++++++++++++--------------------------
>  3 files changed, 32 insertions(+), 28 deletions(-)
