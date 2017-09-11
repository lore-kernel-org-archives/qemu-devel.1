Received: from eggs.gnu.org ([2001:4830:134:3::10]:35433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drVuc-0005N2-MW
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drVuX-0006IP-Ng
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:06:34 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drVuX-0006Hm-Ig
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:06:29 -0400
Received: by mail-qt0-x241.google.com with SMTP id q8so6302360qtb.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 14:06:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170911022839.23231-1-f4bug@amsat.org>
	<1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
	<CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
	<dd244160-8b53-22bc-cf97-9948fb34f0f6@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fe1fc600-ee0c-88a9-b286-2fe957d78079@amsat.org>
Date: Mon, 11 Sep 2017 18:06:25 -0300
MIME-Version: 1.0
In-Reply-To: <dd244160-8b53-22bc-cf97-9948fb34f0f6@weilnetz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Stefan,

On 09/11/2017 05:26 PM, Stefan Weil wrote:> I had an assertion because 
of a missing qemu-ga
> when I‌ only had run "make check", so there is a
> dependency (perhaps check: tools) missing.
> 
> Now "make check" is running fine with all targets
> (at least until check-qtest-ppc64). Sorry, I have
> to finish for today.

I had this patch in my travis-ci queue, here extracted alone:
https://patchwork.kernel.org/patch/9948117/

Regards,

Phil.
