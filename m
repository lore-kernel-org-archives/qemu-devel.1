Received: from eggs.gnu.org ([2001:4830:134:3::10]:37995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgDC1-0002d2-Ed
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgDBy-0008LT-QC
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:21:33 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgDBy-0008KQ-Hi
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:21:30 -0500
Received: by mail-wm0-x22a.google.com with SMTP id v186so115804647wmd.0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 08:21:30 -0800 (PST)
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
	<1486046099-17726-14-git-send-email-batuzovk@ispras.ru>
	<2089cbe3-0e9b-fae2-0e35-224f2765dc28@amsat.org>
	<32a902a1-e8c7-c2f7-ac66-148e02ee0b2d@amsat.org>
	<alpine.DEB.2.11.1702211623360.2358@bulbul.intra.ispras.ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <alpine.DEB.2.11.1702211623360.2358@bulbul.intra.ispras.ru>
Date: Tue, 21 Feb 2017 16:21:35 +0000
Message-ID: <877f4jwm40.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2.1 13/21] tcg/i386: support remaining
 vector addition operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Kirill Batuzov <batuzovk@ispras.ru> writes:

> On Tue, 21 Feb 2017, Philippe Mathieu-Daudé wrote:
>
>> Hi Kirill,
>>
>> could you check my previous comment?
>>
>
> Hi Philippe,
>
> thank you for your comments. I've seen them and I'll apply changes you
> suggested in the next version of the series. I was just hoping to get
> a bit more feedback before I proceed to v3.

It is on my list to look at - however I'm in a bit of a crunch getting
the MTTCG stuff prepared before code freeze as well as preparing for a
company conference. Once that's out of the way I'll have a bit more
review time!

--
Alex Bennée
