Received: from eggs.gnu.org ([2001:4830:134:3::10]:34603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pKI-0002Mh-Al
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pKF-0001JG-9i
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:52:22 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:52013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pKF-0001J3-5O
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:52:19 -0400
Received: by mail-qt0-x230.google.com with SMTP id h4so28718930qtk.8
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 19:52:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aa8b321d-c606-2cd7-d73c-9fafd01dccb4@amsat.org>
Date: Mon, 23 Oct 2017 23:52:15 -0300
MIME-Version: 1.0
In-Reply-To: <20171020232023.15010-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 11/52] tcg: Change temp_allocate_frame
 arg to TCGTemp
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
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tcg/tcg.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
