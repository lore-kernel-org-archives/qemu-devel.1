Received: from eggs.gnu.org ([208.118.235.92]:47292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfBUZ-0005U0-H6
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 17:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfBUU-0000bF-PT
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 17:29:31 -0500
Received: from mail-it1-x134.google.com ([2607:f8b0:4864:20::134]:40746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gfBUU-00087c-K1
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 17:29:26 -0500
Received: by mail-it1-x134.google.com with SMTP id h193so44674803ita.5
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 14:29:10 -0800 (PST)
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAFEAcA8Xb1DeTTus7vwfQXDGC8ETR5a9Egg4nVN=+cLy0xm2dQ@mail.gmail.com>
	<a08068ab-88ae-4068-d4d6-3a3c4a968893@redhat.com>
	<5be74ec4-8a56-a479-85b0-49817a4aaf9c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d78fe10-c72c-0cff-21e9-27f33ca882b6@linaro.org>
Date: Fri, 4 Jan 2019 08:29:00 +1000
MIME-Version: 1.0
In-Reply-To: <5be74ec4-8a56-a479-85b0-49817a4aaf9c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/44] MIPS pull request for December
 2018 - v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 1/4/19 12:06 AM, Thomas Huth wrote:
> Maybe we could / should enforce compiling with -std=gnu11 now? That
> would also fix the problem with the duplicated typedefs on older
> compilers, see e.g.:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html

I'm all for it.


r~
