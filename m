Received: from eggs.gnu.org ([2001:4830:134:3::10]:51492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8Qqf-0000sb-0W
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8Qqc-0004dB-9I
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:40:41 -0400
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:43248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8Qqc-0004d3-4B
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:40:38 -0400
Received: by mail-vk0-x233.google.com with SMTP id v134so11770211vkd.10
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 06:40:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAFEAcA-FaS+HeihGmbhrLAR8e=jmz-Og+OKGakGX7MGb_KgwCw@mail.gmail.com>
	<d002e4ff-e0c9-f66e-a25a-51605a79b55f@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <942ca9c4-9f23-424b-fcd5-b6758f4ad675@amsat.org>
Date: Tue, 17 Apr 2018 10:40:33 -0300
MIME-Version: 1.0
In-Reply-To: <d002e4ff-e0c9-f66e-a25a-51605a79b55f@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Last call for release-critical fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Stefan,

On 04/17/2018 10:19 AM, Stefan Weil wrote:
> Update po files? That's not a "must fix", but it would be nice to have
> those files synchronized with ui/gtk.c again.

Isn't it now fixed by
https://github.com/qemu/qemu/commit/2a6b5372d7bad038fe27f9c60e85ef5c8a15e311
?

Regards,

Phil.
